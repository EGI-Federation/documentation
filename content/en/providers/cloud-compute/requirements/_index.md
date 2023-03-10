---
title: "Requirements"
description: "Requirements for integration"
weight: 10
type: "docs"
---

IaaS providers are very welcome to join the EGI Federated Cloud as a Resource
Centres (RC) and joining the Federated Cloud Task Force to contribute to the
design, creation and implementation of the federation.

Resource Centres are free to use any Cloud Management Framework (OpenStack,
etc\...) as long as they are able to integrate with the EGI Federation
components as described in the
[Federated Cloud Architecture](../../../users/getting-started/architecture). At
the moment this compliance is guaranteed for OpenStack.

The general minimal requirements are:

- Hardware requirements greatly depend on your cloud infrastructure, EGI
  components in general do lightweight operations by interacting with your
  services APIs.
  - `cloudkeeper` requires enough disk space to download and convert images
    before uploading into your local catalogue. The number and size of images
    which will be downloaded depends on the communities you plan to support. For
    the piloting VO `fedcloud.egi.eu`, 100GB of disk should be enough.
- Servers need to authenticate each other in the EGI Federated Cloud context
  using X.509 certificates. So a Resource Centre should be able to obtain server
  certificates for some services.
- User and research communities are called Virtual Organisations (VO). Resource
  Centres are expected to join:
  - `ops` and `dteam` VOs, used for operational purposes as per RC OLA
  - a community-VO that supports EGI users (e.g. `vo.access.egi.eu` for
    piloting)
- EGI provides packages for the following operating systems (others may work but
  we are not providing packages):
  - CentOS 7 (and in general RHEL-compatible)
  - Ubuntu 16.04 (and in general Debian-based)
