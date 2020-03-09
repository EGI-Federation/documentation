---
title: "FAQ"
weight: 70
type: "docs"
description: >
  Frequently Asked Questions 
---

## Why joining the EGI Cloud?

-   To support international communities supported by EGI (e.g. [these
    research communities and
    applications](https://www.egi.eu/use-cases/) or [these research
    infrastructures in
    EOSC-hub](https://eosc-hub.eu/research-communities) or [these
    business pilots in the EOSC Digital Innovation
    Hub](https://eosc-hub.eu/digital-innovation-hub).
-   To participate in e-Infrastructure projects (H2020, EOSC) as an EGI
    compliant IaaS cloud provider.
-   To participate in resource allocation and in pay-for-use campaigns
    run by EGI.
-   To align access policies and operational model of your cloud with
    international good practices.
-   To adopt best practices of multi-cloud federation for the benefit of
    your local users.

## Do I lose control on who can access my resources if I join federated cloud?

**No**. EGI uses the concept of Virtual Organisation (VO) to group users.
The resource provider has complete control on which VOs he wants to allow
on its resources and which quotas or restrictions to assign to each VO.
In the case of OpenStack, each VO is mapped to a regular OpenStack project
that can be managed as any other and are isolated to other projects you
may have configured in your deployment. Although not recommended, you
can even restrict the automatic access of users within a VO and manually
enable individual members.

## How many components do I have to install?

Depending on your cloud management framework and the kind of integration
this will vary.

In general, the federation requires your cloud management framework to
be configured to support Federated AAI with EGI Check-in. This may
require changes in your current setup.

Other components are designed to access your cloud management framework
public APIs and do not require modification of your deployment. For
OpenStack, these components can be run on a single VM that encapsulates
them for convenience.

## Which components of my cloud will interact with the federated cloud components?

For OpenStack they are:

-   Keystone
-   Nova
-   Glance
-   Swift (optional)

Users will also interact with:

-   Neutron
-   Cinder

to perform their regular activities.

## How will my daily operational activities change?

For the most part daily operations will not change.

A resource centre part of the EGI Federation, and supporting
international communities, needs to provide support through the EGI
channels. This means following up [GGUS tickets](https://ggus.eu). This
includes requests from user communities and tickets triggered by
failures detected by the monitoring infrastructure.

A resource centre needs to maintain the services federated in EGI
properly configured with the EGI AAI.

The resource centre will have to comply with the operational and
security requirements. All the EGI policies aim at implementing service
provisioning best practices and common requirements. EGI operations may
conduct campaigns targeted to mitigate security vulnerabilities and to
update unsupported operating system and software. These activities are
part of the regular activities of a resource centre anyways (also for
the non-federated ones). EGI and the Operations Centres coordinate these
actions in order to have them implemented in a timely manner.

In summary, most of the site activities that are coordinated by EGI and
the NGIs are already part of the work plan of a well-maintained resource
centre, the additional task for a site manager is to acknowledge to EGI
that the task has been performed.
