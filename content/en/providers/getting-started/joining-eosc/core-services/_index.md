---
title: "Joining as a provider of a Core Service"
weight: 100
description: "Guidelines for joining the EOSC Compute Platform to provide a Core
Service supporting the other services and activities"
type: "docs"
---

## Introduction

With the term “central” or “core service” we refer to a category of services in
the EOSC Compute Platform (like the service management tools) providing
capabilities that support the other services of the infrastructure and the related
activities. They are delivered through a single instance (with the fail-over and
high-availability mechanisms deemed necessary), and differently from services with
a distributed nature such as HTC, Cloud, and Storage, they cannot be ordered
through the Marketplace, but they become available as soon as a user joins the
infrastructure (e.g., the access to the EGI Helpdesk service).

## Selection of the providers and registration

When a service is co-funded by EGI Foundation, which usually covers part of the
funding associated to a given international project, the providers are selected
through a bidding process: a call of expression of interest is announced and
advertised to the [EGI Council](https://ims.egi.eu/display/EGIG/EGI+Council)
containing the technical details of the services that should be delivered and
then any provider who is an
[EGI Participant](https://ims.egi.eu/display/EGIG/EGI+Participant ) can apply to
the bid.

With the selected providers, EGI Foundation negotiate and sign an OLA defining
terms and conditions for the delivery of the services, starting the process within
Service Portfolio Management (SPM) to add them to the
[EGI Service portfolio](https://www.egi.eu/services/) if not already included. At
this point, similar steps to the ones for resource and technology providers follow
in order to guarantee the regular day-to-day operation of the service, such as:

-	registration in the Configuration Database and certification;
-	definition of the Support Unit in the helpdesk system to handle incidents and
service requests;
- enabling of the monitoring;
- periodic performance reports as defined in the given OLA to verify that the
Service Level Targets are achieved.

In addition to this, the providers are also requested to create a capacity plan,
an availability and continuity plan, and to interact with Change Management (CHM)
and Release and Deployment Management (RDM) processes for managing changes and new
releases of their services.

## Capacity plan

The capacity plan is important to assess if the capacity of the service is
sufficient to respond to the current and to the future demand of the service. Any
capacity aspect of the service delivery is analysed (human, technical, and financial)
with the definition of quantitative parameters to measure the usage and the load of
the service. The approach to adjust the capacity of the service in relation to a
change in the demand is defined and recommendations on capacity requirements for the
next reporting period are provided as well.

EGI Foundation defined a template for the Capacity plans and will contact and support
the service providers either for the creation of a new Capacity plan or for the
review of an existing one (the reviews are usually performed at least twice per year).

## Availability and continuity plan

In the Availability and Continuity plan a number of risks affecting the availability
and continuity of the service is identified and assessed: each risk is rated in terms
of likelihood and impact with the definition of countermeasures to implement that
should avoid the occurrence of the given risk. Any remaining vulnerability is
identified as well, and in case the rating of a risk is considered to be too high in
relation to the risk acceptance criteria, a plan either to improve the existing
countermeasures or to implement new ones is created, with the aim either to reduce
the likelihood of a risk or to mitigate the impact in case a risk occurs.

The plan is completed by a continuity and recovery test, where the continuity of the
service and its recovery capacity are tested against a simulated disruption scenario:
the performance of this test is useful to spot any issue in the recovery procedures
of the service.

Also in this case, the discussion of the Availability and Continuity plan is started
and overseen by EGI Foundation who shares with the providers a template that will be
filled in with the details of the given service. Availability and Continuity plans
are reviewed on a yearly basis.

## Managing changes and new releases

All changes to the services should be managed by the EGI Change Management (CHM)
process according to the
[Change Policy](https://confluence.egi.eu/display/EGIPP/Change+management+policy )
in order to evaluate the potential impact that a change can have on the service itself
and on the infrastructure as a whole. When registering a Request for Change, besides a
general description of the change, the providers are expected to provide: the risk
level as a result of assessing the impact and the likelihood of things going wrong,
the type of change, the eventual list of other services potentially affected by the
change, if it is possible to revert the change, the proposed date for the
implementation of the change, and if it is needed to schedule a downtime of the
service. Requests for Changes are assessed by the Change Advisory Board (CAB), and then
decided whether the Change is going to be approved or rejected.

For the recurrent changes with a relatively low risk level, the providers can request
to classify them as Standard Changes, so that invoking the CAB won’t be necessary and
they can undergo the release process after the release plan is agreed with CHM staff.
The Emergency Changes are created when there is an urgent need to fix either a newly
discovered security vulnerability or a critical issue: also in this case the formal
approval of the CAB is not required but it is enough that the release plan is accepted
by CHM staff. In all of the other situations the changes are classified as Normal and
depending on their risk level they might need to be assessed by the CAB.

Before the release in the production environment, the providers invite the users to test
the new changes on a pre-production instance in order to gather feedback and to find out
possible issues that might be overlooked during the preparation of the new release. If
no problems are found, the release can go live, and a Post-Implementation Review is
conducted after a few days to close the case.

