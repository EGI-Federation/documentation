---
title: "Accessing"
description: "Accessing GOCDB"
weight: 20
type: "docs"
---

The GOCDB can be accessed at https://goc.egi.eu.

To access the web interface, users can:

- use an [X509 digital certificate installed in the browser](#using-an-x509-digital-certificate), delivered by
  one of the recognised EU-Grid-PMA Certification Authorities ;
- use EGI Check-in to [access the GOCDB with an institutional account](#using-institutional-account-via-egi-check-in).

Users can access the system as soon as they are authenticated however they will
only be able to update information based on their roles.
More information about roles and associated permission is available in the
[Users and
roles](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#Users_and_roles)
section.

All roles applications need to be validated by parent roles or administrators.
Once this is done, you can access/modify relevant information according to the
role you have been granted. You can learn more on roles and user accounts by
reading the #Users and roles section of this documentation.

## Using an X509 digital certificate

Please note, GOCDB does not support single or double quotes in the certificate
Distinguished Name (DN).

This DN is rejected by GOCDB because of the single quote:

```
/C=UK/O=STFC/OU=SomeOrgUnit/CN=David Mc'Donald
```

This is in accordance with [RFC1778](https://tools.ietf.org/html/rfc1778) which
also disallows single quotes in all Relative Distinguished Name (RDN)
components, and the OGF Certificate Authority Working Group (CAOPS) who
strongly discourage any type of quote in a certificate DN as specified by their
Grid Certificate Profile document.

## Using institutional account via EGI Check-in

In order to be able to access the GOCDB with their institutional account, users
need to:

1. Have their Identity Provider (IdP) federated in eduGAIN ;
1. Have created an [EGI Check-in account](https://wiki.egi.eu/wiki/AAI_usage_guide) ;
1. Have requested joining the [GOCDB user
   group](https://aai.egi.eu/registry/co_petitions/start/coef:41) ;
1. Have their access request accepted by the EGI Operations team.
