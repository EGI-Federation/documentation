---
title: EC3 Command-Line Interface
linkTitle: Command Line
type: docs
weight: 20
aliases:
  - /users/cloud-compute/ec3/cli
description: >
  Getting started with Elastic Cloud Compute Cluster on EGI Cloud with the
  Command Line Interface
---

You can find here documentation on how to deploy a sample SLURM cluster, which
you can then adapt to create other kind of clusters easily.

## Getting started

We will use docker for running EC3, direct installation is also possible and
described at
[EC3 documentation](https://ec3.readthedocs.io/en/devel/intro.html#installation).
First get the docker image:

```shell
docker pull grycap/ec3
```

And check that you can run a simple command:

```shell
$ docker run grycap/ec3 list
 name  state  IP  nodes
------------------------
```

For convenience we will create a directory to keep the deployment configuration
and status together.

```shell
mkdir ec3-test
cd ec3-test
```

You can list the available templates for clusters with the `templates` command:

<!-- markdownlint-disable line-length -->

```shell
$ docker run grycap/ec3 templates
          name              kind                                         summary
----------------------------------------------------------------------------------------------------------------------
          blcr            component Tool for checkpointing applications.
[...]
           sge              main    Install and configure a cluster SGE from distribution repositories.
          slurm             main    Install and configure a cluster using the grycap.slurm ansible role.
       slurm-repo           main    Install and configure a cluster SLURM from distribution repositories.
[...]
```

<!-- markdownlint-enable line-length -->

We will use the `slurm` template for configuring our cluster.

## Site details

EC3 needs some information on the site that you are planning to use to deploy
your cluster:

1. authentication information
1. network identifiers
1. VM image identifiers

We will use the [FedCloud client](../../../../getting-started/cli) to discover
the required information. Set your credentials as shown in
[the authentication guide](../../../../getting-started/cli#authentication)
and create the authorisation files needed for ec3 (in this case for CESGA with VO
vo.access.egi.eu):

```shell
fedcloud ec3  init --site CESGA --vo vo.access.egi.eu
```

This will generate an `auth.dat` file with your credentials to access the site
and a `templates/refresh.radl` with a refresh token to allow long running
clusters to be managed on the infrastructure.

Let's get also some needed site information. Start getting the available
networks, we will need both a public and private network:

<!-- markdownlint-disable line-length -->

```shell
$ fedcloud openstack --site CESGA --vo vo.access.egi.eu network list
+--------------------------------------+----------------------+--------------------------------------+
| ID                                   | Name                 | Subnets                              |
+--------------------------------------+----------------------+--------------------------------------+
| 12ffb5f7-3e54-433f-86d0-8ffa43b52025 | net-vo.access.egi.eu | 754342b1-92df-4fc8-9499-2ee8b668141f |
| 6174db12-932f-4ee3-bb3e-7a0ca070d8f2 | public00             | 6af8c4f3-8e2e-405d-adea-c0b374c5bd99 |
+--------------------------------------+----------------------+--------------------------------------+
```

<!-- markdownlint-enable line-length -->

Then, get the list of images available:

<!-- markdownlint-disable line-length -->

```shell
$  fedcloud openstack --site CESGA --vo vo.access.egi.eu image list
+--------------------------------------+----------------------------------------------------------+--------+
| ID                                   | Name                                                     | Status |
+--------------------------------------+----------------------------------------------------------+--------+
| 9d22cb3b-e6a3-4467-801a-a68214338b22 | Image for CernVM3 [CentOS/6/QEMU-KVM]                    | active |
| b03e8720-d88a-4939-b93d-23289b8eed6c | Image for CernVM4 [CentOS/7/QEMU-KVM]                    | active |
| 06cd7256-de22-4e9d-a1cf-997b5c44d938 | Image for Chipster [Ubuntu/16.04/KVM]                    | active |
| 8c4e2568-67a2-441a-b696-ac1b7c60de9c | Image for EGI CentOS 7 [CentOS/7/VirtualBox]             | active |
| abc5ebd8-f65c-4af9-8e54-a89e3b5587a3 | Image for EGI Docker [Ubuntu/18.04/VirtualBox]           | active |
| 22064e93-6af9-430b-94a1-e96473c5a72b | Image for EGI Ubuntu 16.04 LTS [Ubuntu/16.04/VirtualBox] | active |
| d5040b3e-ef33-4959-bb88-5505e229f579 | Image for EGI Ubuntu 18.04 [Ubuntu/18.04/VirtualBox]     | active |
| 79fadf3f-6092-4bb7-ab78-9a322f0aad33 | cirros                                                   | active |
+--------------------------------------+----------------------------------------------------------+--------+
```

<!-- markdownlint-enable line-length -->

For our example we will use the EGI CentOS 7 with id
`8c4e2568-67a2-441a-b696-ac1b7c60de9c`.

Finally, with all this information we can create the `images` template for EC3
that specifies the site configuration for our deployment. Save this file as
`templates/centos.radl`:

<!-- markdownlint-disable line-length -->

```plaintext
description centos-cesga (
    kind = 'images' and
    short = 'centos7-cesga' and
    content = 'CentOS7 image at CESGA'
)

network public (
    provider_id = 'public00' and
    outports contains '22/tcp'
)

network private (provider_id = 'net-vo.access.egi.eu')

system front (
    cpu.arch = 'x86_64' and
    cpu.count >= 2 and
    memory.size >= 2048 and
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://fedcloud-osservices.egi.cesga.es/8c4e2568-67a2-441a-b696-ac1b7c60de9c' and
    disk.0.os.credentials.username = 'centos'
)

system wn (
    cpu.arch = 'x86_64' and
    cpu.count >= 2 and
    memory.size >= 2048 and
    ec3_max_instances = 5 and # maximum number of worker nodes in the cluster
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://fedcloud-osservices.egi.cesga.es/8c4e2568-67a2-441a-b696-ac1b7c60de9c' and
    disk.0.os.credentials.username = 'centos'
)
```

<!-- markdownlint-enable line-length -->

Note we have used `public00` as public network and opened port `22` to allow ssh
access. The private network uses `net-vo.access.egi.eu`. We have two kind of VMs
in almost every deployment: the `front`, that runs the batch system, and the
`wn`, that will execute the jobs. In our example, both will use the same CentOS
image, which is specified with the
`disk.0.image.url = 'ost://fedcloud-osservices.egi.cesga.es/8c4e2568-67a2-441a-b696-ac1b7c60de9c'`
line: `ost` refers to OpenStack, `fedcloud-osservices.egi.cesga.es` is the
hostname of the URL obtained above with `fedcloud endpoint list` and
`8c4e2568-67a2-441a-b696-ac1b7c60de9c` is the ID of the image in OpenStack. The
size of the VM is also specified.

## Launch cluster

We are ready now to deploy the cluster with ec3 (this can take several minutes):

<!-- markdownlint-disable line-length -->

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 launch mycluster slurm ubuntu refresh -a auth.dat
Creating infrastructure
Infrastructure successfully created with ID: 74fde7be-edee-11ea-a6e9-da8b0bbd7c73
Front-end configured with IP 193.144.46.234
Transferring infrastructure
Front-end ready!
```

<!-- markdownlint-enable line-length -->

We can check the status of the deployment:

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 list
   name       state           IP        nodes
----------------------------------------------
 mycluster  configured  193.144.46.234    0
```

And once configured, ssh to the front node. The `is_cluster_ready` command will
report whether the cluster is fully configured or not:

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 ssh mycluster
Warning: Permanently added '193.144.46.234' (ECDSA) to the list of known hosts.
Last login: Thu Sep  3 14:07:46 2020 from torito.i3m.upv.es
$ bash
cloudadm@slurmserver:~$ is_cluster_ready
Cluster configured!
cloudadm@slurmserver:~$
```

EC3 will deploy [CLUES](https://www.grycap.upv.es/clues/eng/index.php), a
cluster management system that will power on/off nodes as needed depending on
the load. Initially all the nodes will be off:

<!-- markdownlint-disable line-length -->

```shell
node                          state    enabled   time stable   (cpu,mem) used   (cpu,mem) total
-----------------------------------------------------------------------------------------------
wn1                             off    enabled     00h03'55"      0,0.0            1,1073741824.0
wn2                             off    enabled     00h03'55"      0,0.0            1,1073741824.0
wn3                             off    enabled     00h03'55"      0,0.0            1,1073741824.0
wn4                             off    enabled     00h03'55"      0,0.0            1,1073741824.0
wn5                             off    enabled     00h03'55"      0,0.0            1,1073741824.0

```

<!-- markdownlint-enable line-length -->

SLURM will also report nodes as down:

```shell
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      5  down* wn[1-5]
```

As we submit a first job, some nodes will be powered on to meet the request. You
can also start them manually with `clues poweron`.

<!-- markdownlint-disable line-length -->

```shell
cloudadm@slurmserver:~$ srun hostname
srun: Required node not available (down, drained or reserved)
srun: job 2 queued and waiting for resources
srun: job 2 has been allocated resources
wn1.localdomain
cloudadm@slurmserver:~$ clues status
node                          state    enabled   time stable   (cpu,mem) used   (cpu,mem) total
-----------------------------------------------------------------------------------------------
wn1                            idle    enabled     00h07'45"      0,0.0            1,1073741824.0
wn2                             off    enabled     00h52'25"      0,0.0            1,1073741824.0
wn3                             off    enabled     00h52'25"      0,0.0            1,1073741824.0
wn4                             off    enabled     00h52'25"      0,0.0            1,1073741824.0
wn5                             off    enabled     00h52'25"      0,0.0            1,1073741824.0
cloudadm@slurmserver:~$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      4  down* wn[2-5]
debug*       up   infinite      1   idle wn1
```

<!-- markdownlint-enable line-length -->

## Destroying the cluster

Once you are done with the cluster and want to destroy it, you can use the
`destroy` command. If your cluster was created more than one hour ago, your
credentials to access the site will be expired and need to refreshed first with
`fedcloud ec3 refresh`:

<!-- markdownlint-disable line-length -->

```shell
$ fedcloud ec3 refresh # refresh your auth.dat
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 list # list your clusters
   name       state           IP        nodes
----------------------------------------------
 mycluster  configured  193.144.46.234    0
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 destroy mycluster -a auth.dat -y
WARNING: you are going to delete the infrastructure (including frontend and nodes).
Success deleting the cluster!
```

<!-- markdownlint-enable line-length -->
