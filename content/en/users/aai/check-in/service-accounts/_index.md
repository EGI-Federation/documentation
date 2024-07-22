---
title: Service Accounts
linkTitle: Service Accounts
type: docs
weight: 50
description: >
  Create a Service Account using EGI Check-in
---

A Service Account can be created by registering an OIDC service with
the Client Credentials grant through the
[Federation Registry](https://aai.egi.eu/federation).

The required policy documents should be specified as follows:

* Privacy Policy: [https://aai.egi.eu/privacy/en](https://aai.egi.eu/privacy/en)
* Acceptable Use policy: [https://aai.egi.eu/ToU.html](https://aai.egi.eu/ToU.html)

The entitlements that need to be associated with the Service Account
can be requested by opening a GGUS ticket (see the
[Getting help section](../faq/) in the FAQ) with the
following information:

{{% alert title="Service Account request" color="info" %}} 
Subject: **Add VO entitlement to service account**

I'd like to request the following entitlement values for the service account
with Client ID `<CLIENT_ID>` in the `<Production/Demo/Development>` environment
of EGI Check-in:
1. `<ENTITLEMENT1>`
2. `<ENTITLEMENT2>`
3. `...`
{{% /alert %}}
