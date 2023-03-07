---
title: Compute Orchestration
linkTitle: Compute Orchestration
type: docs
weight: 60
description: >
  Compute resource orchestration in the EGI infrastructure
---

## Overview

One of the challenges for researchers in recent years is to manage an ever-increasing
amount of compute and storage services, which then form ever more complex end user
applications or platforms.

To address this need, EGI provides several orchestrators that facilitate the
management of your workload using resources on the federation. These tools have
different levels of abstractions and features. See below to understand which to
choose (or gets used automatically) in specific scenarios:

| Service Name                                | Workload Type                | Use-Case                                                                                                                               |
| ------------------------------------------- | ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| [Infrastructure Manager](im)                | VMs, containers, storage     | Used to run workloads on a single IaaS Cloud provider.                                                                                 |
| [Elastic Cloud Compute Cluster](ec3)        | VMs, containers, storage     | Used when you need to run workloads on clusters that can be elastically scaled and potentially span more than one IaaS Cloud provider. |
| [Workload Manager](workload-manager)        | Jobs                         | Used to efficiently distribute, manage, and monitor computing workloads.                                                               |
| [Dynamic On-Demand Analysis Service](dodas) | Containers, storage (caches) | Used when you need to process your data either interactively or via a batch system.                                                    |

The following sections offer more details about each of these orchestrators.
