---
title: Training Infrastructure
linkTitle: Training Infrastructure
type: docs
weight: 150
description: >
  The training infrastructure on EGI Cloud
---

## Overview

The training infrastructure is a resource pool within the EGI Federated
Cloud infrastructure providing IaaS as well as access services (login,
application catalogue and application management portal) for
face-to-face events, online training courses or self-paced learning
modules.

The training infrastructure is integrated with Check-in allowing
trainers to generate short-lived user accounts for training
participants. Such accounts can identify students individually, and for
a limited lifetime - typically few hours or days, depending on the
length of the training event - allow them to interact with the services.

The infrastructure currently includes enough capacity to scale up to
class-room size audiences, approximately up to 100 participants.

## Usage models

The training infrastructure is suitable for two types of courses:

- Cloud computing courses: Such courses teach students about IaaS
  clouds and on how Virtual Appliances, Virtual Machines, block
  storage and other types of 'low level' resources are managed. For
  such courses, the trainer does not need to deploy applications or
  online services in advance of the course. The applications/services
  will be deployed by the students themselves as training exercises.
  Such courses typically target developers or other rather technical
  members of scientific communities or projects.
- Scientific courses: Such courses teach scientists or developers
  about a specific software suite relevant for their work. For example
  a specific gene sequence analysis application, an earthquake
  visualisation tool, or a data processing pipeline. In this
  operational mode, the trainer deploys the domain specific
  application/tool on the training infrastructure before the training
  and the students interact directly with those applications/tools
  without even knowing where those are deployed and running. Depending
  on how computationally or data intensive the exercises are, multiple
  students may share a single software deployment instance, or each
  student can have their own. The configuration can be controlled by
  the trainer when the setup is deployed.

In both cases the deployment of applications/tools/services can happen
in the form of 'Virtual Appliances' (VAs), and block storage - the
latter basically behaving like a virtual USB drive that can be
attached/detached to VMs to provide data and storage space for
applications.

The [Artefact Registry](../compute/cloud-compute/images/) has a
list of Virtual Appliances ready to use with popular Linux
distributions, but more can be added upon demand.

[Infrastructure Manager Dashboard](../compute/orchestration/im/dashboard/)
can be used as web interface for both trainers and students to deploy
and manage Virtual Machines.

## Available resources

The available resources are an in-kind contribution from cloud providers
in the EGI Federated Cloud: [CESNET](https://www.egi.eu/partner/cesnet/),
[IISAS](https://www.egi.eu/partner/iisas/), and
[IFCA-CSIC](https://www.egi.eu/partner/csic/).

{{% alert title="Join the training infrastructure!" color="info" %}}

Do you want to join as a cloud provider? Please email at
`support <at> egi.eu`.
{{% /alert %}}

## Booking the infrastructure

The infrastructure currently includes enough capacity to scale up to
class-room size audiences, approximately up to 100 participants.

Do you want to book the infrastructure for a course? Please send a
request through [our site](https://www.egi.eu/service/training-infrastructure/).
