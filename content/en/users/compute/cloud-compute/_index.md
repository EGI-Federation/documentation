---
title: Federated Cloud Compute
linkTitle: Cloud Compute
type: docs
weight: 10
aliases:
  - /users/cloud-compute
description: >
  Run virtual machines in the EGI Cloud
---

The [EGI Federated Cloud Compute](https://www.egi.eu/services/cloud-compute/) (FedCloud)
service offers a multi-cloud IaaS federation that brings together
research clouds as a scalable computing platform for data and/or compute driven
applications and services for research and science.

This documentation focuses on using the service. Those resource providers
willing to integrate into the service, please see the
[EGI Federated Cloud Integration documentation](../../../providers/cloud-compute).

Cloud Compute gives you the ability to deploy and scale virtual machines
on-demand. It offers computational resources in a secure and isolated
environment controlled via APIs without the overhead of managing physical
servers.

Cloud Compute service is provided through a federation of IaaS cloud sites that
offer:

- Single Sign-On via [EGI Check-in](https://www.egi.eu/service/check-in/),
  users can login into every provider with their institutional credentials and
  use modern industry standards like
  [OpenID Connect](https://openid.net/connect/).
- Global VM image catalogue at [AppDB](https://appdb.egi.eu) with pre-configured
  Virtual Machine images that are automatically replicated to every provider
  based on your community needs.
- Resource discovery features to easily understand which providers are
  supporting your community and what are their capabilities.
- [Global accounting](https://accounting.egi.eu/cloud/) that aggregates and
  allows visualisation of usage information across the whole federation.
- [Monitoring of Availability and Reliability of the providers](https://argo.egi.eu/egi/report-status/Critical/SITES?filter=FedCloud)
  to ensure SLAs are met.

The flexibility of the Infrastructure as a Service can benefit various use cases
and usage models. Besides serving compute/data intensive analysis workflows, Web
services and interactive applications can be also integrated with and hosted on
this infrastructure. Contextualisation and other deployment features can help
application operators fine tune services in the cloud, meeting software (OS and
software packages), hardware (number of cores, amount of RAM, etc.) and other
types of needs (e.g. orchestration, scalability).

Since the opening of the EGI Federated Cloud, the following usage models have
emerged:

- **Service hosting**: the EGI Federated Cloud can be used to host any IT
  service as web servers, databases, etc. Cloud features, as elasticity, can
  help users to provide better performance and reliable services.
  - Example:
    [NBIS Web Services](https://www.egi.eu/article/nbis-toolkit/),
    [Peachnote analysis platform](https://www.egi.eu/news/peachnote-in-unison-with-egi/).
- **Compute and data intensive applications**: for those applications needing
  considerable amount of resources in terms of computation and/or memory and/or
  intensive I/O. Ad-hoc computing environments can be created in the EGI cloud
  providers to satisfy extremly intensive HW resource requirements.
  - Example:
    [VERCE platform](https://www.egi.eu/news/new-egi-use-case-a-close-look-at-the-amatrice-earthquake/),
    [The Genetics of Salmonella Infections](https://www.egi.eu/article/the-genetics-of-salmonella-infections/),
    [The Chipster Platform](https://www.egi.eu/article/new-viruses-implicated-in-fatal-snake-disease/).
- **Datasets repository**: the EGI Cloud can be used to store and manage large
  datasets exploiting the large amount of disk storage available in the
  Federation.
- **Disposable and testing environments**: environments for training or testing
  new developments.
  - Example:
    [Training infrastructure](https://www.egi.eu/services/training-infrastructure/)

Eager to test this service? Have a look at
[how to create your first Virtual Machine in EGI](../../tutorials/create-your-first-virtual-machine).
