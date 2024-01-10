---
title: "Cloud Compute"
description: "IaaS Service providers documentation"
weight: 30
type: "docs"
---

This documentation covers how to join the EGI Cloud federation (also known as
Federated Cloud or FedCloud) as a provider.  If you are interested in joining
please first contact EGI at [support@egi.eu](mailto:support@egi.eu), expressing
interest and providing few details about:

- the projects you may be involved in as a cloud provider
- the user communities you want to support (i.e.
  [Virtual Organisations](https://confluence.egi.eu/display/EGIG/Virtual+organisation)
  or VOs). You can also support the ’long-tail of science’ through the
  vo.access.egi.eu VO
- the technologies (Cloud Management platforms) you want to provide
- details on the current status of your deployment (to be installed or already
  installed, already used or not, how it is used, who uses the services, etc).

Integration of cloud stacks into EGI FedCloud follows a well-defined path,
depending on the particularities of the cloud stack in question. By integration,
we refer to the proper interoperation with EGI infrastructure services such as
accounting, monitoring, authentication and authorisation, etc. These
configurations make your site discoverable and usable by the communities you
wish to support, and allow EGI to support you in operational and technical
matters.

The series of actions that needs to be taken to achieve Cloud integration is
summarised below:

1. **Registration and certification** of the site as a
   [Federated Resource Centre](../joining/federated-resource-centre/). Briefly a
   site parses several intermediate stages - Registered, Candidate,
   Uncertified - until fully Certified.
1. [**Requirements**](./requirements/) - hardware and software, network
   configuration
1. **Registration of endpoints in the Configuration Database**
   ([GOCDB](../../internal/configuration-database/)), a service provided by EGI
   as a central registry to record information about the EGI Infrastructure
   topology and which contains general information about all participating sites
1. **Authentication and Authorization Integration** (AAI), including the setup
   of an `ops` local project that will be used for monitoring your site
1. **Accounting** configuration
1. **Installation validation**

If at any time you experience technical difficulties or need support, please
[open a ticket](https://ggus.eu/). Dedicated integration sessions are available
also on request.
