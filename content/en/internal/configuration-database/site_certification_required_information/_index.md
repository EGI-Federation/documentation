---
title: Site registration requirements
weight: 100
type: "docs"
description:
  "Information required for registering a site into the Configuration Database"
---

With the help of its NGI Operation Centre, the site has to register their
resources in a central database named the
[Configuration Database](../../../internal/configuration-database). The
following is an example of how to fill in the database and should be to sent (by
email) to the NGI manager(s).

## Required information

The following fields are mandatory and must be sent with the application.

- **ROC**: the ROC/NGI (e.g. `NGI_France` or `ROC_LA`)
- **Country**: the country (e.g. `Italy`)
- **Domain**: DNS domain used by the machines at this site (eg: `cnaf.infn.it`)
- **Short Name**: Generic name for the site (Alphanumeric, dot dash and
  underscore, eg: `INFN-CNAF`)
- **Official Name**: Official name (Alphanumeric and basic punctuation), e.g.
  `Mysite, University of Mytown, Mycountry`
- **E-Mail**: Generic contact used for broadcasts, notifications and general
  purpose contact. The mailing list must include all the site managers
  responsible for that site. A suggested e-mail alias would take the form of
  `grid-prod@site-domain.tld`
- **Contact Telephone Number**: Generic phone contact (numbers, optional +, dots
  spaces or dashes)
- **Security Contact E-mail**: A mailing list for security information
  communication. The mailing list must be closed and its archives not published.
  A suggested e-mail alias would take the form of `grid-sec@site-domain.tld`
- **Security Contact Telephone Number**: Site's Computer Security Incident
  Response Team (CSIRT) telephone number (numbers, optional +, dots spaces or
  dashes)

## Additional information

This information should be filled in at a later time. Although it is not
required, it is recommended to complete this as much as possible.

- **Timezone**: e.g. Europe/Amsterdam
- **Home URL**: Site web homepage if any (eg: `http://www.cnaf.infn.it`)
- **GIIS URL**: SITE-BDII ldap url, e.g.
  `ldap://sibilla.cnaf.infn.it:2170/mds-vo-name=infn-cnaf,o=grid`
- **IP Range**: (a.b.c.d/e.f.g.h) for the case of no firewall:
  `0.0.0.0/255.255.255.255`
- **Location**: An increasing resolution ending with Country (Town, City,
  Country), e.g. `Soho, London, United Kingdom` (Alphanumeric and basic
  punctuation)
- **Latitude**: Latitude of the site e.g. `52.370216` (+/-a.b)
- **Longitude**: Longitude of the site e.g. `4.895168` (+/-a.b)
- **Description**: (Alphanumeric and basic punctuation)
- **Emergency Telephone Number**: phone contact for emergency procedure
  (numbers, optional +, dots spaces or dashes)
- **Alarm E-Mail**: (for LCG Tier 1 sites) (valid email format)
- **Helpdesk E-Mail**: endpoint to the local helpdesk for direct ticketing from
  GGUS. If not set, the ROC/NGI helpdesk contact will be used instead (valid
  email format)

See to Resource Centre registration and certification procedure
[PROC09](https://confluence.egi.eu/display/EGIPP/PROC09+Resource+Centre+Registration+and+Certification).
