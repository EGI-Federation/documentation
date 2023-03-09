---
title: "Access MinIO with EGI Check-in Virtual Organisations"
linkTitle: "MinIO and Check-in"
type: docs
weight: 170
description: >
  Configure access to MinIO console with EGI Check-in Virtual Organisations.
---

## Overview

This tutorial describes how to configure access to
[MinIO console](https://min.io/docs/minio/linux/operations/external-iam.html)
using [EGI Check-in](../../aai/check-in) as external OpenID Connect Identity
Provider.

## Prerequisites

Be familiar with the steps to configure an OpenID Connect Service Provider with
[EGI Check-in](../../../providers/check-in/sp/#openid-connect-service-provider).

This tutorial assumes that:

- You have a valid EGI ID (account), you can
  [sign up here](../../aai/check-in/signup).
- You are a member of a
  [Virtual Organisation](../../aai/check-in/joining-virtual-organisation).
- You have deployed MinIO and have access to the console as `admin`.

## Step 1: Get the OIDC entitlement for the Virtual Organisation

See the
[page about getting tokens from Check-in](../../aai/check-in/obtaining-tokens/token-portal/).
You will get a `curl` command to get your OIDC entitlements.

Select the entitlement for the Virtual Organisation that you want to
enable access to. For example, here is the entitlement for the
`vo.access.egi.eu` Virtual Organisation:

```shell
urn:mace:egi.eu:group:vo.access.egi.eu:role=member#aai.egi.eu
```

## Step 2: Configure a new policy in MinIO console

Go to `https://<minio-console-endpoint>/identity/policies` and create a
new policy, where:

- The name of the policy is the OIDC entitlement obtained in Step 1.
- The policy is configured with the value below:

```yaml
{
    "Version": "2023-02-20",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${jwt:preferred_username}-*"
            ]
        }
    ]
}
```

{{% alert title="Note" color="info" %}}
Pay attention to the use of:

`${jwt:preferred_username}*`

in the *Amazon Resource Name* string:

`arn:aws:s3:::${jwt:preferred_username}*`

This will allow every user full control of their own buckets under
`s3://preferred_username-` prefix, and restrict access to other users' buckets.
{{% /alert %}}

See the
[official MinIO documentation](https://min.io/docs/minio/linux/administration/identity-access-management/policy-based-access-control.html)
for more details.

## Step 3: Configure EGI Check-in as external OpenID Connect Identity Provider

### Step 3.1: Add service to EGI Federation Registry

Follow the steps to configure an OpenID Connect Service Provider with
[EGI Check-in](../../../providers/check-in/sp/#openid-connect-service-provider).

Apart from selecting `OIDC Service` as the `protocol` when adding this service
to the [EGI Federation Registry](https://aai.egi.eu/federation/), you should
use the below as the `Redirect URI`:

```shell
https://<minio-console-endpoint>/oauth_callback
```

### Step 3.2: Configure MinIO console

Now configure [EGI Check-in](../../aai/check-in) as external OpenID Connect
Identity Provider for MinIO.

Go to `https://<minio-console-endpoint>/settings/configurations/identity_openid`
and set the following values

1. Config URL: get `Provider configuration` value
   [in the docs](../../../providers/check-in/sp/#endpoints).
1. Client ID: get value from Step 3.1 above.
1. Secret ID: get value from Step 3.1 above.
1. Claim Name: `eduperson_entitlement`
1. Claim UserInfo: `ON`
1. Redirect URI: `https://<minio-console-endpoint>/oauth_callback`
1. Scopes: `eduperson_entitlement,profile`

Next you need to restart MinIO for the changes to take effect.

## Step 4: Access MinIO console with Check-in

All going well, when you restart MinIO and go back to the console endpoint
you should see `Login with SSO` login button.

Please note that you will only be able to create buckets with the
`<preferred_username>-` prefix. `preferred_username` is an
[OIDC claim](https://auth0.com/docs/get-started/apis/scopes/openid-connect-scopes)
whose value can be obtained using the same `curl` command as the one in Step 1
above. For example, user `John Doe` will have a `preferred_username` similar to
`jdoe`. With the configuration detailed on this tutorial, he will be able to
create buckets with the following names:

- `s3://johndoe-private-bucket`
- `s3://johndoe-public-bucket`
- etc.

## Step 5: Command-line interface

Although the MinIO web interface allows you to manage buckets, advanced
users may want to use the command-line interface. MinIO comes with its own
[client](https://min.io/docs/minio/linux/reference/minio-mc.html#mc-install),
but it also works with S3-compatible tools. Go to the web interface and
create `access and secret keys` that you can use from the CLI.

```shell
https://<minio-console-endpoint>/access-keys
```

## Known issues

Below is the list known issues when working with this setup.

{{% alert title="Warning" color="warning" %}}
When using the web console via Check-in, often you get this error message:

`The Access Key Id you provided does not exist in our records.`

and suddenly you are not able to see your buckets or access keys.

Simply log out and log back in and the issue disappears.
{{% /alert %}}

{{% alert title="Warning" color="warning" %}}
MinIO admin is not able to login via the web console after configuring
the OpenID Connect Identity Provider. Check this
[issue on GitHub](https://github.com/minio/console/issues/2135) for
more details.
{{% /alert %}}
