---
title: "Collaboration Tools"
type: docs
weight: 20
description: >
  Fostering Collaboration across the EGI Federation
---

## What is it?

The EGI Collaboration Tools are a set of online services maintained by the EGI
Foundation and meant to support collaboration across the EGI Federation,
supporting its daily activities (sharing information and documents, organising
meetings, communicating in task or project specific groups...).

{{% alert title="Note" color="info" %}} Component-specific documentation is
maintained by the upstream software providers. {{% /alert %}}

## What are the components?

### EGI Single Sign On (EGI SSO)

Central authentication and authorisation service allowing to use a single
username and password to access various Collaboration Tools.

Group owners can manage group members, and send invitations to new users. Groups
are used in Collaboration Tools services for authorisation.

> EGI SSO is now being deprecated in favour of
> [EGI Check-in](../../users/check-in), providing a federation authentication
> and authorisation service.

### EGI.eu domain

Domain entries can be created for the service as long as they are relevant for
the EGI infrastructure. All EGI central services are usually available under the
egi.eu domain.

Requests needs to be discussed with the
[EGI Operations team](mailto:operations@egi.eu).

### EGI.eu website

Information about the EGI Federation activities is published on the
[public web site](https://www.egi.eu).

### Wiki

A [Confluence-based](https://www.atlassian.com/software/confluence/guides)
"Wiki" space is available, allowing the EGI members to work collaboratively on
documenting many aspects like Service Management,
[Polices and Procedures](https://confluence.egi.eu/display/EGIPP) or activities
from [Boards and Groups](https://confluence.egi.eu/display/EGIBG).

Separate instances for EGI and EOSC are operated by EGI Foundation.

### Issues management

#### Jira

EGI internal request tracking system, meant to support the Service Management
System and projects.

EGI Foundation is operating dedicated instances for EGI and EOSC.

#### Request Tracking (RT)

EGI internal request tracking system, being replaced for many activities by
Jira.

### Mailing lists

Many mailing lists exists to cover specific areas of collaboration. New ones can
be crated on request as documented below.

Membership in mailing lists is usually determined by membership in EGI SSO
groups. Only group owners can manage the group membership.

Note that canonical addresses are `list-name@mailman.egi.eu`, not
`list-name@egi.eu`.

See the [dedicated page on mailing list](./mailing-lists) for more information
like how to request the creation of a new mailing list.

### Document server

[EGI Documentation database](https://documents.egi.eu), hosting many published
document relevant to the EGI Federation.

Documents have metadata describing them and can be versioned. EGI SSO groups are
used for restricting access to documents.

### Agenda management via Indico

Event planner, used for various conferences and meetings, powered by the
[Indico](https://getindico.io/) product.

All users with an SSO account can use it.

Indico also has its own local accounts, which can be used by people who do not
want an EGI SSO account, but want to register to some meeting in Indico.

## Contact

EGI Collaboration Tools support can be contacted via:

- [EGI Helpdesk](../helpdesk) Support Unit "Collaboration Tools"
- [EGI IT Support](mailto:it-support@egi.eu)
