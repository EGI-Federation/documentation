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

To deploy [NAMD](https://www.ks.uiuc.edu/Research/namd/) clusters, please
select one of the available LRMS (Local Resource Management System) and
choose NAMD from the list of applications.

## How to use generic tools/practices in EC3

### ECAS cluster

Check the dedicated [ECAS documentation](./ecas/).

### Kubernetes

Check the
[Cloud Container Compute documentation](../../../cloud-container-compute).

### Mesos + Marathon + Chronos

To deploy a virtual cluster with
[Marathon](https://mesosphere.github.io/marathon/),
[Mesos](http://mesos.apache.org/), and
[Chronos](https://mesos.github.io/chronos/) as an orchestration,
please select Mesos + Marathon + Chronos from the list of available LRMS.

### OSCAR cluster

To deploy
[Serverless computing for data-processing applications](https://www.egi.eu/about/newsletters/serverless-computing-for-data-processing-applications-in-egi/)
in EGI, please select OSCAR from the list of LRMS (Local Resource Management
System). OSCAR supports data-driven serverless computing for file-processing applications. 
Services will be triggered in response to a file upload to an object storage back-end in order 
to execute a user-defined shell script inside a container provisioned out of an user-defined 
Docker image. These will be orchestrated as a Kubernetes batch jobs. The output data will be uploaded 
to any object storage back-ends support. Synchronous invocations available.

See the documentation to deploy an elastic Kubernetes cluster with the OSCAR platform with EC3:
[Deploy OSCAR with EC3](https://docs.oscar.grycap.net/deploy-ec3/)

See some use cases of applications that use the OSCAR framework for
event-driven high-throughput processing of files (you can found it in the
GitHub repository [examples folder](https://github.com/grycap/oscar/tree/master/examples)):

* Inference of a machine learning model: See full description at [OSCAR Blog entry](https://oscar.grycap.net/blog/post-oscar-faas-scalable-ml-inference/).
* Mask detection: See full description at [OSCAR Blog entry](https://oscar.grycap.net/blog/post-oscar-serverless-ai-models/).
* [Plants Classification](https://github.com/indigo-dc/plant-classification-theano),
  an application that performs plant classification using Lasagne/Theano.
* [ImageMagick](https://www.imagemagick.org/), a tool to manipulate images.
* [Radiomics](https://github.com/eubr-atmosphere/radiomics), a use case about
  the handling of Rheumatic Heart Disease (RHD) through image computing and
  Artificial Intelligence (AI).

More information in the [OSCAR webpage](https://oscar.grycap.net/)

### SLURM cluster

To deploy [SLURM](https://slurm.schedmd.com/documentation.html) clusters,
please select SLURM from the list of available LRMS.
See also the dedicated guide on [HTC clusters](./htc/)
