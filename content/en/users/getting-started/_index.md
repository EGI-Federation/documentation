---
title: "Getting Started"
linkTitle: "Getting Started"
type: docs
weight: 5
description: >
  Introduction to EGI FedCloud
---

## Overview

EGI is a federation of computing and storage resource providers
united by a mission to support research and innovation.

The resources in the EGI Federated Cloud (FedCloud) are offered by
Infrastructure-as-a-Service (IaaS) [service providers](https://www.egi.eu/federation/egi-federated-cloud/)
that either run their own [data centers](https://www.egi.eu/federation/data-centres/)
or rely on community, private and/or public cloud services.
Most services in the EGI Cloud are based on [OpenStack](openstack) deployments.

On top of the resources in the EGI FedCloud, a multitude of academic
communities (clouds) were created, each with their own virtualised resources
built around open standards. The development of these academic/researsh clouds
is driven by requirements of the scientific community.

{{% alert title="Tip" color="info" %}} See also an
[overview](https://www.egi.eu/federation/egi-federated-cloud/the-egi-federated-cloud-architecture/)
and a [technical summary](architecture) of the
EGI Federated Cloud architecture.
{{% /alert %}}

## Accessing resources

Access to resources (services) in EGI FedCloud is based on X.509 certificates.
The certificates are issued by Certification Authorities (CAs) part of the
[European Policy Management Authority for Grid Authentication](https://www.eugridpma.org)
(EUGridPMA), which is also part of the
[International Global Trust Federation](https://www.igtf.net) (IGTF).

**EGI FedCloud uses [Virtual Organisations](../check-in/vos) (VOs) to control
access to resources**. VOs are fully managed by research communities, allowing
communitites to manage their users and grant access to their services and
resources. This means communities can either own their resources and use EGI
services to share (federate) them, or can use the resources available in the
EGI infrastructure for their scientific needs.

Before users can access a service in the EGI FedCloud, they have to:

1. Obtain an X.509 certficate, by signing up either with [EGI Check-in](../check-in/signup)
   directly, or with one of the community identity providers from the
   EGI infrastructure.
1. Enroll into one VO before they can use most of the services, as users are
   not individually granted access to resources.
1. Add the certificate to their Internet browser of choice, or import it into
   the appropriate certificate store (on Windows).
1. If they want to use [command line tools](cli), they will also have to
   obtain OIDC access and refresh tokens.

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
  but it's possible with various institutional accounts (through EduGAIN) or
  with a social IDs (e.g. Google). Example: the
  [open instance of the EGI Notebooks](https://notebooks.egi.eu/)
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
   - If there are providers happy to support you, we will sign a Service Level
     Agreement (SLA) with you
   - A new VO will be created for your community

## Unused resources

Users in the EGI FedCloud may gain opportunistic usage to unused resources.
These are resources that are not dedicated to the user's organization, but are
accessible when the research center(s) have some spare resources.
This enables the most efficient use of resources.

{{% alert title="Note" color="info" %}} Users should not rely on (unused)
resources not dedicated to their organisation, as access can be revoked without
warning, and data may be lost if not properly backed up.
{{% /alert %}}
