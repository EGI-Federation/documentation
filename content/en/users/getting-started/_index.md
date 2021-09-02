---
title: "Getting Started"
linkTitle: "Getting Started"
type: docs
weight: 5
description: >
  Introduction to EGI services
---

## Overview

EGI is a federation of computing and storage resource providers
united by a mission to support research and innovation.

The resources in the EGI infrastructure are offered by
[service providers](https://www.egi.eu/federation/egi-federated-cloud/)
that either run their own [data centers](https://www.egi.eu/federation/data-centres/)
or rely on community, private and/or public cloud services. These service
providers offer:

- **Single Sign-On** via [EGI Check-in](https://www.egi.eu/services/check-in/)
  allows users to login with their institutional (community) credentials
- **Global image catalogue** at [AppDB](https://appdb.egi.eu) with
  pre-configured virtual machine images
- **Resource discovery** features to easily understand which providers are
  supporting your community, and what are their capabilities
- **Global accounting** that
  [aggregates and allows visualisation](https://accounting.egi.eu/cloud/)
  of usage information
- **Monitoring of availability and reliability** to
  [ensure SLAs are met](https://argo.egi.eu/egi/report-status/Critical/SITES?filter=FedCloud)

The EGI infrastructure supports a multitude of science and research
communities, each with their own virtualised resources
built around open standards. The development of these communities
is driven by by their own scientific requirements.

{{% alert title="Tip" color="info" %}} See also an
[overview](https://www.egi.eu/federation/egi-federated-cloud/the-egi-federated-cloud-architecture/)
of the EGI FedCloud architecture, or read about the
[task force](task-force) supporting it.
{{% /alert %}}

## Accessing resources

Access to resources (services) in the EGI infrastructure is based on
[OpenID Connect](http://openid.net/connect/) (OIDC), which replaces the legacy
authentication and authorization based on
[X.509 certificates](../check-in/vos/voms).

{{% alert title="Note" color="info" %}} Some services still rely on
X.509 certificates, e.g. [High Throughput Compute](../high-throughput-compute).
{{% /alert %}}

**EGI uses [Virtual Organisations](../check-in/vos) (VOs) to control
access to resources**. VOs are fully managed by research communities, allowing
communitites to manage their users and grant access to their services and
resources. This means communities can either own their resources and use EGI
services to share (federate) them, or can use the resources available in the
EGI infrastructure for their scientific needs.

Before users can access an EGI service, they have to:

1. Obtain a supported ID, by signing up with either [EGI Check-in](../check-in/signup)
   directly, or with one of the community identity providers from the
   EGI infrastructure.
1. Enroll into one VO before they can use most of the services, as users are
   not individually granted access to resources.
1. Authenticate to [EGI Check-in](../check-in) to obtain an OAuth2 access
   token (and optionally a refresh token).
1. Manage or use the service by leveraging the access token, either implicitly
   (web interfaces and dashboards usually hide this from users) or explicitly
   (e.g. when using [command line tools](cli)).

{{% alert title="Note" color="info" %}} See the [EGI Check-in](../check-in)
documentation for a detailed description of the Authentication and
Authorization Infrastructure (AAI) of the EGI Federation, and to gain a
better understanding of the concepts that act as building blocks for the
AAI implementation.
{{% /alert %}}

## Requesting resources

Depending on the access conditions, a service (or an instance of the service)
may be open for any user, or it may require requesting access (ordering). The
[EGI Website](https://www.egi.eu/services/) together with the connected
[EGI Marketplace](https://marketplace.egi.eu) streamlines the ordering process.

EGI services use the following types of access conditions:

- **Wide access** - Users can freely access the service. Login may be required
  but it is possible with various institutional accounts (through
  [EduGAIN](https://edugain.org)), or with social accounts (e.g. Google).
- **Policy based** - Users are granted access based on specific policies
  defined by the service providers. Access needs to be requested, and will be
  checked for such services. Example: Compute resources and tools allocated to
  researchers in medical imaging ([Biomed VO](http://lsgc.org/biomed.html)).
- **Pay-for-use** - Services are provided for a fee. Example:
  [FitSM In-house course](https://www.egi.eu/services/fitsm-training/in-house-training/)

The EGI user community support team handles access requests (orders) for the
_Policy based_ and _Pay-for-use_ access modes. They will respond to the request
within maximum 5 work days. We normally contact you to have a short
teleconference meeting to better understand your requirements, and to be able
to identify resources and services that best match your needs. The meeting
typically covers two topics:

- **What is the background of your request?** Scientific domain, partner
  countries, user bases, pay-for-use or not, etc.
- **What are the technical details of your use case?** How many CPU cores,
  how much RAM per CPU, which software services, and for how long do you need
  them, etc.

## Capacity allocation

When EGI is able to support a request for resources, it can do so in two ways:

1. **We grant you access to an existing service**, for example to compute
   resource pools (Virtual Organisations) that already exist in EGI for specific
   scientific disciplines or for researchers in specific regions. (You can
   browse these in the
   [EGI Operations Portal](https://operations-portal.egi.eu/vo/a/list). If there
   is a suitable VO, we help you join it and use its services.
1. **We create a new VO for your community** when none of the existing resource
   pools are suitable for your use case. The procedure is as follows:
   - We will contact our provider and negotiate resources for you
   - If there are providers willing to support you, we will sign a Service Level
     Agreement (SLA) with you
   - A new VO will be created for your community

## Unused resources

Users of the EGI services may gain opportunistic usage to unused resources.
These are resources that are not dedicated to the user's organization, but are
accessible when the research center(s) have some spare resources.
This enables the most efficient use of resources.

{{% alert title="Note" color="info" %}} Users should not rely on (unused)
resources not dedicated to their organisation, as access can be revoked without
warning, and data may be lost if not properly backed up.
{{% /alert %}}
