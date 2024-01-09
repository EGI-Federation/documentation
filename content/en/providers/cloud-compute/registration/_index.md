---
title: "GOCDB Registration"
weight: 40
type: "docs"
description: >
  Registration of service endpoints in GOCDB
---

Site endpoints must be registered in
[EGI Configuration Management Database (GOCDB)](https://goc.egi.eu). Cloud
services can coexist within an existing (Grid) site, but we are recommending to
register a new site for the cloud services (as per
[PROC09 Resource Centre Registration and Certification](https://confluence.egi.eu/display/EGIPP/PROC09+Resource+Centre+Registration+and+Certification)
procedure - see
[Joining as a provider](../../joining/federated-resource-centre/) section)

## Expected Services

These are the expected services for a working site:

- `org.openstack.nova` for the Nova endpoint of the site. The **endpoint URL**
  must contain the Keystone v3 URL: `https://hostname:port/url/v3`. Set the
  **Host DN** so the cloud-info-provider can be enabled.

- `eu.egi.cloud.accounting` for the host sending the records to the accounting
  repository (executing SSM send). This host needs a valid IGTF-accredited X.509
  certificate. Set the **Host DN** so the SSM can be enabled.

- `org.openstack.horizon` for the dashboard endpoint of the site (optional). The
  endpoint URL field must contain the horizon URL: `https://hostname:port/url/`.

- (Optional, if offering object storage) `org.openstack.swift` for the swift
  endpoint of the site. The **endpoint URL** field must contain the Keystone v3
  URL: `https://hostname:port/url/v3`.

## Deprecated services

Deprecated services for cloud providers:

- `Site-BDII`. This service collects and publishes site\'s data for the
  Information System. There is no need to run a BDII for cloud providers.
  `eu.egi.cloud.information.bdii` is also deprecated and no longer in use.

- `eu.egi.cloud.vm-metadata.vmcatcher` for the VMI replication mechanism.

- `eu.egi.cloud.vm-management.occi` for the OCCI endpoint offered by the site.
  OCCI is no longer in use in FedCloud.
