---
title: "Getting Started"
type: docs
weight: 10
description: >
  Introduction to EGI services
---

## Overview

EGI is a federation of computing and storage resource providers united by a
mission to support research and innovation.

The resources in the EGI infrastructure are offered by
[service providers](https://www.egi.eu/federation/egi-federated-cloud/) that
either run their own [data centers](https://www.egi.eu/federation/data-centres/)
or rely on community, private and/or public cloud services. These service
providers offer:

- **Single Sign-On** via [EGI Check-in](https://www.egi.eu/services/check-in/)
  allows users to login with their institutional (community) credentials
- **Global image catalogue** at [AppDB](https://appdb.egi.eu) with
  pre-configured virtual machine images
- **Resource discovery** features to easily understand which providers are
  supporting your community, and what are their capabilities
- **Global accounting** that
  [aggregates and allows visualisation](https://accounting.egi.eu/cloud/) of
  usage information
- **Monitoring of availability and reliability** to
  [ensure SLAs are met](https://argo.egi.eu/egi/report-status/Critical/SITES?filter=FedCloud)

The EGI infrastructure supports a multitude of science and research communities,
each with their own virtualised resources built around open standards. The
development of these communities is driven by by their own scientific
requirements.

{{% alert title="Tip" color="info" %}} See also an
[overview](https://www.egi.eu/federation/egi-federated-cloud/the-egi-federated-cloud-architecture/)
of the EGI FedCloud architecture, or read about the [task force](task-force)
supporting it. {{% /alert %}}

## Accessing resources

Access to resources (services) in the EGI infrastructure is based on
[OpenID Connect](http://openid.net/connect/) (OIDC), which replaces the legacy
authentication and authorization based on
[X.509 certificates](../check-in/vos/voms).

{{% alert title="Note" color="info" %}} Some services still rely on X.509
certificates, e.g. [High Throughput Compute](../high-throughput-compute).
{{% /alert %}}

**EGI uses [Virtual Organisations](https://confluence.egi.eu/display/EGIG/Virtual+organisation)
(VOs) to control access to resources**. VOs are fully managed by research communities, allowing
communitites to manage their users and grant access to their services and
resources. This means communities can either own their resources and use EGI
services to share (federate) them, or can use the resources available in the EGI
infrastructure for their scientific needs.

Before users can access an EGI service, they have to:

1. Obtain a supported ID, by signing up with either
   [EGI Check-in](../check-in/signup) directly, or with one of the community
   identity providers from the EGI infrastructure.
1. [Enroll into one VO](../check-in/joining-virtual-organisation/). Users need
   to be part of a VO before using EGI services. Explore the list of available
   VOs in the [Operations Portal](https://operations-portal.egi.eu/vo/a/list).
1. Authenticate to [EGI Check-in](../check-in) to obtain an OAuth2 access token
   (and optionally a refresh token).
1. Manage or use the service by leveraging the access token, either implicitly
   (web interfaces and dashboards usually hide this from users) or explicitly
   (e.g. when using [command-line tools](cli)).

{{% alert title="Note" color="info" %}} See the [EGI Check-in](../check-in)
documentation for a detailed description of the Authentication and Authorization
Infrastructure (AAI) of the EGI Federation, and to gain a better understanding
of the concepts that act as building blocks for the AAI implementation.
{{% /alert %}}

## Requesting resources

Depending on the access conditions, a service (or an instance of the service)
may be open for any user, or it may require requesting access (ordering). The
[EGI site](https://www.egi.eu/services/) together with the connected
[EGI Marketplace](https://marketplace.egi.eu) streamlines the ordering process.

EGI services use the following types of access conditions:

- **Wide access** - Users can freely access the service. Login may be required
  but it is possible with various institutional accounts (through
  [EduGAIN](https://edugain.org)), or with social accounts (e.g. Google). For
  example you can [create a test Virtual Machine](../tutorials/create-your-first-virtual-machine/)
  or launch a [Jupyter Notebook](../notebooks/).
- **Policy based** - Users are granted access based on specific policies defined
  by the service providers. Access needs to be requested, and will be checked
  for such services. Example: Compute resources and tools allocated to
  researchers in medical imaging ([Biomed VO](http://lsgc.org/biomed.html)).
- **Pay-for-use** - Services are provided for a fee. Example:
  [FitSM In-house course](https://www.egi.eu/services/fitsm-training/in-house-training/)

The EGI user community support team handles access requests (orders) for the
_Policy based_ and _Pay-for-use_ access modes. They will respond to the request
within maximum 5 work days. We normally contact you to have a short
teleconference meeting to better understand your requirements, and to be able to
identify resources and services that best match your needs. The meeting
typically covers two topics:

- **What is the background of your request?** Scientific domain, partner
  countries, user bases, pay-for-use or not, etc.
- **What are the technical details of your use case?** How many CPU cores, how
  much RAM per CPU, which software services, and for how long do you need them,
  etc.

[Contact us](https://www.egi.eu/contact/) if you want to discuss further.

## Capacity allocation

When EGI is able to support a request for resources, it can do so in two ways:

1. **We grant you access to an existing service**, for example to compute
   resource pools (Virtual Organisations) that already exist in EGI for specific
   scientific disciplines or for researchers in specific regions. You can
   browse these in the
   [EGI Operations Portal](https://operations-portal.egi.eu/vo/a/list). If there
   is a suitable VO, we help you join it and use its services.
1. **We create a new VO for your community** when none of the existing resource
   pools are suitable for your use case. The procedure is as follows:
   - We will contact our provider and negotiate resources for you
   - If there are providers willing to support you, we will sign a Service Level
     Agreement (SLA) with you
   - A new VO will be created for your community

## Pilot your application

EGI offers a playground allocation for users to get access to the services and
understand how to port applications and develop new data analytics tools that
can be turn into online services that can be accessed by scientist worldwide.

### Requirements and user registration

Access **requires** acceptance of
[Acceptable Use Policy (AUP) and Conditions of the \'EGI Applications on Demand Service\'](https://documents.egi.eu/public/ShowDocument?docid=2635).

{{% alert title="Acknowledgment" color="info" %}}

Users of the service are asked to provide appropriate acknowledgement of the use
in scientific publications. The following acknowledgement text can be used for
this purpose (you should adapt to match the exact providers in your case):

**This work used advanced computing resources from the 100%IT, CESGA, CLOUDIFIN,
CYFRONET-CLOUD, GSI-LCG2, IFCA-LCG2, IN2P3-IRES, INFN-CATANIA-STACK,
INFN-PADOVA-STACK, SCAI, TR-FC1-ULAKBIM, UA-BITP and UNIV-LILLE resource centres
of the EGI federation. The services are co-funded by the EGI-ACE project (grant
number 101017567).** {{% /alert %}}

When requesting access users are guided through a registration process. Members
of the EGI support team will perform a lightweight vetting process to validate
the users' requests before granting the access to the resources.

### Get access to pilot allocation

1. Log into the [EGI Marketplace](https://marketplace.egi.eu) with the
   [EGI AAI Check-In service](../check-in).
1. Setup a profile, including details about your affiliation and role within a
   research institute/project/team.
1. Navigate the marketplace top-menu and click on the category:
   **Applications**.
1. Click on the **Applications on Demand** service and submit an order for one
   of the available applications.
1. When the request is approved, run the requested application(s) as described
   below.

Please check the
[EGI Marketplace guide](https://wiki.egi.eu/wiki/HowToAccessTheEGIMarketPlace)
for further details.

### Services available

Once granted access, each user will have a grant with a predefined quota of
resources, which can be used to run the application of choice. This grant
includes:

- up to 4 CPU cores,
- 8 GB of RAM,
- 100GB of block storage.

The grant to run applications is initially valid for 6 months and can be
extended/renewed upon request. These resources are delivered
[through the vo.access.egi.eu VO](https://documents.egi.eu/public/ShowDocument?docid=2773).

You can manage those resources via [command-line](cli) or any of the
dashboards of the EGI Cloud: the [VMOps dashboard](../cloud-compute/monitor)
and the [IM dashboard](../cloud-orchestration/dashboard).

You can also easily access scientific applications:

- [Chipster](https://marketplace.egi.eu/applications-on-demand/68-chipster.html)
  a user-friendly analysis software for high-throughput data. It contains over
  300 analysis tools for next generation sequencing (NGS), microarray,
  proteomics and sequence data. The application is available through the Science
  Software on Demand Service (SSoD). You can access the
  [EGI Chipster instace](https://chipster.fedcloud-tf.fedcloud.eu/)
- [EC3](../ec3) has a list of [applications](../ec3/apps/) that you can
  easily start from the
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php)

## Unused resources

Users of the EGI services may gain opportunistic usage to unused resources.
These are resources that are not dedicated to the user's organization, but are
accessible when the research center(s) have some spare resources. This enables
the most efficient use of resources.

{{% alert title="Note" color="info" %}} Users should not rely on (unused)
resources not dedicated to their organisation, as access can be revoked without
warning, and data may be lost if not properly backed up. {{% /alert %}}
