---
title: "Cloud Container Compute"
type: docs
weight: 50
description: >
  Run containers on the EGI Cloud
---

The EGI Cloud Container Compute service allows you to run container-based
applications on the providers of the EGI Federated Cloud. There are two main
ways of executing containers:

1. Using docker (or a similar container runtime) on a VM, so you can just
   interact directly with the container runtime to run your applications. This
   fits simpler applications that can easily fit on one node and are composed by
   a small number of containers.

1. Using a container orchestration platform, e.g.
   [kubernetes](https://kubernetes.io) on a set of VMs to manage the
   applications in an automated way for you. This is usually suited for more
   complex applications that spawn several nodes and are composed of several
   containers that need to cooperate to deliver the expected functionality.

Follow the guides below to learn more about them.
