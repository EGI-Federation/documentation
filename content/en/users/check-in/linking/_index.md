---
title: "Linking identities"
type: docs
weight: 20
description: >
  Linking additional organisational/social identities to your EGI Account
---

## Linking New Identities to your EGI Account

Identity linking allows you to access EGI resources with your existing personal
EGI ID, using any of the login credentials you have linked to your account. You
can use any of your organisational or social login credentials for this purpose.
To link a new organisational or social identity to your EGI account:

1. Enter the following URL in a browser: <https://aai.egi.eu/registry>

1. Click **Login** and authenticate using any of the login credentials _already_
   linked to your EGI account

1. Navigate to **My EGI User Community Account** page in one of the following
   ways:

   - hover over your display name next to the gear icon on the top right corner
     of the page; _or, alternatively,_
   - select **EGI User Community** from the list of available Collaborations and
     then click **My EGI User Community Account** from the **People** menu

   ![Check-in my account](./check-in-my-account.png)

1. Under the **Organisational Identities** section of your profile page,
   expand **Actions** menu and click **Link New Identity**.

   ![Link new identity](./check-in-link-new.png)

1. On the introductory page for Identity Linking, click **Begin**

   ![Link new identity intro](./check-in-link-intro.png)

1. You will need to sign in using the login credentials from the
   institutional/social identity provider you want to link to your account.

   {{% alert title="Warning" color="warning" %}} It is very important to escape
   the identity provider selection, cached in the discovery page, before picking
   the new one. {{% /alert %}}

1. After successful authentication, the new Identity Provider will be available
   under the Organizational Identities tab and you'll be able to access EGI
   resources with your existing personal EGI ID using the login credentials of
   the identity provider you selected in **Step 6**.

   ![Link new identity end](./check-in-link-end.png)

## Linking your certificate to your EGI Account

Certificate linking allows you to add the subject DN of your certificate to your
existing personal EGI ID. For this you need to import your certificate to your
browser.

To link a subject DN to your EGI account:

1. Enter the following URL in a browser: <https://aai.egi.eu/registry>

1. Click **Login** and authenticate using any of the login credentials _already_
   linked to your EGI account

1. Navigate to **My EGI User Community Account** page in one of the following
   ways:

   - hover over your display name next to the gear icon on the top right corner
     of the page; _or, alternatively,_
   - select **EGI User Community** from the list of available Collaborations and
     then click **My EGI User Community Account** from the **People** menu

   ![Check-in my account](./check-in-my-account.png)

1. Under the **Organisational Identities** section of your profile page,
   expand **Actions** menu and click **Link New Identity**.

   ![Link new identity](./check-in-link-new.png)

1. On the introductory page for Identity Linking, click **Begin**

   ![Link new identity intro](./check-in-link-intro.png)

1. Continuously, you will need to sign in using the IGTF Certificate Proxy.

   {{% alert title="Warning" color="warning" %}} It is very important to escape
   the identity provider selection, cached in the discovery page, before picking
   the new one. {{% /alert %}}

   ![Check-in IdP discovery IGTF](./check-in-discovery-igft.png)

1. Then select the certificate you want to link to your account from the popup
   window.

   ![Select certificate](./check-in-select-certificate.png)

1. After successful authentication you will be redirected back to your EGI
   Account. Also, you'll be able to access EGI resources with your existing
   personal EGI ID using **IGTF Certificate Proxy** and your certificate.

1. To verify that the subject DN is added to your EGI account scroll down to
   **Organisational Identities** and click on **view** button in the row where
   the source is
   `https://edugain-proxy.igtf.net/simplesaml/saml2/idp/metadata.php`.

   ![List organisational identities](./check-in-list-organisational-ids.png)

1. Then scroll down to _Certificates_ and you should see the subject DN of your
   certificate.

   ![Certificates preview](./check-in-certificates-preview.png)
