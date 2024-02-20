---
title: "Requirements"
description: "Requirements for integration"
weight: 10
type: "docs"
---

Resource Centres are free to use any Cloud Management Platform as long as they
are able to integrate with the EGI Federation components. At the moment this
compliance is supported for OpenStack open-source cloud platform.

The general minimum requirements are described below.

- Relevant parts of
  [PROC09 Resource Centre Registration and Certification](https://confluence.egi.eu/display/EGIPP/PROC09+Resource+Centre+Registration+and+Certification)
  have been successfully completed

- Hardware requirements greatly depend on your cloud infrastructure, EGI
  components in general do lightweight operations by interacting with your
  services APIs.

  - Image sync requires enough space to store the community images into your
    local catalogue. The number and size of images which will be downloaded
    depends on the communities you plan to support. For the operations VO `ops`,
    a < 4GB image is used.

- Servers need X.509 host certificates in order to authenticate to each other or
  to act as public endpoints in the EGI Federated Cloud context. For accounting
  purposes one IGTF-accredited X.509 certificate is needed per site, but the
  other public endpoints can use ordinary certificates (issued by Let’s Encrypt
  for example).

  - For the IGTF-accredited certificates, a list of national / regional
    Certificate Authorities is available at
    [EUGridPMA Membership](https://www.eugridpma.org/members/membership); it is
    expected that the Resource Centre will obtain the IGTF certificate from a
    close Certificate Authority

- For operational purposes, the `ops` VO needs to be supported by the Resource
  Centre as per Resource Centre OLA. Also at least one community VO that
  supports EGI users is expected to be supported by the Resource Centre (i.e.
  `vo.access.egi.eu` for piloting and prototyping FedCloud usage).

- The public endpoints need to have proper firewall configuration (to allow
  inbound external access)

- A flavor (a preset configuration that defines the compute, memory, and storage
  capacity - min 8 GB - of an instance) needs to be made available by the site
  for monitoring purposes.
