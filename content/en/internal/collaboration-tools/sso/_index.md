---
title: "EGI SSO"
type: docs
weight: 20
description: "EGI SSO usage"
---

[EGI SSO](https://sso.egi.eu) is a legacy central Identity Provider mainly
intended to access the [EGI Collaboration Tools](../../collaboration-tools).

> For most services people should look into using federated authentication via
> [EGI Check-in](../../../users/aai/check-in). Still, for some services not yet
> integrated with Check-in, an EGI SSO account should be used, in that case you
> can [create an EGI SSO account](https://sso.egi.eu/admin/email).

## Features

- Central Identity Provider allowing to access EGI Collaboration Tools
- Group management
- Synchronisation of groups with other EGI Collaboration Tools
- Linking of X.509 certificate Distinguished Name (DN) to authenticate using a
  client certificate

## Linking an X.509 certificate to an EGI SSO account

1. Open [the EGI SSO user management page](https://sso.egi.eu/admin/user)
1. Select your new certificate to authenticate with it
1. Complete the login process using your username and password
1. Once logged, your new DN will be linked to your user account

## Updating the DN of a certificate linked to a given EGI SSO account

> On purpose a user cannot manually edit a certificate DN

You usually just need to link your new DN to your EGI SSO account, as documented
[above](#linking-an-x509-certificate-to-an-egi-sso-account).

You may have to do this by in a private browser session to ensure that your
previous certificate is used.

Once you have done this, you can request us to remove the former DN by opening
an [Helpdesk](../../helpdesk) ticket to the **Collaboration Tools** Support
Unit.

> Legacy DNs shouldn't prevent you accessing any service with a newer
> certificate, as long as its DN is linked to your account.
