---
title: "GOCDB Registration"
weight: 40
type: "docs"
description: >
  Registration of service endpoints in GOCDB
---

Site endpoints must be registered in
[EGI Configuration Management Database (GOCDB)](https://goc.egi.eu). If you are
creating a new site for your cloud services, check the
[PROC09 Resource Centre Registration and Certification](https://confluence.egi.eu/display/EGIPP/PROC09+Resource+Centre+Registration+and+Certification)
procedure. Services can also coexist within an existing (grid) site.

## Expected Services

These are the expected services for a working site:

- If offering native OpenStack access (nova), register: `org.openstack.nova`
  for the Nova endpoint of the site. The **endpoint URL** must contain the
  Keystone v3 URL: `https://hostname:port/url/v3`. Set the **Host DN** so the
  cloud-info-provider can be enabled in the AMS.

- If offering native OpenStack access (swift), register: `org.openstack.swift`
  for the swift endpoint of the site. The **endpoint URL** field must contain the
  Keystone v3 URL: `https://hostname:port/url/v3`.

- `eu.egi.cloud.accounting` for the host sending the records to the
  accounting repository (executing SSM send).

## Deprecated services

Deprecated services for cloud providers:

- `Site-BDII`. This service collects and publishes site\'s data for the
  Information System. Existing sites should already have this registered.

- `eu.egi.cloud.vm-metadata.vmcatcher` for the VMI replication mechanism.
  Register here the host providing the replication (i.e. the host with
  cloudkeeper installation)

- If offering OCCI interface, `eu.egi.cloud.vm-management.occi` for the OCCI
  endpoint offered by the site. The endpoint URL must follow this syntax:

  `https://hostname:port/?image=<image_name>&resource=<resource_name>`

  where `<image_name>` and `<resource_name>` cannot contain spaces. These
  attributes map to `os_tpl` and `resource_tpl` respectively and will be the
  ones used for monitoring purposes.
