---
title: oidc-agent
linkTitle: oidc-agent
type: docs
weight: 40
aliases:
  - /users/aai/check-in/obtaining-tokens/oidc-agent
description: >
  Usage guide of oidc-agent
---

The oidc-agent is a command-line tool for managing OpenID Connect tokens
developed by Karlsruhe Institute of Technology (KIT).

## Obtain a Token

If you haven't installed oidc-agent in your system, please read the
[installation guide](https://indigo-dc.gitbook.io/oidc-agent/installation).

Make sure that the `oidc-agent-service` is started by executing the command:

```shell
eval `oidc-agent-service start`
```

To obtain a Token you need to execute the following command:

{{< tabpanex >}}

{{< tabx header="Production" >}}

```shell
oidc-gen --pub --issuer https://aai.egi.eu/auth/realms/egi
```

{{< /tabx >}}

{{< tabx header="Demo" >}}

```shell
oidc-gen --pub --issuer https://aai-demo.egi.eu/auth/realms/egi
```

{{< /tabx >}}

{{< tabx header="Development" >}}

```shell
oidc-gen --pub --issuer https://aai-dev.egi.eu/auth/realms/egi
```

{{< /tabx >}}

{{< /tabpanex >}}

Then enter a short name for the account to configure and the scopes that the
Access Token should contain.

{{% alert title="Note" color="info" %}} To get a **Refresh Token** you need to
specify the `offline_access` scope in the requested scopes {{% /alert %}}

After that, you need to log in either by visiting the provided URL or by
scanning the displayed QR code and then provide the **user code** displayed in
the oidc-agent.

Last but not least, you will need to provide an encryption password to protect
the obtained Access/Refresh Token.

For more information, please read the
[oidc-agent documentation](https://indigo-dc.gitbook.io/oidc-agent/).
