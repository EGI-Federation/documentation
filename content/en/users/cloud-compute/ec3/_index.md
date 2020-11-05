---
title: "EC3"
type: docs
weight: 80
description: >
  Using the Elastic Cloud Compute Cluster on EGI Cloud
---

[EC3](http://servproject.i3m.upv.es/ec3/) (Elastic Cloud Compute Cluster) is a
tool to create elastic virtual clusters on Infrastructure as a Service
(IaaS) providers, either public (such as [Amazon Web Services](https://aws.amazon.com/), 
[Google Cloud](http://cloud.google.com/) or [Microsoft Azure](http://azure.microsoft.com/)) 
or on-premises (such as [OpenNebula](http://www.opennebula.org/) and 
[OpenStack](http://www.openstack.org/)).
It supports the provisioning of clusters running
[TORQUE](http://www.adaptivecomputing.com/products/open-source/torque),
[SLURM](http://slurm.schedmd.com/), [HTCondor](https://research.cs.wisc.edu/htcondor/), 
[Mesos](http://mesos.apache.org/), [Nomad](https://www.nomadproject.io/), 
[Kubernetes](https://kubernetes.io/) and others that will be
automatically resized to fit the load (e.g. number of jobs at the batch system).

The following section of the documentation will guide you on how to:

- Request access to EC3,
- Deploy simple EC3 elastic cluster on top of the IaaS providers of the EGI Cloud,
  either using the web interface or the command-line interface,
- Run pre-configured scientific applications in the EC3 elastic cluster.
