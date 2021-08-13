---
title: "Getting Started"
linkTitle: "Getting Started"
type: docs
weight: 5
draft: true
description: >
  Introduction to using EGI FedCloud services
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

Access to EGI High Throughput Compute resources is based on
[Virtual Organisations](../check-in/vos), which
rely on [X.509 proxy certificates with VOMS extensions](../check-in/vos/voms).
Users have to enroll into one VO before using the service.

VOs are fully managed by research communities, allowing them to manage their
users and grant access to their services and resources. This means communities
can either own their resources and use EGI services to share (federate) them,
or can use the resources available in the EGI infrastructure for their
scientific needs.

## Capacity allocation

...

## Unused resources

Users in the EGI FedCloud may gain opportunistic usage to unused resources.
These are resources that are not dedicated to the user's organization, but are
accessible when the research center(s) have some spare resources.
This enables the most efficient use of resources.

{{% alert title="Note" color="info" %}} Users should not reply on (unused)
resources not dedicated to their organisations, as access can be lost without
warning, and data may be lost if not properly backed up.
{{% /alert %}}
