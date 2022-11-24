---
title: "Service Operations"
type: docs
description: "Getting the service up and running"
weight: 20
---

In this section you can find the common operational activities related to keep
the service available to our users.

## Initial set-up

### Notebooks VO

The resources used for the Notebooks deployments are managed with the
`vo.notebooks.egi.eu` VO. Operators of the service should join the VO, check the
entry at the
[operations portal](https://operations-portal.egi.eu/vo/view/voname/vo.notebooks.egi.eu)
and at [AppDB](https://appdb.egi.eu/store/vo/vo.notebooks.egi.eu).

### Clients installation

In order to manage the resources you will need these tools installed on your
client machine:

- `fedcloudclient` for discovering sites and managing tokens,
- `terraform` to create the VMs at the providers,
- `ansible` to configure the VMs and install kubernetes at the providers,
- `terraform-inventory` to get the list of hosts to use from terraform.

### Get the configuration repository

All the configuration of the notebooks is stored at a git repository available
in GitHub.
Start by cloning the repo:

```shell
git clone https://github.com/EGI-Federation/notebooks-operations
```

## Kubernetes

We use `terraform` and `ansible` to build the cluster at one of the EGI Cloud
providers. If you are building the cluster for the first time, create a new
directory on your local git repository from the template, add it to the repo,
and get `terraform` ready:

```shell
cp -a template <new provider>
git add <new provider>
cd <new provider>/terraform
terraform init
```

Using the `fedcloud` you can get set the right environment for interacting with
the OpenStack APIs of a given site:

```shell
eval "$(fedcloud site show-project-id --site CESGA --vo vo.notebooks.egi.eu)"
```

Whenever you need to get a valid token for the site and VO, you can obtain it with:

```shell
OS_TOKEN=$(fedcloud openstack --site CESGA --vo vo.notebooks.egi.eu \
           token issue -c id -f value)
```

First get the network IDs and pool to use for the site:

<!-- markdownlint-disable line-length -->
```shell
$ fedcloud openstack --site CESGA --vo vo.notebooks.egi.eu network list
+--------------------------------------+-------------------------+--------------------------------------+
| ID                                   | Name                    | Subnets                              |
+--------------------------------------+-------------------------+--------------------------------------+
| 1aaf20b6-47a1-47ef-972e-7b36872f678f | net-vo.notebooks.egi.eu | 6465a327-c261-4391-a0f5-d503cc2d43d3 |
| 6174db12-932f-4ee3-bb3e-7a0ca070d8f2 | public00                | 6af8c4f3-8e2e-405d-adea-c0b374c5bd99 |
+--------------------------------------+-------------------------+--------------------------------------+
```
<!-- markdownlint-enable line-length -->

In this case we will use `public00` as the pool for public IPs and
`1aaf20b6-47a1-47ef-972e-7b36872f678f` as the network ID. Check with the
provider which is the right network to use. Use these values in the
`terraform.tfvars` file:

```terraform
ip_pool = "public00"
net_id  = "1aaf20b6-47a1-47ef-972e-7b36872f678f"
```

You may want to check the right flavors for your VMs and adapt other variables
in `terraform.tfvars`. To get a list of flavors you can use:

<!-- markdownlint-disable line-length -->
```shell
$ fedcloud openstack --site CESGA --vo vo.notebooks.egi.eu flavor list
+--------------------------------------+----------------+-------+------+-----------+-------+-----------+
| ID                                   | Name           |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+----------------+-------+------+-----------+-------+-----------+
| 26d14547-96f2-4751-a686-f89a9f7cd9cc | cor4mem8hd40   |  8192 |   40 |         0 |     4 | True      |
| 42eb9c81-e556-4b63-bc19-4c9fb735e344 | cor2mem2hd20   |  2048 |   20 |         0 |     2 | True      |
| 4787d9fc-3923-4fc9-b770-30966fc3baee | cor4mem4hd40   |  4096 |   40 |         0 |     4 | True      |
| 58586b06-7b9d-47af-b9d0-e16d49497d09 | cor24mem62hd60 | 63488 |   60 |         0 |    24 | True      |
| 635c739a-692f-4890-b8fd-d50963bff00e | cor1mem1hd10   |  1024 |   10 |         0 |     1 | True      |
| 6ba0080d-d71c-4aff-b6f9-b5a9484097f8 | small          |   512 |    2 |         0 |     1 | True      |
| 6e514065-9013-4ce1-908a-0dcc173125e4 | cor2mem4hd20   |  4096 |   20 |         0 |     2 | True      |
| 85f66ce6-0b66-4889-a0bf-df8dc23ee540 | cor1mem2hd10   |  2048 |   10 |         0 |     1 | True      |
| c4aa496b-4684-4a86-bd7f-3a67c04b1fa6 | cor24mem50hd50 | 51200 |   50 |         0 |    24 | True      |
| edac68c3-50ea-42c2-ae1d-76b8beb306b5 | test-bigHD     |  4096 |  237 |         0 |     2 | True      |
+--------------------------------------+----------------+-------+------+-----------+-------+-----------+
```
<!-- markdownlint-enable line-length -->

Finally ensure your public ssh key is also listed in the `cloud-init.yaml` file
and then you are ready to deploy the cluster with:

```shell
terraform apply
```

Your VMs are up and running, it\'s time to get kubernetes configured and running
with ansible.

The following ansible role needs to be installed first:

```shell
ansible-galaxy install grycap.kubernetes
```

and then:

```shell
cd ..   # you should be now in <new provider>
ANSIBLE_TRANSFORM_INVALID_GROUP_CHARS=silently TF_STATE=./terraform \
  ansible-playbook --inventory-file=$(which terraform-inventory) \
  playbooks/k8s.yaml
```

### Interacting with the cluster

As the master will be on a private IP, you won\'t be able to directly interact
with it, but you can still ssh into the VM using the ingress node as a gateway
host (you can get the different hosts with
`TF_STATE=./terraform terraform-inventory --inventory`)

<!-- markdownlint-disable line-length -->
```shell
$ ssh -o ProxyCommand="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -W %h:%p -q egi@<ingress ip>" \
      -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null egi@<master ip>
egi@k8s-master:~$ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
k8s-master      Ready    master   33m   v1.15.7
k8s-nfs         Ready    <none>   16m   v1.15.7
k8s-w-ingress   Ready    <none>   16m   v1.15.7
egi@k8s-master:~$ helm list
NAME             REVISION    UPDATED                     STATUS      CHART                           APP VERSION NAMESPACE
certs-man        2           Wed Jan  8 15:56:58 2020    DEPLOYED    cert-manager-v0.11.0            v0.11.0     cert-manager
cluster-ingress  3           Wed Jan  8 15:56:53 2020    DEPLOYED    nginx-ingress-1.7.0             0.24.1      kube-system
nfs-provisioner  3           Wed Jan  8 15:56:43 2020    DEPLOYED    nfs-client-provisioner-1.2.8    3.1.0       kube-system
```
<!-- markdownlint-enable line-length -->

### Modifying/Destroying the cluster

You should be able to change the number of workers in the cluster and re-apply
terraform to start them and then execute the playbook to get them added to the
cluster.

Any changes in the master, NFS or ingress VMs should be done carfully as those
will probably break the configuration of the kubernetes cluster and of any
application running on top.

Destroying the cluster can be done with a single command:

```shell
terraform destroy
```

## Notebooks deployments

Once the k8s cluster is up and running, you can deploy a notebooks instance. For
each deployment you should create a file in the `deployments` directory
following the template provided:

```shell
cp deployments/hub.yaml.template deployments/hub.yaml
```

Each deployment will need a domain name pointing to your ingress host, you can
create one at the [FedCloud dynamic DNS service](https://nsupdate.fedcloud.eu/).

Then you will need to create an OpenID Connect client for EGI Check-in to
authorise users into the new deployment. You can create a client by going to the
[EGI Federation Registry](https://aai.egi.eu/federation).
You can find more information about registering an OIDC Client in
[EGI Check-in guide for SPs](../../check-in/sp/#service-provider-integration-workflow)
Use the following as redirect URL:
`https://<your host domain name>/hub/oauth_callback`.

Then add `offline_access` to the list of scopes and sumbit the request. After
the approval of the Service request, save the client and take note of the
client ID and client secret for later.

Finally you will also need 3 different random strings generated with
`openssl rand -hex 32` that will be used as secrets in the file describing the
deployment.

Go and edit the deployment description file to add this information (search for
`# FIXME NEEDS INPUT` in the file to quickly get there)

For deploying the notebooks instance we will also use `ansible`:

```shell
ANSIBLE_TRANSFORM_INVALID_GROUP_CHARS=silently \
     TF_STATE=./terraform ansible-playbook \
     --inventory-file=$(which terraform-inventory) playbooks/notebooks.yaml
```

The first deployment trial may fail due to a timeout caused by the downloading
of the container images needed. You can retry after a while to re-deploy.

In the master you can check the status of your deployment (the name of the
deployment will be the same as the name of your local deployment file):

<!-- markdownlint-disable line-length -->
```shell
$ helm status hub
LAST DEPLOYED: Thu Jan  9 08:14:49 2020
NAMESPACE: hub
STATUS: DEPLOYED

RESOURCES:
==> v1/ServiceAccount
NAME            SECRETS  AGE
hub             1        6m46s
user-scheduler  1        3m34s

==> v1/Service
NAME          TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)                     AGE
hub           ClusterIP  10.100.77.129  <none>       8081/TCP                    6m46s
proxy-public  NodePort   10.107.127.44  <none>       443:32083/TCP,80:30581/TCP  6m45s
proxy-api     ClusterIP  10.103.195.6   <none>       8001/TCP                    6m45s

==> v1/ConfigMap
NAME            DATA  AGE
hub-config      4     6m47s
user-scheduler  1     3m35s

==> v1/PersistentVolumeClaim
NAME        STATUS   VOLUME               CAPACITY  ACCESS MODES  STORAGECLASS  AGE
hub-db-dir  Pending  managed-nfs-storage  6m46s

==> v1/ClusterRole
NAME                              AGE
hub-user-scheduler-complementary  3m34s

==> v1/ClusterRoleBinding
NAME                              AGE
hub-user-scheduler-base           3m34s
hub-user-scheduler-complementary  3m34s

==> v1/RoleBinding
NAME  AGE
hub   6m46s

==> v1/Pod(related)
NAME                            READY  STATUS   RESTARTS  AGE
continuous-image-puller-flf5t   1/1    Running  0         3m34s
continuous-image-puller-scr49   1/1    Running  0         3m34s
hub-569596fc54-vjbms            0/1    Pending  0         3m30s
proxy-79fb6d57c5-nj8n2          1/1    Running  0         2m22s
user-scheduler-9685d654b-9zt5d  1/1    Running  0         3m30s
user-scheduler-9685d654b-k8v9p  1/1    Running  0         3m30s

==> v1/Secret
NAME        TYPE    DATA  AGE
hub-secret  Opaque  3     6m47s

==> v1/DaemonSet
NAME                     DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
continuous-image-puller  2        2        2      2           2          <none>         3m34s

==> v1/Deployment
NAME            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
hub             1        1        1           0          6m45s
proxy           1        1        1           1          6m45s
user-scheduler  2        2        2           2          3m32s

==> v1/StatefulSet
NAME              DESIRED  CURRENT  AGE
user-placeholder  0        0        6m44s

==> v1beta1/Ingress
NAME        HOSTS                                 ADDRESS  PORTS  AGE
jupyterhub  notebooktest.fedcloud-tf.fedcloud.eu  80, 443  6m44s

==> v1beta1/PodDisruptionBudget
NAME              MIN AVAILABLE  MAX UNAVAILABLE  ALLOWED DISRUPTIONS  AGE
hub               1              N/A              0                    6m48s
proxy             1              N/A              0                    6m48s
user-placeholder  0              N/A              0                    6m48s
user-scheduler    1              N/A              1                    6m47s

==> v1/Role
NAME  AGE
hub   6m46s


NOTES:
Thank you for installing JupyterHub!

Your release is named hub and installed into the namespace hub.

You can find if the hub and proxy is ready by doing:

kubectl --namespace=hub get pod

and watching for both those pods to be in status 'Running'.

You can find the public IP of the JupyterHub by doing:

kubectl --namespace=hub get svc proxy-public

It might take a few minutes for it to appear!

Note that this is still an alpha release! If you have questions, feel free to
1. Read the guide at https://z2jh.jupyter.org
2. Chat with us at https://gitter.im/jupyterhub/jupyterhub
3. File issues at https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues
```
<!-- markdownlint-enable line-length -->

### Updating a deployment

Just edit the deployment description file and run ansible again. The helm will
be upgraded at the cluster.
