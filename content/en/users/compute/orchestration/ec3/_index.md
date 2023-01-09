---
title: Elastic Cloud Compute Clusters
linkTitle: Cloud Compute Clusters
type: docs
weight: 20
aliases:
  - /users/cloud-compute/ec3
description: >
  Working with Elastic Cloud Compute Clusters in the EGI Cloud
---

## What is it?

[Elastic Cloud Compute Cluster](https://servproject.i3m.upv.es/ec3-ltos/) (EC3)
is a tool to **create elastic virtual clusters on top of
Infrastructure-as-a-Service (IaaS) providers**.

Being based on [Infrastructure Manager](../im), EC3 supports the same wide
choices of backends, either public (such as
[Amazon Web Services](https://aws.amazon.com/),
[Google Cloud](http://cloud.google.com/) or
[Microsoft Azure](http://azure.microsoft.com/)) or on-premises (such as
[OpenStack](../../../getting-started/openstack)). EC3 can provision clusters
running [TORQUE](https://github.com/adaptivecomputing/torque),
[SLURM](http://slurm.schedmd.com/),
[HTCondor](https://research.cs.wisc.edu/htcondor/),
[Apache Mesos](http://mesos.apache.org/), [Nomad](https://www.nomadproject.io/),
[Kubernetes](https://kubernetes.io/) and others, which will be automatically
resized to fit the load (e.g. number of jobs at the batch system).

{{% alert title="Note" color="info" %}} EC3 was presented in one of the
[EGI Webinars](https://www.egi.eu/trainings-and-webinars/). Please see more details on the
[Indico page](https://indico.egi.eu/event/5092/) and check out the video
recording on [YouTube](https://youtu.be/cN0tTBjV3I8). {{% /alert %}}

The following section of the documentation will guide you on how to:

- Deploy a simple EC3 elastic cluster on top of the IaaS providers of the EGI
  Cloud, either using the web interface or the command-line interface, and
- Run pre-configured scientific applications in the EC3 elastic cluster.
