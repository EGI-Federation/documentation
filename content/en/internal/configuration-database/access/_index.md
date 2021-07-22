---
title: "Access"
description: "Accessing the GOCDB"
weight: 20
type: "docs"
---

To access [web interface](https://goc.egi.eu) of the EGI configuration database
(GOCDB), users can either:

- [Use EGI Check-in](#using-institutional-account-via-egi-check-in) to access
  the GOCDB with an institutional account, or
- [Use an X.509 digital certificate](#using-an-x509-digital-certificate)
  installed in their browser.

Users can access the system as soon as they are authenticated. However,
they will only be able to update information based on their roles.
More information about roles and associated permission is available in the
[_Users and roles_](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#Users_and_roles)
section of the GOCDB documentation.

Applications requesting a specific role have to be validated by parent roles
or administrators. Once granted, users can access and/or modify relevant
information, according to the roles granted to the user.

## Using institutional account via EGI Check-in

In order to be able to access the GOCDB with their institutional account, users
need to:

1. Have their Identity Provider (IdP) federated in EGI Check-in (via
   [eduGAIN](https://edugain.org/) or directly)
2. Have created an [EGI Check-in
   account](https://wiki.egi.eu/wiki/AAI_usage_guide)

{{% alert title="Important" color="warning" %}}
In the case the user cannot use an IdP compliant with [REFEDS
R&S](https://refeds.org/research-and-scholarship) and [REFEDS
Sirtfi](https://refeds.org/sirtfi), the user will have to request joining a
specific group (also perform the steps below). Using a compliant IdP is the
preferable solution.
{{% /alert %}}

3. User should ask to join the [GOCDB user
   group](https://aai.egi.eu/registry/co_petitions/start/coef:41)
4. The access request will be managed by the EGI Operations team.

## Using an X.509 digital certificate

To access the configuration database using a digital certificate, first obtain
a certificate from one of the recognised EU-Grid-PMA Certification Authorities
(CAs), and install it on your local machine.

{{% alert title="Note" color="info" %}} GOCDB does not support single
or double quotes in the certificate's Distinguished Name (DN). The DN
below is rejected by GOCDB because of the single quote:

`/C=UK/O=STFC/OU=SomeOrgUnit/CN=David Mc'Donald`

This is in accordance with [RFC1778](https://tools.ietf.org/html/rfc1778),
which also disallows single quotes in all Relative Distinguished Name (RDN)
components, and the OGF Certificate Authority Working Group (CAOPS) who
strongly discourage any type of quote in a certificate DN as specified by their
[Grid Certificate Profile](https://www.ogf.org/documents/GFD.125.pdf) document.
{{% /alert %}}
