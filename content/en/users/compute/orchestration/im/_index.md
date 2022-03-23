---
title: Infrastructure Manager
type: docs
weight: 10
aliases:
  - /users/cloud-compute/im
description: >
  Automating deployment of virtual infrastructures on EGI Cloud
---

## What is it?

[Infrastructure Manager](https://www.grycap.upv.es/im) (IM) is a tool that
**orchestrates the deployment of custom virtual infrastructures on multiple
backends**. It streamlines the access and usability of Infrastructure-as-a-Service
(IaaS) clouds by automating the configuration, deployment, software installation
and update, and monitoring of virtual infrastructures.

IM is integrated with the [EGI Check-in Service](../../../aai/check-in) and supports
a wide variety of backends, either federated (such as
[EGI Cloud Compute](../../cloud-compute)), public (such as
[Amazon Web Services](https://aws.amazon.com/),
[Google Cloud](http://cloud.google.com/) or
[Microsoft Azure](http://azure.microsoft.com/)) or on-premises (such as
[OpenStack](../../../getting-started/openstack)),
thus making user applications cloud agnostic.
IM features a [web-based GUI](https://appsgrycap.i3m.upv.es:31443/im-dashboard/),
an XML-RPC API, a REST API and a [command-line interface](cli) (CLI).
It supports
[OASIS TOSCA Simple Profile in YAML](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0/csprd01/TOSCA-Simple-Profile-YAML-v1.0-csprd01.html).

{{% alert title="Tip" color="info" %}} An easy way to deploy your first VM
in the EGI Federation is from the
[Infrastructure Manager dashboard](https://appsgrycap.i3m.upv.es:31443/im-dashboard/).
A [tutorial](https://imdocs.readthedocs.io/en/latest/dashboard.html#usage) and
[demo videos](https://youtube.com/playlist?list=PLgPH186Qwh_37AMhEruhVKZSfoYpHkrUp) are also available.
{{% /alert %}}

{{% alert title="Note" color="info" %}} For detailed information about
Infrastructure Manager please see its [documentation](https://imdocs.readthedocs.io).
It was also presented in one of the
[EGI Webinars](https://www.egi.eu/webinars/), more details are available on the
[indico page](https://indico.egi.eu/event/5495/) and the video recording is available on
[YouTube](https://youtu.be/Q9VsYjI1mD4).
{{% /alert %}}

The following sections document how to use IM from its GUI or CLI.
