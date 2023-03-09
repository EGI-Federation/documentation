---
title: "Access"
description: "Accessing the Configuration Database"
weight: 20
type: "docs"
---

To access the [web interface](https://goc.egi.eu) of the EGI Configuration
Database (GOCDB), users can either:

- [Use EGI Check-in](#using-institutional-account-via-egi-check-in) with an
  institutional account, or
- [Use an X.509 digital certificate](#using-an-x509-digital-certificate)
  installed in the internet browser, or the local machine's certificate store.

Users can access the system as soon as they are authenticated. However, they
will only be able to update information based on their roles, and only once they
will have [registered a new user account](#registering-a-new-user-account).

More information about roles and associated permission is available in the
[_Users and roles_](../users-roles) section of the documentation.

Applications requesting a specific role have to be validated by parent roles or
administrators. Once granted, users can access and/or modify relevant
information, according to the roles granted to them.

## Using institutional account via EGI Check-in

In order to be able to access the Configuration Database with their
institutional account, users need to:

1. Have their Identity Provider (IdP) federated in EGI Check-in (via
   [eduGAIN](https://edugain.org/) or directly).
1. Have created an [EGI Check-in account](../../../users/aai/check-in/signup).

{{% alert title="Important" color="warning" %}} In the case the user cannot use
an IdP compliant with [REFEDS R&S](https://refeds.org/research-and-scholarship)
and [REFEDS Sirtfi](https://refeds.org/sirtfi), the user will have to request
joining a specific group, by performing the steps below. Using a compliant IdP
is the preferable solution.

1. User should ask to join the
   [GOCDB user group](https://aai.egi.eu/registry/co_petitions/start/coef:41).
1. The access request will be managed by the EGI Operations team. {{% /alert %}}

## Using an X.509 digital certificate

To access the Configuration Database using a digital certificate, first obtain a
certificate from one of the recognised EU-Grid-PMA Certification Authorities
(CAs), then install it in your browser of choice (or import it into the
certificate store of your local machine, on Windows).

{{% alert title="Note" color="info" %}} X.509 certificates do not support single
or double quotes in the certificate's Distinguished Name (DN). The DN below is
rejected because of the single quote:

`/C=UK/O=STFC/OU=SomeOrgUnit/CN=David Mc'Donald`

This is in accordance with [RFC1778](https://tools.ietf.org/html/rfc1778), which
also disallows single quotes in all Relative Distinguished Name (RDN)
components, and the OGF Certificate Authority Working Group (CAOPS) who strongly
discourage any type of quote in a certificate DN as specified by their
[Grid Certificate Profile](https://www.ogf.org/documents/GFD.125.pdf) document.
{{% /alert %}}

## Registering a new user account

Being authenticated in one of the two ways described above is enough to have
read-only access to all the public features of the EGI Configuration Database.
If you need to edit data in and request roles, you will need to fill in the
registration form.

**To Register**:

- Go to the [EGI Configuration Database web portal](https://goc.egi.eu)
- In the left sidebar, look out for the **User status** panel
- click on the "Register" link
- fill in the form and validate

## Recovering access to an existing account

{{% alert title="Note" color="info" %}} If you were registered but are not
recognised anymore (e.g. because your certificate DN changed), do not register
again! Instead, follow the steps
[Lost access to your Configuration Database account](../users-roles/managing-accounts#lost-access-to-your-account)
section.{{% /alert %}}
