---
title: Cloud Orchestration
linkTitle: Cloud Orchestration
type: docs
weight: 60
description: >
  Compute resource orchestration in the EGI infrastructure
---

## Overview

One of the challenges for researchers in recent years is to manage an ever
increasing amount of compute and storage services, which then form ever more
complex end-user applications or platforms.

To address this need, several cloud-based orchestrators are available that can
support the creation of virtual infrastructures on top of
Infrastructure-as-a-Service (IaaS) Cloud resources. These tools have different
levels of abstractions and features. See below to understand which to choose
(or gets used automatically) in specific scenarios:

| Service Name                                 | Workload Type             | Use-Case |
| -------------------------------------------- | ------------------------- | -------- |
| [Infrastructure Manager](im)                 | VMs and containers        | Used to run workloads on a single IaaS Cloud provider. |
| [Elastic Cloud Compute Cluster](ec3)         | VMs and containers        | Used when you need to run workloads on clusters that can be elastically scaled and potentially span more than one IaaS Cloud provider. | 
<!-->
| [PaaS Orchestrator](indigo-paas)             | VMs, containers, HTC jobs | Used when you have both IaaS Cloud and HTC workloads. The DEEP Platform uses it for ML/DL workloads. |
| [Dynamic On-Demand Analysis Software](dodas) | Containers                | Used when your workload is composed of Docker containers (Helm charts). |
-->

The following sections offer more details about each of these orchestrator tools.
