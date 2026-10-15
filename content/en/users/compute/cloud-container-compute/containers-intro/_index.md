---
title: "Container Primer"
type: docs
weight: 60
description: >
  Introduction to containerized applications
---

This guide looks at what containers are, how they are different from other
kinds of virtualization technologies, and what advantages they can offer for
your development and operations processes.

## Introduction

DevOps teams face important challenges when building and installing
applications, due to the very specific deployment and configuration needs
(libraries, dependencies, configuration files, environment variables, secrets,
etc.), which can cause applications to fail to run correctly when moved from
one environment (development) to another (production).

The goal of containerization is to offer a better way to create, package, and
deploy software across different environments in a predictable and
easy-to-manage way.

## What is a container?

Similar to how a shipping container can be transported by ships, trucks, rail,
etc. regardless of the cargo inside, **a container is a standardized, portable
way of packaging software**, together with all necessary code, dependencies and
configuration.

Containers run consistently on any container-capable host, so developers can
test containers as a unit, deploy and run them across different types of 
infrastructure with little or no modification. Because the hosts and platforms
that run containers are generic, infrastructure management for container-based
systems can be standardized.

{{% alert title="Note" color="info" %}} Although containers can be implemented
and managed in a number of different ways, [Docker](https://www.docker.com) is
by far the most common way of building and running containers.
{{% /alert %}}

**Containers are created from container images**, which are read-only bundles
that represent an application or service, its dependencies, and its configuration.
Container images act like templates for creating specific containers, and the
same image can be used to spawn any number of running containers.

{{% alert title="Note" color="info" %}} This is similar to how _classes_ and
_instances_ work in object-oriented programming: a single class can be used to
create any number of instances just as a single container image can be used to
create any number of containers.

This analogy also holds true in regards to inheritance since container images
can act as the parent for other, more customized container images.
{{% /alert %}}

Each **container image is built from a Dockerfile**, which is a "recipe" that
either starts from scratch or from another Dockerfile, and has a
[simple syntax](https://docs.docker.com/engine/reference/builder/) for defining
the steps needed to create and run the image. Each instruction in a Dockerfile
creates a layer in the image. When you change the Dockerfile and rebuild the
image, only those layers which have changed are rebuilt, making images lightweight,
small, and fast, compared to other virtualization technologies.

Instead of building container images every time you need to use them,
**container images are published in container registries**, where images
can be pushed by developers and pulled when new container instances need to
be created and executed.

## Containers vs Virtual Machines

**Virtual machines virtualize the underlying hardware** so that multiple
operating system (OS) instances can run on the hardware. Each virtual machine
(VM) runs an OS and has access to virtualized resources representing the
underlying hardware.

Because VMs are operated as distinct computers that cannot affect the host
system or other VMs, they offer great isolation and security. But because each VM
contains an OS, libraries, applications, and more, VMs can use significant
system resources, and the VM provisioning and boot times can be fairly slow.
And since VMs operate as independent machines, VM owners need to employ
infrastructure management tools and processes to manage and update them.

**Containers virtualize the underlying operating system**. Containers are
run by a container host that runs on the OS, and isolates (see note below) containerized
applications by making them believe that each has the OS (including underlying resources
like CPUs, GPUs, memory, file storage, and network connections) all to itself.

{{% alert title="Note" color="info" %}} [Linux control groups](https://en.wikipedia.org/wiki/Cgroups)
allow processes and their resources to be grouped, isolated, and managed as a unit.

[Linux namespaces](https://en.wikipedia.org/wiki/Linux_namespaces) limit
what processes can see of the rest of the system. Processes running inside
namespaces are not aware of anything running outside of their namespace.
{{% /alert %}}

Since containers share the host OS, they do not need to boot an OS or load
libraries, which makes them much more efficient and lightweight than VMs.
Containerized applications can start in seconds, and many more instances of
the application can fit onto a physical machine than the same application
running in a VM. The shared OS has the added benefit of reduced overhead
when it comes to maintenance, such as patching and updates.
