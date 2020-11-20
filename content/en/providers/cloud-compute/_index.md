---
title: "Cloud Compute"
description: "IaaS Service providers documentation"
weight: 30
type: "docs"
---

This documentation covers how to join the EGI Cloud federation as a provider. If
you are interested in joining please first contact EGI operations team at
[operations@egi.eu](mailto:operations@egi.eu), expressing interest and
providing few details about:

- the projects you may be involved in as cloud provider

- the user communities you want to support (AKA Virtual Organisations, VO).
  You can also support the 'long-tail of science' through the access.egi.eu VO.

- the technologies (Cloud Management Framework) you want to provide.

- details on the current status of your deployment (to be installed or already
  installed, already used or not, how it is used, who uses the services,...)

Integration of cloud stacks into EGI FedCloud follows a well-defined path, with
certain steps which need to be taken, depending on the cloud stack in question.
By integration here, we refer to the proper interoperation with EGI
infrastructure services such as accounting, monitoring, authentication and
authorisation, _etc_. These configurations make your site discoverable and
usable by the communities you wish to support, and allow EGI to support you in
operational and technical matters.

Integration of these services implies specific configuration actions which you
need to take on your site. These aim to be unintrusive and are mostly to
facilitate access to your site by the communities you wish to support, without
interfering with normal operations. This can be summarised essentially as :

1. Network configuration
1. Permissions configuration
1. AAI configuration
1. Accounting configuration
1. Information system integration
1. VM and appliance repository configuration

If at any time you experience technical difficulties or need support, please
[open a ticket](https://ggus.eu) or discuss the matter with us
[on the forum](https://community.egi.eu)

You can follow find integration guides for your cloud management in this
documentation.
