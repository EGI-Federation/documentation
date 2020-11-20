---
title: "EC3 applications and tools"
type: docs
weight: 30
description: >
  How to run scientific applications and tools with EC3
---

This section documents how to run some applications and use the existing tools
with EC3.

## How to run scientific applications in EC3

### NAMD cluster

To deploy NAMD clusters, please select one of the available LRMS (Local Resource
Management System) and choose NAMD from the list of applications.

## How to use generic tools/practices in EC3

### Apache Mesos

To deploy a virtual cluster with Apache Mesos as a compute cluster, please
select Mesos from the list of available Local Resource Management System (LRMS).

### Chronos

To deploy a virtual cluster with Chronos as fault-tolerant scheduler, please
select Chronos from the list of available LRMS.

### ECAS cluster

Check the dedicated [ECAS documentation](./ecas/).

### Kubernetes

Check the
[Cloud Container Compute documentation](../../../cloud-container-compute).

### Marathon

To deploy a virtual cluster with Marathon as an orchestration, please select
Chronos from the list of available LRMS.

### OSCAR cluster

To deploy
[Serverless computing for data-processing applications](https://www.egi.eu/about/newsletters/serverless-computing-for-data-processing-applications-in-egi/)
in EGI, please select OSCAR from the list of LRMS (Local Resource Management
System). Use cases of applications that use the OSCAR framework for event-driven
high-throughput processing of files:

- [Plants Classification](https://github.com/indigo-dc/plant-classification-theano),
  an application that performs plant classification using Lasagne/Theano.
- [ImageMagick](https://www.imagemagick.org/), a tool to manipulate images.
- [Radiomics](https://github.com/eubr-atmosphere/radiomics), a use case about
  the handling of Rheumatic Heart Disease (RHD) through image computing and
  Artificial Intelligence (AI).

### SLURM cluster

To deploy SLURM clusters, please select SLURM from the list of available LRMS
(Local Resource Management System). See also the dedicated guide on
[HTC clusters](./htc/)
