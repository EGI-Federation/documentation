---
title: Changing the Site BDII
weight: 10
type: "docs"
description: "Changing the Site BDII"
aliases:
  - /providers/high-throughput-compute/changing_site_bdii
---

## Moving the Site BDII to another machine

1. Ensure the new Site BDII is working fine and publishing all the necessary
   site information

   - See [MAN01](../../operations-manuals/man01_how_to_publish_site_information)
     for general information about how to configure a Site BDII. In particular,
     remember that the Site BDII configuration must include the BDII node
     itself.

1. Put the old Site BDII in scheduled downtime in the
   [Configuration Database](../../../internal/configuration-database) for a
   couple of hours
1. Register the new service in the Configuration Database by adding a new
   Service Endpoint:

   - select `Site BDII` in `Service Type` field
   - fill in at least the hostname
   - select `Y` for production and monitoring, `N` for beta service field

1. Properly modify the `GIIS URL` field with the new `SITE-BDII ldap URL`

   - Note that the site name in the GIIS URL is case-sensitive

1. Mark the old Site BDII as not production and turn off its monitoring
1. Top BDIIs updates their sites list every hour so the new Site BDII should be
   published in less than an hour; instead Nagios updates the monitored hosts
   every 3 hours
1. When the new Site BDII is appeared on Nagios and the old one is disappeared,
   turn off the old Site BDII and remove it from the Configuration Database

## Turning off a Site BDII co-hosted with other services

1. Stop and remove the service

   ```shell
   service bdii stop
   yum remove glite-BDII glite-yaim-bdii
   ```

1. Delete some info-providers and ldif file (
   `/opt/glite/etc/gip/ldif/stub-site.ldif`,
   `/opt/glite/etc/gip/site-urls.conf`,
   `/opt/glite/etc/gip/provider/glite-info-provider-site`,
   `/opt/glite/etc/gip/provider/glite-info-provider-service-bdii-site-wrapper`,
   `/opt/glite/etc/gip/ldif/glite-info-site.ldif`)

1. Reconfigure with yaim without specifying the BDII_site profile
