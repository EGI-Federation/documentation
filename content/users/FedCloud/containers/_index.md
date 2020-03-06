---
title: "Cloud Container Compute"
type: docs
weight: 70
description: >
  Run containers on the EGI Cloud 
---

You can run containers on EGI Cloud by:

-   Using a pre-configured image with docker (see EGI Docker VA) below;
-   installing docker on top of an existing VM (by following [docker
    installation
    instructions](https://docs.docker.com/engine/installation/); or
-   running a container orchestration platform that manages the
    applications on top of a set of nodes (Kubernetes, Docker Swarm and
    Mesos are examples of such orchestration platforms).

## EGI Docker VA

The [EGI Docker
VA](https://appdb.egi.eu/store/vappliance/docker.ubuntu.16.04) is a
ready-to-use Virtual Machine Image with
[docker](https://www.docker.com/) and
[docker-compose](https://docs.docker.com/compose/) pre-installed.

You can start that image as any other VA available from AppDB:

1.  Go to the [EGI Docker image entry in
    AppDB](https://appdb.egi.eu/store/vappliance/docker.ubuntu.16.04).
2.  Check the identifiers of the endpoint, image and flavor you want to
    use at the provider.
3.  Use a ssh key when, so you can log into the VM once it\'s
    instantiated.
4.  Once up, just ssh in the VM and start using docker as usual.

### Using docker from inside the VM

You can log in with user `ubuntu` and your ssh key:

``` {.console}
ssh -i <yourprivatekey> ubuntu@<your VM ip>
```

Once in, you can run any docker command, e.g.:

``` {.console}
ubuntu@fedcloud_vm:~$ sudo docker run hello-world
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

## Kubernetes

You can run several docker clusters management tools on the EGI Cloud,
each tool has its own specifics, but there are plenty of helpers to aid
in their setup. Here we cover how to configure Kubernetes by using
[ansible](https://www.ansible.com/).

{{% alert title="Note" color="info" %}}
We are preparing new instructions to get kubernetes running on EGI
Cloud. Stay tuned!
{{% /alert %}}
