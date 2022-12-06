---
title: "Understanding and manipulating user accounts"
weight: 30
type: "docs"
description: "Understanding and manipulating user accounts"
---

## Authentication

The EGI Configuration Database UI attempts to authenticate you in one of two
ways (the REST style API applies X.509 only):

- First, by requesting an IGTF accredited user certificate from your browser. If
  a suitable certificate is detected, you will be asked to confirm selection of
  your certificate in your browser. **Note**: if a client certificate has been
  provided, it will take precedence over any IdP based authentication.
- Second, if you do not have a user certificate or you hide your certificate
  from (e.g. by starting a new/anonymous private browser session or pressing
  'Cancel' when prompted for a certificate), you will be redirected to the
  landing page where you can authenticate with the EGI Identity Provider Service
  (IdP) and your chosen institution (if available). If authentication is
  successful, you will be redirected back to the Configuration Database. Please
  note, not all logins available in the EGI IdP provide a sufficient level of
  assurance (LoA) to login (the LoA must be 'Substantial').

## Editing your user account

The editing process is the same as the registration process. To edit your user
account, simply follow these steps:

- click on the "view details" link in the "User Status" panel on the sidebar.
  You should get a page showing your user account information.
- Click on the "edit" link on top of it.

## Viewing users

Each user account has its own user details page which is accessible to anyone
with a valid certificate.

There is currently no facility for listing all users in the database. List of
users that have a role on a given site appears on site details pages (see
section about sites). It is also possible to search for a user's account using
the **search** feature on the sidebar.

## Deleting your user account

If you wish to unregister from the Configuration Database, follow these steps:

- click on the **view details** link in the "User Status" panel on the sidebar.
  You should get a page showing your user account information.
- Click on the "delete" link on top of it.
- Confirm your choice.

Your account will then be deleted along with any roles the account has.

## Lost access to your account

Under the following circumstances it is possible to lose access to an account:

- You use your IGTF X.509 certificate to access and renew or change certificate,
  it is possible that the certificate's distinguished name (DN) has also
  changed. This is what the Configuration Database uses to identify your
  account.
- You have authenticated with EGI Check-in, but via a different underlying IdP
  (i.e. You usually log in with your institutional credentials, but today you
  logged in with EGI SSO).
- You have changed the way you log in (i.e. X.509 to EGI Check-in)

In these situations, it is usually possible to regain access using to your
certificate based account by following one of the following procedures:

If for any reason you were unable to complete the relevant procedure (e.g. mail
confirmations problems) please open an [EGI Helpdesk](../../../helpdesk) ticket
addressed to the "Configuration and Topology Database (GOCDB)" support unit.

### You have a new certificate and have lost access to your account

- Install your new certificate in your browser.
- Go to [EGI Configuration Database](https://goc.egi.eu). If you are already
  logged in, then clear your caches and restart your browser or start a new
  private browser session.
- When prompted, select your new certificate.
- You should be able to access, but since you are authenticated with your new
  certificate, it is as if you had no user account.
- In the **User Status** panel in the sidebar, click on the
  **[Link Identity/Recover Account](https://goc.egi.eu/portal/index.php?Page_Type=Link_Identity)**
  link.
- Specify in the form:
  - Authentication type: X.509
  - The DN of your old certificate previously used to authenticate to your X.509
    based account.
  - The email address associated to your account.
- **Submit** and, upon validation, an email will be sent to the specified
  address, which has to match the one registered with your account. This is to
  avoid identity theft. The email contains a validation link.
- Click on the validation link or copy/paste in your browser. Once validated,
  changes are immediate.

> You can only associate one X.509 DN with your account at any given time.

### You have authenticated with EGI Check-in, but via a different Identity Provider

It's possible to link this identity with your "other"
[EGI Check-in](../../../../users/aai/check-in) identity at the level of the EGI
Check-in, see
[account linking documentation](../../../../users/aai/check-in/linking).

Once your identity is linked at the EGI Check-in level, if you are still having
problems accessing, please reassign the ticket to "Configuration and Topology
Database (GOCDB)"

### You have changed the way you log in (i.e. X.509 to EGI Check-in)

You can link these identities at the EGI Configuration Database level by
following these steps. The steps assume an existing X.509 based account and that
you are currently authenticated via EGI Check-in, though the steps should hold
for any pair of supported authentication methods.

- In the **User Status** panel in the sidebar, click on the **Link
  Identity/Recover Account** link.
- Specify in the form:
  - Authentication type: X.509
  - The DN of your certificate used to authenticate to your X.509 based account
  - The email address associated to your X.509 based account.
- **Submit** and, upon validation, an email will be sent to the specified
  address, which has to match the one registered with your X.509 based account.
  This is to avoid identity theft. The email contains a validation link.
- Click on the validation link or copy/paste in your browser. Authenticate with
  your EGI Check-in identity. Once authenticated/validated, changes are
  immediate and you will be able to access your account with both your X.509 and
  EGI Check-in identities.
