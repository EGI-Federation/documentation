---
title: HOWTO07 How to change the Site BDII
weight: 135
type: "docs"
description: "Changing the Site BDII"
---

## Changing the Site BDII

**What have I to do to move the Site BDII on another machine?**

1.  be sure the new Site BDII is working fine and publishing all the necessary
    site information
    1.  See [MAN01](../man01_how_to_publish_site_information) for general
        information about how to configure a Site BDII. In particular, remember
        that the Site BDII configuration must include the BDII node itself.
2.  put the old Site BDII in scheduled downtime in Configuration Database for a
    couple of hours
3.  register the new service in the Configuration Database by adding a new
    Service Endpoint:
    1.  select "Site BDII" in "Service Type" field
    2.  fill in at least the hostname
    3.  select "Y" for production and monitoring, "N" for beta service field
4.  properly modify the "Giis Url" field with the new _SITE-BDII ldap url_
    1.  Note that the site name in the GIIS URL is case-sensitive
5.  mark the old Site BDII as not production and turn off its monitoring
6.  Top BDIIs updates their sites list every hour so the new Site BDII should be
    published in less than an hour; instead Nagios updates the monitored hosts
    every 3 hours
7.  when the new Site BDII is appeared on Nagios and the old one is disappeared,
    turn off the old Site BDII and remove it from the Configuration Database.

**What if I have just to turn off a Site BDII co-hosted with an lcg-CE:**

1.  service bdii stop
2.  yum remove glite-BDII glite-yaim-bdii
3.  delete some info-providers and ldif file:

- `/opt/glite/etc/gip/ldif/stub-site.ldif`
- `/opt/glite/etc/gip/site-urls.conf`
- `/opt/glite/etc/gip/provider/glite-info-provider-site`
- `/opt/glite/etc/gip/provider/glite-info-provider-service-bdii-site-wrapper`
- `/opt/glite/etc/gip/ldif/glite-info-site.ldif`

4.reconfigure with yaim without specifying the BDII_site profile
