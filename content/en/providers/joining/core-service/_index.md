---
title: "Joining as a provider of a Core Service"
weight: 40
description: "Guidelines for joining the EGI Infrastructure to provide a Core
Service supporting the other services and activities"
type: "docs"
---

## Introduction

- With the term "Central" or "Core" Service we refer to a category of services
  in the EGI Infrastructure providing capabilities that support and complement
  the other services of the infrastructure and the related activities. A list of
  those services is available in the section
  [Services for Federation](https://www.egi.eu/services/federation/) of our
  site.
- The EGI Core Services are co-funded by EGI Foundation and the providers are
  selected through a bidding process: the technical details of the services that
  should be delivered are advertised to the
  [EGI Council](https://confluence.egi.eu/display/EGIG/EGI+Council), and only
  the providers with the
  [EGI Participant](https://confluence.egi.eu/display/EGIG/EGI+Participant) role
  in the Council can apply to the bid.
  - [How to join the EGI Federation](https://www.egi.eu/join-the-egi-federation/)
    as a member of the Council.
  - [Current members](https://www.egi.eu/egi-federation/#council) of the EGI
    Council
- Differently from services with a distributed nature such as HTC, Cloud, and
  Storage, they cannot be ordered through the Marketplace, but they become
  available as soon as a user joins the infrastructure (e.g., the access to the
  [EGI Helpdesk](../../../internal/helpdesk) service).

## Selection of the providers and registration

With the selected providers, EGI Foundation negotiates and signs an
[OLA](https://confluence.egi.eu/display/EGIG/Operational+Level+Agreement)
defining the terms and conditions for the delivery of the services; at the same
time, the process to add the services to the
[EGI Service portfolio](https://www.egi.eu/services/) is started, if the service
is not already included.

At this point, steps, similar to the ones for
[Resource Centers](../federated-resource-centre) and
[Technology Providers](../technology-provider), follow in order to guarantee the
regular day-to-day operation of the service, such as:

- registration in the
  [Configuration Database](../../../internal/configuration-database) and
  certification;
- definition of the Support Unit in the
  [Helpdesk](../../../internal/helpdesk) system to handle incidents and
  service requests;
- enabling of the monitoring;
- periodic performance reports as defined in the given OLA to verify that the
  Service Level Targets are achieved.

In addition to this, the providers are also requested to create a
[capacity plan](#capacity-plan), an
[availability and continuity plan](#availability-and-continuity-plan), and to
interact with [Change Management (CHM)](https://go.egi.eu/chm) and
[Release and Deployment Management (RDM)](https://go.egi.eu/rdm) processes for
[managing changes and new releases](#managing-changes-and-new-releases) of their
services.

## Capacity plan

> The capacity plan is important to assess if the capacity of the service is
> sufficient to respond to the current and to the future demand of the service.

Any capacity aspect of the service delivery is analysed (human, technical, and
financial) with the definition of quantitative parameters to measure the usage
and the load of the service. The approach to adjust the capacity of the service
in relation to a change in the demand is defined, and recommendations on
capacity requirements for the next reporting period are provided as well.

EGI Foundation defined a template for the Capacity plans and contacts and
supports the service providers for the creation of a new Capacity plan or for
their regular reviews (the reviews are usually performed at least twice per
year).

## Availability and continuity plan

In the Availability and Continuity plan, a number of risks affecting the
availability and continuity of the service is identified and assessed: each risk
is rated in terms of likelihood and impact with the definition of
countermeasures to implement that should avoid the occurrence of the given risk.
Any remaining vulnerability is identified as well, and in case the rating of a
risk is considered to be too high in relation to the risk acceptance criteria, a
plan either to improve the existing countermeasures or to implement new ones is
created, with the aim either to reduce the likelihood of a risk or to mitigate
the impact in case a risk occurs.

The plan is completed by a continuity and recovery test, where the continuity of
the service and its recovery capacity are tested against a simulated disruption
scenario: the performance of this test is useful to spot any issue in the
recovery procedures of the service.

Also in this case, the discussion of the Availability and Continuity plan is
started and overseen by EGI Foundation who shares with the providers a template
that will be filled in with the details of the given service. Availability and
Continuity plans are reviewed on a yearly basis.

## Managing changes and new releases

> All changes to the services should follow the EGI Change Management (CHM)
> process according to the [Change Policy](https://go.egi.eu/chm-policy), in
> order to evaluate the potential impact that a change can have on the service
> and on the infrastructure as a whole.

When registering a
[Request for Change](https://confluence.egi.eu/display/EGIG/Request+For+Change),
besides a general description of the change, the providers are expected to
provide:

- the risk level as a result of assessing the impact and the likelihood of
  things going wrong,
- the type of change,
- the eventual list of other services potentially affected by the change,
- if it is possible to revert the change,
- the proposed date for the implementation of the change,
- if it is needed to schedule a downtime of the service.

Requests for Changes are assessed by the Change Advisory Board (CAB), deciding
whether the Change is going to be approved or rejected.

For recurrent changes with a relatively low risk level, the providers can
request to classify them as Standard Changes, so that invoking the CAB won’t be
necessary and they can undergo the release process after the release plan is
agreed with the EGI CHM staff.

The Emergency Changes are created when there is an urgent need to fix either a
newly discovered security vulnerability or a critical issue: in this case the
formal approval of the CAB is not required, and it is enough that the release
plan is accepted by CHM staff.

In all of the other situations the changes are classified as Normal and
depending on their risk level they might need to be assessed by the CAB.

Before the release in the production environment, the providers may invite the
users or other impacted service providers, to test the new changes on a
pre-production instance in order to gather feedback and to find out possible
issues that might be overlooked during the preparation of the new release. If no
problems are found, the release can go live, and a Post Implementation Review is
conducted after a few days to close the case.

## Security aspects

The providers of central services are subject to the same policies, procedures
and requirements applying to the federated service providers, as documented at
[this page](https://go.egi.eu/policies-procedures-internal-service-providers).

Nevertheless, they are also subject to the following requirement that is
documented in the service OLA that is being agreed with them:

- They should immediately report suspected security incidents to the EGI
  Foundation. This is not exempting them to follow the
  [SEC01 EGI CSIRT Security Incident Handling Procedure](https://go.egi.eu/sec01)
  and inform EGI CSIRT within 4 hours.

It's also important to understand that when processing of personal data is
taking place, EGI Foundation holds the role of Data Controller and the provider
is a Data Processor, as defined in the
[Global Data Protection Regulation (GDPR)](https://gdpr.eu/article-4-definitions/).

- Data Processing Agreements, regulating the conditions and constraints of the
  data processing activities conducted by the Data Processor on behalf of the
  Data controller, will be put in place on the initiative of the EGI Foundation
  staff.
- EGI Foundation will also prepare, together with the service provider, adequate
  Privacy Notice and Acceptable Use policy that have to be presented and made
  available to the users of the service.
- EGI Foundation is also complying with all the principles set out by the REFEDS
  Data Protection Code of Conduct in its most
  [recent version](https://wiki.refeds.org/display/CODE/Data+Protection+Code+of+Conduct+Home),
  implying that the central service provider should also comply with them.

The central service provider should also follow requirements relating to the
software and covering the usage of a proper licence, the access to and
management of the source code, implementation of best practices; as well as
requirements relating to the IT Service management and covering the need for
having key staff properly trained about IT Service Management, committing to
continual improvement and having their
[Service Management System (SMS)](https://confluence.egi.eu/display/EGIG/Service+management+system)
interfacing with the EGI SMS, especially for important processes like the Change
Management process.
