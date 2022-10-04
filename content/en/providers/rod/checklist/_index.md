---
title: "Checklist"
weight: 1
type: docs
description: Summary of the information and guidelines needed by ROD
---

## Welcome on board!

This page was created to help you, as a ROD, start with ROD duties.

The section [How to become a ROD member](#how-to-become-a-rod-member) describes
steps which needs to be taken before starting working as a ROD. The section
[ROD duties](#rod-duties) documents all the tasks that make up the ROD duties.
Section [Important to read](#important-to-read) introduces all documents which
concern this activity and which are supposed to be read at the beginning.
Section [Tools](#tools) describes all tools used by ROD teams. Finally,
[Contact](#contact) section is going to inform you how to contact others.

## How to become a ROD member

There are few actions which needs to be taken before you start your work:

1. Get a valid grid certificate delivered by Certificate Authorities (CA) - this
   step is important because most of the tools used during the shift require
   certificate. [Find](http://www.eugridpma.org/members/worldmap/) EUGRIDPMA
   members.
2. [Register to Dteam VO](https://voms2.hellasgrid.gr:8443/voms/dteam/). Dteam
   membership will give you possibility to test sites and debug problems.
3. [Register into GGUS tool as support staff](../../../internal/helpdesk/account-and-privileges/#getting-supporter-privileges).
   GGUS is a ticketing system which is used for operational purpose within EGI.
   With support staff role you will be able to reply on and update recorded
   tickets.
4. [Register](https://goc.egi.eu/portal/index.php?Page_Type=Role_Requests) in
   [Configuration Database](../../../internal/configuration-database), a central
   database which contains all the information about EGI Infrastructure (sites
   and people). To be ROD members you have to be registered in this database. It
   will allows you to perform step 5.
5. Request the **Regional Staff** role in the Configuration Database. Thanks to
   this role you will be recognized automatically in operations tools as ROD
   member. It gives you a several privileges in the database as well as in other
   tools.
6. Contact your NGI manager - you need to contact your NGI manager to be
   approved as **Regional Staff** and to be added to ROD mailing list in your
   NGI (this mailing list is a contact point to the whole ROD team within the
   NGI).
7. Get familiar with the [ROD documentation](../../rod), a single place where
   you will find all information relevant to your work as a ROD.

To see how to perform all those actions please watch video
[How to become a ROD member](http://www.youtube.com/watch?v=p-SrqJMDlOo) (7
steps which should be done to become a ROD member also).

## ROD duties

The Regional Operations team is responsible for detecting problems, coordinating
the diagnosis, and monitoring the problems through to a resolution. It monitors
sites in their region, and react to problems identified by the monitors, either
directly or indirectly, provide support to sites as needed, add to the knowledge
base, and provide informational flow to oversight bodies in cases of
non-reactive or non-responsive sites. ROD is a team responsible for solving
problems on the infrastructure according to agreed procedures. They ensure that
problems are properly recorded and progress according to specified time lines.
They ensure that necessary information is available to all parties. The team is
provided by each Operation Centre and requires procedural knowledge on the
process (rather than technical skills) for their work.

All duties listed are mandatory for ROD team:

- Handling incidents. The main responsibility of ROD is to deal with incidents
  at sites in the region. This includes making sure that the tickets are opened
  and handled properly. The procedure for handling tickets is described in
  [EGI Infrastructure Oversight escalation procedure](https://go.egi.eu/proc01)
- Propagate actions from EGI Operations down to sites. ROD is responsible for
  ensuring that decisions taken on the EGI Operations level are propagated to
  sites.
- Putting a site in downtime or suspend for urgent matters. In general, ROD can
  place a site in downtime (in the
  [Configuration Database](../../../internal/configuration-database/downtimes))
  if it is either requested by the site, or ROD sees an urgent need to put the
  site into downtime. ROD may also suspend a site, under exceptional
  circumstances, without going through all the steps of the escalation
  procedure. For example, if a security hazard occurs, ROD must suspend a site
  on the spot in the case of such an emergency. It is important to know that EGI
  Operations can also suspend a site in the case of an emergency e.g. security
  incidents or lack of response.
- Notify **EGI Operations** about core or urgent matters. ROD should create
  [Helpdesk](../../../internal/helpdesk) tickets to **EGI Operations** in the
  case of core or urgent matters.

## Important to read

Before you start your duties you should get familiar with following documents:

- [EGI Infrastructure Oversight escalation procedure](https://go.egi.eu/proc01).
  This document defines escalation procedure for operational problems. It
  describes steps and timelines which ROD team should follow.
- [Dashboard How-Tos and Training Guides](https://documents.egi.eu/document/301).
  A collection of How-Tos and guides for EGI Operations. It includes a Dashboard
  How-To, Training Guides which can be used as a presentation for training staff
  and quick sheets.
- [ROD FAQ](../faq). Frequently Asked Questions related to ROD work

It is also important to watch [video tutorials](../#manuals-and-procedures)
prepared for ROD teams. They will walk you through several topics which are
important for your work.

### Operational Tools

ROD uses several operational tools to perform theirs duties
([Operations tools video](http://www.youtube.com/watch?v=bNm4oupAmqI)):

- [Operations Portal](../../../internal/operations-portal/). Dashboard tool on
  the Operations Portal is a main tool which is used by ROD teams. All actions
  concerning incidents (alarms and tickets) should be performed using this tool.
- [Service Monitoring (ARGO)](../../../internal/monitoring/) is the official EGI
  monitoring system based on Nagios. It checks the availability of the services
  and creates alarms visible on the Operations Portal dashboard when a failure
  occurs.
- [Helpdesk](../../../internal/helpdesk/) is the EGI central helpdesk system
  designed for reporting and tracking problems.
- [Configuration Database](../../../internal/configuration-database/) is a
  central database which contains all static information about the
  infrastructure (sites and people).

## Contact

Each ROD teams is supposed to provide own mailing list as a contact point to the
team. The list of people responsible for ROD in a given NGI and contact points
can be found in the
[EGI Configuration Database](../../../internal/configuration-database).

All ROD mailing list are subscribed to "all-central-operator-on-duty AT
mailman.egi.eu" mailing list so to contact other ROD teams you can use this
list.

To contact EGI Operations team you can:

- send an [Helpdesk](../../../internal/helpdesk) ticket and assign it to **EGI
  Operation** support unit
- send an email to "operations AT egi.eu"

You are welcome to send us questions in case of any doubts concerning ROD
duties.
