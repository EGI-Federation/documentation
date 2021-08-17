---
title: "High Throughput Compute"
dlinkTitle: "High Throughput Compute"
type: docs
weight: 60
description: >
  EGI High Throughput Compute service
---

## What is it?

High Throughput Compute (HTC) is a computing paradigm that focuses on the
**efficient execution of a large number of loosely-coupled tasks** (e.g. data
analysis jobs).
HTC systems execute independent tasks that can be individually scheduled on many
different computing resources, across multiple administrative boundaries.
Users submit these tasks to the infrastructure as jobs. After a job have been
scheduled and executed, the output can be collected from the service(s) that
executed the job.

{{% alert title="Note" color="info" %}} For more details check out the
[introduction](../getting-started) to the EGI Federated Cloud (FedCloud)
that provides the HTC resources, and the
[access model](../getting-started#accessing-resources) to those resources.
{{% /alert %}}

## Target users

The target customers for EGI High Throughput Compute are research communities
that need to share, store, process, and produce large sets of data. Typically,
their research collaborations involve organizations across Europe and the
World.Some may already have local resources (e.g. universities, research
institutions) that can only be accessed by local users in accordance to the
respective organisation's access policies.

In case of local compute resources researchers can request access to the
local compute cluster from their IT department. However, when researchers join
collaborations that need to share their research activities, data collections,
and repositories, they need a homogenous and coordinated operation of the
compute resources, which are not uniformly accessible. In addition, nowadays
many research collaborations generate large amounts of data, and managing
such data volumes is time consuming and error prone.

The EGI High Throughput Compute service provides access to compute resources,
and offers a set of high-level tools that allow managing large amounts of data
in a collaborative way (e.g authorization and access control tools can be
regulated by the research collaboration in a central manner, data can be
uniformly distributed in the EGI Cloud, etc.).

## Features

EGI High Throughput Compute provides easy, uniform access to shared computating
and data services of EGI service providers. Most software deployed in the
distributed resource centers is based on
[open standards](https://en.wikipedia.org/wiki/Open_standard) and
[open source](https://en.wikipedia.org/wiki/Open_source)
middleware services.

The main features of the EGI High Throughput Compute are:

- Access to high-quality computing resources
- Integrated monitoring and accounting tools provide information about the
  availability and resource consumption
- Workload and data management tools to manage all computational tasks
- Large amounts of processing capacity over long periods of time
- Faster results for your research
- Shared resources enable collaborative research

## The EGI HTC infrastructure

The EGI High Throughput Compute infrastructure is the federation of GRID
resources provided by EGI providers. Its aim is to share in a secure way the
distributed IT resources that are part of the EGI Cloud. It comprises of:

- **Compute Resources** -- execution environment for computing tasks,
  organized into clusters distributed across multiple resource centers in Europe
  and the World.
- **Data Infrastructure** -- storage servers from different resource centers
  where users can store their data/files in a distributed manner.
- **Federated Operations** -- global operational tasks (e.g., AAI, accounting,
  helpdesk) needed to federate the heterogeneous resources of resource centers
  and their operational activities.
- **User Support** -- EGI provides the central user support and coordinates
  support activities of EGI providers, who offer user support for the
  services/resources they contribute to the EGI ecosystem.

### Architecture and service components

![EGI High Throughput Compute architecture](htc_archtecture.png)

The key components of the EGI High Throughput Compute architecture are:

- [Data Transfer service](../data-transfer/) (FTS)
- [Online Storage services](../online-storage/)
- **Computing Elements** (CEs) are compute resources made available through
  GRID interfaces. The most common implementations of CEs in the EGI
  infrastructure are
  [HTCondor-CE](https://htcondor-ce.readthedocs.io/en/latest/) and
  [ARC-CE](http://www.nordugrid.org/arc/ce/).
