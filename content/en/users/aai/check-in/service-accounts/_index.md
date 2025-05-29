---
title: Service Accounts
linkTitle: Service Accounts
type: docs
weight: 50
description: >
  Create a Service Account using EGI Check-in
---

A Service Account is a special kind of account typically used by
an application or compute workload rather than a person. Service Accounts
are meant to represent the identity and authorization of an application
or service. They serve as a means for applications to authenticate and
interact with other systems, databases, or resources.

Service Accounts are particularly beneficial in scenarios where continuous
and automated operations are required, such as batch processing,
background tasks, or integration with cloud services. By using Service Accounts,
organizations can enhance security, improve efficiency, and ensure the smooth
functioning of their IT systems.

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
