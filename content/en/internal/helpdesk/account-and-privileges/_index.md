---
title: "Account and privileges"
type: docs
weight: 40
description: >
  EGI Helpdesk
---

# GGUS account

## Managing GGUS account data

GGUS users should be able to manage their GGUS account data by themselves.

Information about registration and account management is collected on
[GGUS registration page](https://ggus.eu/?mode=register_info) and could be
reached by clicking the "Registration" link on top of
[GGUS home page](http://ggus.org/).

For managing the GGUS account data the user has to click the link “Check your
GGUS account” at the bottom of this page.

## Updating the personal certificate information

Users should update their certificate information before their old certificate
expires. They can navigate to the
[registration page](https://ggus.eu/?mode=register_info), click the link "Check
your GGUS account" and update their data. Modifying the DN field will result in
an additional DN field: the old DN will be kept and the new DN will be added.
Subsequently, the user is identified with the two DNs. If the old DN is no more
valid please just clear the DN field and save the change. Once the old
certificate has expired before updating the account data, users can request an
update via GGUS ticket against Helpdesk(GGUS) support unit.

## Linking the EGI SSO persistent ID to the GGUS account

**Pre-requisites: the email address of your EGI SSO account must be equal to the
email address registered in GGUS!**

For adding your EGI SSO persistent ID to your account data please do the
following:

- login to GGUS using your EGI SSO account
- on GGUS home click the [Registration](https://ggus.eu/?mode=register_info)
  link

![your account information](GGUS_EGI_AAI_1.png)

- click the button "Add my Shibboleth ID to my account" at the bottom of the
  yellow box.

## Getting supporter privileges

In order to process tickets assigned to the support unit you belong to, or in
general tickets submitted by other users and assigned to other support units,
you need to own supporter privileges. Therefore users need to register an
account at GGUS. Registration can be done either using an X509 personal
certificate or using the EGI AAI account.

### Registration with an x509 certificate

For registering with an X509 certificate the user should go to
[GGUS home](https://ggus.eu/index.php?mode=index) and click the
[registration link](https://ggus.eu/?mode=register_info) in the menu bar at the
left. This link opens the registration information page which gives some
additional information about registration process. Clicking on the
[registration link](https://ggus.eu/?mode=register_info) guides to the form that
the user has to fill in. After filling in the registration form, GGUS team will
check whether support privileges can be granted. The user will receive an email
from the GGUS team (usually) confirming their supporter privileges.

### Registration with the EGI AAI account

Users who do not have a valid X509 certificate can access GGUS via [EGI Check-in](../../../users/check-in).
For getting support privileges the user needs to be member of the
[ggus-supporters](https://aai.egi.eu/registry/co_petitions/start/coef:69) group
in EGI Check-in. However the user should fill in the
[registration form](https://ggus.eu/?mode=register_info) for creating an account
at GGUS. Support privileges will be granted automatically. The user will receive
an automated email from GGUS system confirming their support privileges.

![GGUS registration form](GGUS_Registration_Form.png)

Both authentication methods, X509 certificate and EGI Check-in account, will be
guaranteed in the future. Since the use of login and password will no longer be
guaranteed in the future, it is recommended to access GGUS with a valid digital
certificate or EGI Check-in.

## Troubleshooting

### I'm member of ggus-supporters.egi.eu group. Why don't I have support privileges in GGUS?

**Pre-requisites: the email address of your EGI SSO account must be equal to the
email address registered in GGUS!**

- Case 1: user isn't registered in GGUS yet.

Unregistered users have to register first. On
[registration page](https://ggus.eu/?mode=register_info) you will see this text:
“You are member of EGI AAI CheckIn ggus supporter. You will get automatically
support right for the GGUS portal once you will submit this form.“ Support
permissions will be granted automatically.

![Updating PersistentID](Account_Update_PersistentID.png)

Click on the "Add my ...." button.

- Case 2: user already registered in GGUS with an X509 DN.

You can decide to add the Shibboleth ID to the existing account and check the
updated account. In case the email addresses are different you may either
harmonize your email address in EGI SSO and GGUS account or create a new account
using EGI SSO data.

## Getting in touch wit the GGUS team?

The preferred way to get in contact with the GGUS team is by submitting a GGUS
ticket against Helpdesk (GGUS) support unit.

## Additional information

[GGUS user guide](https://wiki.egi.eu/wiki/FAQ_GGUS-User_Guide)
[GGUS short guide](https://wiki.egi.eu/wiki/FAQ_GGUS-Short-Guide)
[GGUS support staff guide](https://wiki.egi.eu/wiki/FAQ_GGUS-Support-Staff-Guide)
