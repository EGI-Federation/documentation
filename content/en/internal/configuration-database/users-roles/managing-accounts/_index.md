---
title: "Understanding and manipulating user accounts"
weight: 30
description: >-
     Understanding and manipulating user accounts.
---

## Authentication

The GOCDB UI attempts to authenticate you in one of two ways (the REST style API
applies x509 only):

- First, by requesting an IGTF accredited user certificate from your browser. If
a suitable certificate is detected, you will be asked to confirm selection of your
certificate in your browser. **Note**: if a client certificate has been provided to GOCDB, it will take precedence over any IdP based authentication. 
- Second, if you do not have a user certificate or you hide your certificate from
GOCDB (e.g. by starting a new/anonymous private browser session or pressing
'Cancel' when prompted for a certificate), you will be redirected to the EGI
Identity Provider Service (IdP) where you can authenticate with your chosen
institution (if available). If authentication is successful, you will be
re-directed back to GOCDB. Please note, not all logins available in the EGI IdP
provide a sufficient level of assurance (LoA) to login to GOCDB (the LoA must be
'Substantial').

Each GOCDB user account is linked to a single account by an ID string - this ID
from comes **either** your Certificate DN or from the EGI IdP service. It is
important to note that GOCDB does not perform account-linking - **each ID string
maps to a separate GOCDB account**. Existing users who have already registered
an account will be logged into their account, while new users may choose to
register a new account.

## Registering a new user account

Being authenticated in one of the two ways described above is enough to have
read-only access to all the public features of GOCDB. If you need to edit data
in GOCDB and request roles, **you will need to fill in the registration form**.

**To Register**:

- Go to the GOCDB web portal
- In the left sidebar, look out for the **User status** panel
- click on the "Register" link
- fill in the form and validate

**Note**: If you were registered in GOCDB but are not recognised anymore (e.g.
because your certificate DN changed), do not register again! Instead, follow the
steps described in the (put link)Changing_your_accountID section

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

If you wish to unregister from GOCDB, follow these steps:

- click on the "view details" link in the "User Status" panel on the sidebar.
You should get a page showing your user account information.
- Click on the "delete" link on top of it.
- Confirm your choice.

Your account will then be deleted along with any roles the account has.

## Changing your accountID

Under the following circumstances it is possible to lose access to a GOCDB account
that was originally created using a client certificate:

- If you change your certificate, it is possible that the certificate's
distinguished name (DN) has also changed. This is what GOCDB uses to identify your
account.
- If you choose to stop using your client certificate to log into GOCDB and istead
access GOCDB via the EGI IdP.
- If you have an account linked to your certificate but later login via the
EGI-IdP route and mistakenly change your accountID from your certDN to the newly
assigned ID issued by the EGI IdP.

In these situations, it is usually possible to regain access using to your
certificate based account by following one of the following procedures:

### If you have a new certificate and have lost access to your account

First install your new certificate in your browser.

- Go to GOCDB. If you are already logged in, then clear your caches and restart
your browser or start a new private browser session.
- When prompted, select your new certificate but **DON'T Register** a new account.
- You should be able to access GOCDB, but since you are authenticated with your
new certificate, it is as if you had no user account (you have not registered your
new certificate with GOCDB yet).
- In the "user status" panel in the sidebar, click on the **retrieve an old
account** link.
- Specify in the form the DN of your old certificate, and the email address
associated to your account.
- Upon validation, an email will be sent to the specified address, which has to
match the one registered with your account. This is to avoid identity theft. The
email contains a validation link.
- Click on the validation link or copy/paste in your browser. Once validated,
changes are immediate.

### If you choose to stop using a client certificate in favour of the EGI IdP

**NOTE**: Following this process will mean you can *only* login to your GOCDB
account via EGI Check-In going forward

- Access GOCDB via the EGI IdP.
- In the "user status" panel in the sidebar, click on the retrieve an old account
link.
- Specify in the form: the DN of your old certificate; and the email address
associated to your account.
- Upon validation, an email will be sent to the specified address, which has to
match the one registered with your account.
- Click on the validation link or copy/paste in your browser. Once validated,
changes are immediate.

<!-- markdownlint-disable no-inline-html -->
## If you mistakenly changed your accountID from your certDN to the ID issued from the EGI IdP and have lost access using your certificate
<!-- markdownlint-enable no-inline-html -->

- Go to GOCDB. If you are already logged in, then clear your caches and restart
your browser or start a new private browser session.
- When prompted, select your certificate you want to reinstate/re-associate with
your account - **DON'T Register a new account**.
- You should be able to access GOCDB but since you are authenticated with the
certificate that is no longer linked to your account, it is as if you had no user
account.
- In the "user status" panel in the sidebar, click on the **retrieve an old account**
link.
- In the form, specify the DN of your certificate that you want to reinstate, and the
email address associated to your account.
- Upon validation, an email will be sent to the specified address, which has to
match the one registered with your account. This is to avoid identity theft.
The email contains a validation link.
- Click on the validation link or copy/paste in your browser. Once validated, changes
are immediate.

If for any reason you were unable to complete these steps (e.g. mail confirmations
problems) please do not register a new user account, but contact the GOCDB support
helpdesk instead.
