---
title: Cloud Container Compute
type: docs
weight: 20
aliases:
  - /users/cloud-container-compute
description: >
  Run containers on the EGI Cloud
---

The
[EGI Cloud Container Compute service](https://www.egi.eu/service/cloud-container-compute/)
allows you to run container-based applications on the providers of the EGI
Federated Cloud. There are two main ways of executing containers:

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

The EGI Cloud Container Compute service has been presented in the
[EGI Webinars](https://www.egi.eu/trainings-and-webinars/).

* January 2024: *Introduction to the new generation EGI container execution
  platform*. See
  [slides and recording](https://www.egi.eu/event/webinar-introduction-to-the-container-platform/).

* April 2021: *Managing Singularity, Docker and udocker containers, Kubernetes
  clusters in the EGI Cloud*. See
  [slides and recording](https://indico.egi.eu/event/5492/).
