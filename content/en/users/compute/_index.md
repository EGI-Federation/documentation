---
title: Compute Services
linkTitle: Compute
type: docs
weight: 40
description: >
  Compute services in the EGI Cloud
---

## Working with compute

Most scientific work researchers do includes computation. Could be the need to
run a small analysis. Or a data reduction job that has to be repeated a million
times on every measurement coming in from an ionosphere observation facility.
Or a handful of cutting-edge simulations of climate models that each demand a
huge number of compute cores.

EGI provides a variety of compute services for each of these use cases.
Researchers can choose the best compute tool for each application, from
customisable and elastic Virtual Machine (VM) based cloud to fully managed
distributed platforms that will run their jobs using CPUs, GPUs or both.

The compute services are summarized below:

- [Cloud Compute](./cloud-compute/) means **VM-based computing with associated
  storage**. It delivers customisable resources where users have complete control
  over the software, the supporting compute type and capacity.
  Typical use-cases are user gateways or portals, interactive computing platforms
  and almost any kind of data- and/or compute-intensive workloads.
- [Container Compute](./cloud-container-compute/) supports running **container-based
  applications** with either Docker or Kubernetes on top of Cloud Compute.
  Typical use-cases are multi-tenant, microservices-based applications that must
  easily scale horizontally.
- [High Throughput Compute](./high-throughput-compute/) provides access to large,
  shared grid computing systems for **running computational jobs at scale**. Typical
  use-cases include analysis of large datasets in an “embarrassingly parallel”
  fashion (i.e. by splitting the data into small pieces), and executing thousands,
  or even more independent computing tasks simultaneously, each processing one
  piece of data.
<!--
- [High Performance Compute](./high-performance-compute/) supports **highly optimized
  applications that need massively parallel computing** with low latency and
  a high-bandwidth interconnection network. Typical use-cases are complex
  computational problems using tightly coupled parallel processing: simulations,
  analysis of large datasets or AI/ML workloads, usually relying on MPI for
  interprocess communication.
-->

When researchers enounter the need large amounts of computing power, need hybrid
solutions based on the above mentioned services, or simply do not care to manage the
underlying compute facilities that will run their workloads,
[cloud orchestrators](./orchestration/) can help provision, manage, and monitor
compute resources, which then run scientific workloads.

The following sections describe each compute service that is available in
the EGI infrastructure.
