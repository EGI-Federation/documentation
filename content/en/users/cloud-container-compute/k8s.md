---
title: "Kubernetes"
type: docs
weight: 20
description: >
  Run containers on the EGI Cloud with Kubernetes
---

There are several container management tools available, on the EGI Cloud we use
[Kubernetes](https://kubernetes.io) as the default platform for our service.
This guide explains how to get a running scalable Kubernetes deployment for your
applications with EC3.

## Getting started

Before getting your kubernetes cluster deployed, you need to get access to the
Cloud Compute service, check the
[Authentication and Authorisation guide](../cloud-compute/auth) for more
information. You should also get
[`fedcloud` client](https://github.com/EGI-Federation/fedlcoudclient/)
installed to get EC3 templates needed to start deployment.

Your kubernetes deployment needs to be performed at an specific provider (site)
and project. Discover them using `fedcloud` as described in the
[EC3 tutorial](../cloud-compute/ec3).

### EC3 Templates

EC3 relies on a set of _templates_ that will determine what will be deployed on
the infrastructure. `fedcloud` helps you to get an initial set of templates for
your kubernetes deployment:

```shell
mkdir k8s
cd k8s
fedcloud ec3 init --site <your site> --vo <your vo>
```

You will also need a base image template for the deployment. Please refer to the
[EC3 tutorial](../cloud-compute/ec3) to create such file. Below you can
see an example for IFCA-LCG2 site with project related to `vo.access.egi.eu`:

<!-- markdownlint-disable line-length -->
```plaintext
description ubuntu-ifca (
    kind = 'images' and
    short = 'ubuntu18-ifca' and
    content = 'Ubuntu 18 image at IFCA-LCG2'
)

network public (
    provider_id = 'external' and
    outports contains '22/tcp'
)

network private (provider_id = 'provider-2008')

system front (
    cpu.arch = 'x86_64' and
    cpu.count >= 2 and
    memory.size >= 2048 and
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://api.cloud.ifca.es/723171cb-53b2-4881-ae37-a7400ce0665b' and
    disk.0.os.credentials.username = 'cloudadm'
)

system wn (
    cpu.arch = 'x86_64' and
    cpu.count >= 2 and
    memory.size >= 2048 and
    ec3_max_instances = 5 and # maximum number of working nodes in the cluster
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://api.cloud.ifca.es/723171cb-53b2-4881-ae37-a7400ce0665b' and
    disk.0.os.credentials.username = 'cloudadm'
)
```
<!-- markdownlint-enable line-length -->

Now you are ready to deploy the cluster using `launch` command of ec3 with:

1. the name of the deployment, `k8s` in this case

1. a list of templates: `kubernetes` for configuring kubernetes, `ubuntu` for
   specifying the image and site details, `refresh` to enable credential refresh
   and elasticity

1. the credentials to access the site with `-a auth.dat`

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 \
         launch k8s kubernetes ubuntu refresh -a auth.dat
Creating infrastructure
Infrastructure successfully created with ID: b9577c34-f818-11ea-a644-2e0fc3c063db
Front-end configured with IP 193.144.46.249
Transferring infrastructure
Front-end ready!
```

Your kubernetes deployment is now ready, log in with the `ssh` command of ec3:

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 ssh k8s
Warning: Permanently added '193.144.46.249' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-109-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 * Kubernetes 1.19 is out! Get it in one command with:

     sudo snap install microk8s --channel=1.19 --classic

   https://microk8s.io/ has docs and details.

 * Canonical Livepatch is available for installation.
   - Reduce system reboots and improve kernel security. Activate at:
     https://ubuntu.com/livepatch
Last login: Wed Sep 16 14:35:35 2020 from 158.42.104.204
$ bash
cloudadm@kubeserver:~$
```

You can interact with the kubernetes cluster with the `kubectl` command:

```shell
cloudadm@kubeserver:~$ sudo kubectl get nodes
NAME                     STATUS   ROLES    AGE   VERSION
kubeserver.localdomain   Ready    master   23h   v1.18.3
```

The cluster will only have one node (the master) and will start new nodes as you
create pods. Alternatively you can poweron nodes manually:

<!-- markdownlint-disable line-length -->
```shell
cloudadm@kubeserver:~$ clues status
node                          state    enabled   time stable   (cpu,mem) used   (cpu,mem) total
-----------------------------------------------------------------------------------------------
wn1.localdomain                 off    enabled     00h32'22"      0,0              1,1073741824
wn2.localdomain                 off    enabled     00h32'22"      0,0              1,1073741824
wn3.localdomain                 off    enabled     00h32'22"      0,0              1,1073741824
wn4.localdomain                 off    enabled     00h32'22"      0,0              1,1073741824
wn5.localdomain                 off    enabled     00h32'22"      0,0              1,1073741824
cloudadm@kubeserver:~$ clues poweron wn1.localdomain
node wn1.localdomain powered on
cloudadm@kubeserver:~$ sudo kubectl get nodes
NAME                     STATUS   ROLES    AGE     VERSION
kubeserver.localdomain   Ready    master   24h     v1.18.3
wn1.localdomain          Ready    <none>   6m49s   v1.18.3
```
<!-- markdownlint-enable line-length -->

## Exposing services outside the cluster

Kubernetes uses
[services](https://kubernetes.io/docs/concepts/services-networking/service/) for
exposing an applications via the network. The services can rely on Load
Balancers supported at the underlying cloud provider, which is not always
feasible on the EGI Cloud providers. As an alternative solution we use an
[ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress/)
which allows us to expose services using rules based on host names.

Helm allows you to quickly install the
[nginx based ingress](https://github.com/kubernetes/ingress-nginx/). Add the
helm repos:

```shell
cloudadm@kubeserver:~$ sudo helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
cloudadm@kubeserver:~$ sudo helm repo add stable https://kubernetes-charts.storage.googleapis.com/
cloudadm@kubeserver:~$ sudo helm repo update
```

Create a configuration file (`ingress.yaml`), get the externalIP using
`ip addr`:

```yaml
controller:
  tolerations:
    - effect: NoSchedule
      key: node-role.kubernetes.io/master
  service:
    type: NodePort
    externalIPs:
      - 192.168.10.3
defaultBackend:
  tolerations:
    - effect: NoSchedule
      key: node-role.kubernetes.io/master
```

and install:

```shell
cloudadm@kubeserver:~$ sudo helm install ingress -n kube-system -f ingress.yaml ingress-nginx/ingress-nginx
```

Now you are ready to expose your services using a valid hostname. Use the
[EGI Cloud Dynamic DNS service](https://nsupdate.fedcloud.eu/) for getting
hostnames if you need. Assign as IP the public IP of the master node. Once you
have a hostname assigned to the master IP, the ingress will be able to reply to
requests already:

```shell
$ curl ingress.test.fedcloud.eu
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx/1.19.2</center>
</body>
</html>
```

The following example yaml creates a service and exposes at that
ingress.test.fedcloud.eu host:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  labels:
    app: nginx
spec:
  ports:
    - port: 80
      protocol: TCP
  selector:
    app: nginx
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: ingress-test
spec:
  rules:
    - host: ingress.test.fedcloud.eu
      http:
        paths:
          - pathType: Prefix
            path: "/"
            backend:
              serviceName: my-nginx
              servicePort: 80
```

Now the ingress will redirect request to the NGINX pod that we have just
created:

```shell
$ curl ingress.test.fedcloud.eu
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

## Volumes

Volumes on these deployments can be supported with NFS volume driver. You can
either manually configure the server on one of the nodes or use EC3 to deploy it
and configure it for you. Create a `templates/nfs.radl` to do so:

<!-- markdownlint-disable line-length -->
```plaintext
description nfs (
    kind = 'component' and
    short = 'Tool to configure shared directories inside a network.' and
    content = 'Network File System (NFS) client allows you to access shared directories from Linux client.'
)

system front (
    ec3_templates contains 'nfs' and
    disk.0.applications contains (name = 'ansible.modules.grycap.nfs')
)

configure front (
@begin
  - tasks:
    - name: Create /volume for supporting NFS
      file:
        path: /volumes
        state: directory
        mode: '0777'
  - roles:
    - role: grycap.nfs
      nfs_mode: 'front'
      nfs_exports:
      - path: "/volumes"
        export: "wn*.localdomain(rw,async,no_root_squash,no_subtree_check,insecure) kubeserver.localdomain(rw,async,no_root_squash,no_subtree_check,insecure)"
@end
)

system wn (ec3_templates contains 'nfs')

configure wn (
@begin
  - tasks:
    - name: Install NFS common
      apt:
        name: nfs-common
        state: present
@end
)
```
<!-- markdownlint-enable line-length -->

if you have a running cluster, you can add the NFS support by reconfiguring the
cluster:

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 \
    reconfigure k8s -a auth.dat -t nfs
Reconfiguring infrastructure
Front-end configured with IP 193.144.46.249
Transferring infrastructure
Front-end ready!
```

And then install the NFS driver in kubernetes with helm:

<!-- markdownlint-disable line-length -->
```shell
cloudadm@kubeserver:~$ sudo helm install nfs-provisioner \
              stable/nfs-client-provisioner \
              --namespace kube-system \
              --set nfs.server=192.168.10.9 \
              --set storageClass.defaultClass=true \
              --set nfs.path=/volumes \
              --set tolerations[0].effect=NoSchedule,tolerations[0].key=node-role.kubernetes.io/master

```
<!-- markdownlint-enable line-length -->

Now you are ready to create a
[PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) and
attach it to a pod, see this example:

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  storageClassName: nfs-client
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: default
spec:
  restartPolicy: Never
  volumes:
    - name: vol
      persistentVolumeClaim:
        claimName: test-pvc
  containers:
    - name: test
      image: "busybox"
      command: ["sleep", "1d"]
      volumeMounts:
        - name: vol
          mountPath: /volume
```

Once you apply the yaml, you will see the new PVC gets bounded to a PV created
in NFS:

<!-- markdownlint-disable line-length -->
```shell
cloudadm@kubeserver:~$ sudo kubectl get pvc
NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc   Bound    pvc-39f970de-eaad-44d7-b49f-90dc9de54a14   3Gi        RWO            nfs-client     9m46s
```
<!-- markdownlint-enable line-length -->

## Destroying the cluster

Once you don't need the cluster anymore, you can undeploy with the `destroy`
command of EC3:

```shell
$ fedcloud ec3 refresh # refresh your credentials to interact with the cluster
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 destroy k8s -y -a auth.dat
WARNING: you are going to delete the infrastructure (including frontend and nodes).
Success deleting the cluster!
```
