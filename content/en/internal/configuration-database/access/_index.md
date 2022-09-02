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
will have [registering a new user account](#registering-a-new-user-account).

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

To Register:

- Go to the [EGI Configuration Database web portal](https://goc.egi.eu)
- In the left sidebar, look out for the User status panel
- click on the "Register" link
- fill in the form and validate

> If you were registered but are not recognised anymore (e.g. because your
> certificate DN changed), do not register again! Instead, follow the steps
> described in the [Changing your account ID](#changing-your-account-id)
> section.

## Changing your account ID

Under the following circumstances it is possible to lose access to your account
that was originally created using a client certificate:

- If you change your certificate, it is possible that the certificate's
  distinguished name (DN) has also changed. This is what the EGI Configuration
  Database uses to identify your account.
- If you choose to stop using your client certificate to log in and instead
  access via EGI Check-in.
- If you have an account linked to your certificate but later login via the EGI
  Check-in route and mistakenly change your account ID from your certificate DN
  to the newly assigned ID issued by EGI Check-in.

In these situations, it is usually possible to regain access using to your
certificate based account by following one of the following procedures:

### If you have a new certificate and have lost access to your account

- First install your new certificate in your browser.
- Go to [EGI Configuration Database web portal](https://goc.egi.eu). If you are
  already logged in, then clear your caches and restart your browser or start a
  new private browser session.
- When prompted, select your new certificate but **DON'T** register a new
  account.
- You should be able to access, but since you are authenticated with your new
  certificate, it is as if you had no user account (you have not registered your
  new certificate yet).
- In the "user status" panel in the sidebar, click on the retrieve an old
  account link.
- Specify in the form the DN of your old certificate, and the e-mail address
  associated to your account.
- Upon validation, an e-mail will be sent to the specified address, which has to
  match the one registered with your account. This is to avoid identity theft.
  The e-mail contains a validation link.
- Click on the validation link or copy/paste in your browser. Once validated,
  changes are immediate.

### If you choose to stop using a client certificate in favour of EGI Check-in

> Following this process will mean you can _only_ login via EGI Check--n going
> forward

- Access [EGI Configuration Database web portal](https://goc.egi.eu) via EGI
  Check-in
- In the "user status" panel in the sidebar, click on the retrieve an old
  account link.
- Specify in the form: the DN of your old certificate; and the e-mail address
  associated to your account.
- Upon validation, an e-mail will be sent to the specified address, which has to
  match the one registered with your account.
- Click on the validation link or copy/paste in your browser. Once validated,
  changes are immediate.

### If you mistakenly changed your account ID from your certificate DN to the ID issued from EGI Check-in and have lost access using your certificate

- Go to [EGI Configuration Database web portal](https://goc.egi.eu). If you are
  already logged in, then clear your caches and restart your browser or start a
  new private browser session.
- When prompted, select your certificate you want to reinstate/re-associate with
  your account - DON'T Register a new account.
- You should be able to access but since you are authenticated with the
  certificate that is no longer linked to your account, it is as if you had no
  user account.
- In the "user status" panel in the sidebar, click on the retrieve an old
  account link.
- In the form, specify the DN of your certificate that you want to reinstate,
  and the e-mail address associated to your account.
- Upon validation, an e-mail will be sent to the specified address, which has to
  match the one registered with your account. This is to avoid identity theft.
  The e-mail contains a validation link.
- Click on the validation link or copy/paste in your browser. Once validated,
  changes are immediate.

If for any reason you were unable to complete these steps (e.g. mail
confirmations problems) please do not register a new user account, but contact
the Configuration Database support unit in the [helpdesk](../../helpdesk)
instead.
