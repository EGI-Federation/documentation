---
title: Docker VM
type: docs
weight: 20
aliases:
  - /users/cloud-container-compute/docker
description: >
  Run containers on the EGI Cloud on a single VM with Docker
---

The
[EGI Docker VA](https://appdb.egi.eu/store/vappliance/egi.docker.ubuntu.16.04)
is a ready-to-use Virtual Machine Image with [docker](https://www.docker.com/)
and [docker-compose](https://docs.docker.com/compose/) pre-installed.

You can start that image as any other VA available from AppDB:

1. Go to the
   [EGI Docker image entry in AppDB](https://appdb.egi.eu/store/vappliance/egi.docker.ubuntu.16.04).

1. Check the identifiers of the endpoint, image and flavor you want to use at
   the provider.

1. Use a ssh key when, so you can log into the VM once it\'s instantiated.

1. Once up, just ssh in the VM and start using docker as usual.

### Using docker from inside the VM

You can log in with user `ubuntu` and your ssh key:

```shell
$ ssh -i <yourprivatekey> ubuntu@<your VM ip>
```

Once in, you can run any docker command, e.g.:

```shell
$ sudo docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b901d36b6f2f: Pull complete
0a6ba66e537a: Pull complete
Digest: sha256:8be990ef2aeb16dbcb9271ddfe2610fa6658d13f6dfb8bc72074cc1ca36966a7
Status: Downloaded newer image for hello-world:latest
Hello from Docker.
This message shows that your installation appears to be working correctly.
To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash
Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com
For more examples and ideas, visit:
 https://docs.docker.com/userguide/
```

Docker-compose can be also used to execute applications with more than one
container running together,
[follow this documentation](https://docs.docker.com/compose/) to learn more.

### Known issues

#### MTU and docker

Depending on the cloud provider you may encounter unexpected network
connectivity issues when working inside the docker container. If that is
the case, please try reconfiguring the
[MTU](https://en.wikipedia.org/wiki/Maximum_transmission_unit)
for the docker daemon:

```shell
# check current MTU value
$ sudo docker network inspect bridge  | awk '/mtu/ {print $2}'

# the default 1500 value does not work properly
# edit docker configuration
$ sudo vi /etc/docker/daemon.json

# ensure MTU value is 1376
{
  "mtu": 1376
}

# then restart docker
$ sudo systemctl restart docker
```

We experienced this issue when trying to install a pip dependency using
`continuumio/miniconda3` container from
[docker hub](https://hub.docker.com/r/continuumio/miniconda3).
