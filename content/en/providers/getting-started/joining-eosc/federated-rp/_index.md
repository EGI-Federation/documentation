---
title: "Joining as a Federated Resource Provider - Resource Centre"
weight: 100
description:
  "Guidelines for Resource Centres to join the EOSC Compute Platform"
type: "docs"
---

## Introduction

A Resource Centre (RC) is the smallest resource administration domain in the
EGI Federation. It can be either localised or geographically distributed and
provides a minimum set of local or remote IT Services compliant with
well-defined IT Capabilities (HTC, Cloud, Storage, etc.) necessary to make
resources accessible to Users. EGI is a Resource Infrastructure federating RCs
to constitute a homogeneous operational domain.

## Registration and certification

In order to join the EOSC Compute platform, a RC needs to present the request
to the Research Infrastructure Provider (RP) existing in its country. A RP is
a legal organisation, part of large Resource Infrastructures like EGI,
responsible for managing and operating a number of operational services at
national level supporting RCs and user communities that contribute to such RIs.
Please have a look at the
[Operations Start Guide](../../../operations_start_guide) to get familiar with
the terms mentioned above and to have a complete picture of the several actors
participating in our landscape.

The RP operators are going to guide and support the RC during the registration
and certification procedures. First, the RC will be asked to read, understand,
and accept:
- the [“RCs Operational Level Agreement”](https://documents.egi.eu/document/31),
  an agreement made between the RC and its RP that defines the minimum set of
  operational services and the respective quality parameters that a Resource
  Centre is required to provide in EGI;
- the [Security Policies](https://confluence.egi.eu/x/9wbSB) defined in EGI to
  guarantee that all the security aspects with the service delivery are
  fulfilled and enforced.

The next step is registering the RC in the EGI
[Configuration Database](https://goc.egi.eu/): the provided information, from
the generic contacts and roles of people to the service endpoints details will
be needed to trigger the daily operations of other services and activities
provided by the EGI Infrastructure such as the Monitoring of the resources, the
Accounting, the Support, and the security activities.

![Diagram of the RCs status flow](SiteStatusFlow.png)

Once the entry in the Configuration Database is complete, the RP changes the RC
status from “Candidate” to “Uncertified”, and the certification procedure can
start: it comprises a series of technical controls to verify that the provided
services work according to the expectations in the RC OLA. Any identified issue
is notified by the RP operators to the RC and investigated until its solution.

When all the certification controls are successfully passed, the RC status is
changed to “Certified” meaning that the RC is included in the production
infrastructure and its resources can be consumed by the users of the
infrastructure.

## Setting up agreements with customers

Once moved to the production infrastructure, a RC is ready to deliver its
resources to any of the users’ communities consuming the infrastructure. Here
the Service Level Management (SLM) process intervenes as a matchmaker between
service expectations and needs of the Virtual Organisations (VOs)17 and the
capabilities of the RCs. During the selection of the providers for service
provisioning, technical requirements collected from the customer are used by EGI
to launch a call open to all of the providers. The Expression of Interests (EoIs)
collected during the negotiation phase will be used to identify the provider(s)
that best match the customer's requirements and expectations. From a technical
perspective, several aspects will be considered during the negotiation phase
including the geographical location of the customer, national roadmap and priority
of the providers, and costs of the service provisioning in case of a pay-for-use
model.

In case the negotiation phase ends positively, the selected provider(s) will:
- Define a VO Operational Level Agreement(s) (OLA) with EGI Foundation for
  providing the services through the EGI Portfolio to support the user community.
  EGI Foundation will share with the RCs a draft of the document(s) based on a
  predefined template and customised with the details of the specific Agreement(s),
  such as:
  - the main contacts to be used for communications related to the service(s);
  - the duration of the Agreement;
  - conditions for operating the service (service hours and exceptions);
  - Service Level Targets;
  - if the resources are exclusively allocated or are subject to local
    availability;
  - the payment mode;
  - responsibility in case of violations and complaints;
  - any limitations and constraints (if any);
  - the frequency of service performance reports.
- Configure the service(s) in the scope of the Agreement(s) enabling the support of
  the Customer's VO and activating the monitoring of the services/resources.

At the same time, EGI Foundation sets up a VO Service Level Agreement (SLA) with the
given user community for the provisioning of the requested service. The EGI VO SLA is
secured with related EGI VO OLAs and is agreed on a case-by-case basis (Fig.3).
