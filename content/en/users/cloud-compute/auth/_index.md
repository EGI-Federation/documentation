---
title: "Authentication and Authorisation"
type: docs
weight: 20
description: >
  Authentication and Authorisation on EGI Cloud
---

## Authentication {#oidc-auth-using-check-in}

[OpenID Connect](http://openid.net/connect/) is the main authentication protocol
used on the EGI Cloud. It replaces the legacy VOMS-based authentication for all
OpenStack providers.

Authentication to web based services (like the AppDB) will redirect you to the
EGI Check-in authentication page. Just select your institution or social login
and follow the regular authentication process.

Access to APIs or via Command Line Interfaces (CLI) requires the use of OAuth2.0
tokens and interaction with the OpenStack Keystone
[OS-FEDERATION API](https://developer.openstack.org/api-ref/identity/v3-ext/index.html#os-federation-api).
The process for authentication is as follows:

1. Obtain a valid OAuth2.0 access token from Check-in. Access tokens are
   short-lived credentials that can be obtained by recognised Check-in clients
   once a user has been authenticated.
1. Interchange the Check-in access token for a valid unscoped Keystone token.
1. Discover available projects from Keystone using the unscoped token.
1. Use the unscoped Keystone token to get a scoped token for a valid project.
   Scoped tokens will allow the user to perform operations on the provider.

## Authorisation

Cloud Compute service is accessed through **Virtual Organisations (VOs)**. Users
that are members of a VO will have access to the providers supporting that VO:
they will be able to manage VMs, block storage and object storage available to
the VO. Resources (VMs and storage) are shared across all members of the VO,
please do not interfere with the VMs of other users if you are not entitled to
do so (specially do not delete them).

Some users roles have special consideration in VOs:

- Users with VO Manager, VO Deputy or VO Expert Role have extra privileges in
  the AppDB for managing the Virtual Appliances to be available at every
  provider. Check the [Virtual Machine Image Management documentation](../vmi/)
  for more information.

### Pilot VO

The
[vo.access.egi.eu Virtual Organisation](https://operations-portal.egi.eu/vo/view/voname/vo.access.egi.eu)
serves as a test ground for users to try the Cloud Compute service and to
prototype and validate applications. It can be used for up to 6 month by any new
user.

{{% alert title="Warning" color="warning" %}}

- After the 6-month long membership in the vo.access.egi.eu VO, you will need to
  move to a production VO, or establish a new VO.
- The resources are not guaranteed and may be removed without notice by
  providers. **Back-up frequently to avoid losing your work!**

{{% /alert %}}

For joining this VO, just place an order in the
[EGI Marketplace](https://marketplace.egi.eu/31-cloud-compute) and once approved
you will be able to interact with the infrastructure.

### Other VOs

Pre-existing VOs of EGI can be also used on IaaS cloud providers. Consult with
your VO manager or browse the existing VOs at the
[EGI Operations Portal](https://operations-portal.egi.eu/vo/).

## Check-in and access tokens

Access tokens can be obtained via several mechanisms, usually involving the use
of a web server and a browser. Command line clients/APIs without access to a
browser or interactive prompt for user authentication can use refresh tokens. A
refresh token is a special token that is used to generate additional access
tokens. This allows you to have short-lived access tokens without having to
collect credentials every single time one expires. You can request this token
alongside the access and/or ID tokens as part of a user's initial authentication
flow.

In the case of EGI Check-in, we have created a special client meant to obtain
your personal refresh token and client credentials that will allow the obtention
of access tokens as needed. You can access the
[FedCloud Check-in client](https://aai.egi.eu/fedcloud) and click on
\'Authorise\' to log in with your Check-in credentials to obtain:

- a client id
- a client secret
- a refresh token

Note them down so you can use them for the next steps.

### Discovering projects in Keystone

The _access token_ will provide you access to a cloud provider, but you may have
access to several different projects within that provider (a project can be
considered equivalent to a VO allocation). In order to discover which projects
are available you can do that using the Keystone API.

You can use the [`egicli`](https://github.com/EGI-Federation/egicli) to simplify
the discovery of projects. First, define these variables in your environment:

- `CHECKIN_CLIENT_ID`: Your Check-in client id (get it from
  [FedCloud Check-in client](https://aai.egi.eu/fedcloud))
- `CHECKIN_CLIENT_SECRET`: Your Check-in client secret (get it from
  [FedCloud Check-in client](https://aai.egi.eu/fedcloud))
- `CHECKIN_REFRESH_TOKEN`: Your Check-in refresh token (get it from
  [FedCloud Check-in client](https://aai.egi.eu/fedcloud))
- `EGI_SITE`: Name of the site (get it from [AppDB](https://appdb.egi.eu), or
  list it with the `egicli endpoint list` command)

And use them to get the list of projects:

```shell
# Export OIDC env
export CHECKIN_CLIENT_ID=<CLIENT_ID>
export CHECKIN_CLIENT_SECRET=<CLIENT_SECRET>
export CHECKIN_REFRESH_TOKEN=<REFRESH_TOKEN>
# Retrieve list of projects from site
export EGI_SITE=<NAME_OF_THE_SITE>
egicli endpoint projects
```

### Using the OpenStack API

Once you know which project to use, you can use your regular openstack cli
commands for performing actual operations in the provider:

```shell
# Export OIDC env
export CHECKIN_CLIENT_ID=<CLIENT_ID>
export CHECKIN_CLIENT_SECRET=<CLIENT_SECRET>
export CHECKIN_REFRESH_TOKEN=<REFRESH_TOKEN>
# EGI site
export EGI_SITE=<NAME_OF_THE_SITE>
export OS_PROJECT_ID=<PROJECT_ID>
# get environment variables for openstack
eval "$(egicli endpoint env)"
openstack image list
```

For 3rd party tools that can use token based authentication in OpenStack, use
the following command (after setting the environment as shown above):

```shell
# Export OIDC env
export CHECKIN_CLIENT_ID=<CLIENT_ID>
export CHECKIN_CLIENT_SECRET=<CLIENT_SECRET>
export CHECKIN_REFRESH_TOKEN=<REFRESH_TOKEN>
# EGI site
export EGI_SITE=<NAME_OF_THE_SITE>
eval "$(egicli endpoint token)"
```

## Legacy X.509 AAI

{{% alert title="Warning" color="warning" %}}

OpenID Connect is the preferred federated identity technology on EGI Cloud. Use
of X.509 certificates should be limited to legacy applications. {{% /alert %}}

[VOMS](https://italiangrid.github.io/voms/index.html) uses X.509 proxies
extended with VO information for authentication and authorisation on the
providers. You can learn about X.509 certificates and VOMS in the
[Check-in documentation](../../check-in/vos/voms).

### VOMS configuration

Valid configuration for `fedcloud.egi.eu` is available on the
[FedCloud client VM](https://appdb.egi.eu/store/vappliance/egi.fedcloud.clients)
as generated by the
[fedcloud-ui installation script](https://raw.githubusercontent.com/EGI-FCTF/fedcloud-userinterface/master/fedcloud-ui.sh).

VOMS client expects your certificate and private key to be available at
`$HOME/.globus/usercert.pem` and `$HOME/.globus/userkey.pem` respectively.

### Access the providers

VOMS authentication differs from one provider to another depending on the
technology used. There are 3 different cases handled automatically by the
`rOCCI-cli`. For accessing native OpenStack sites there are two different
plugins available for Keystone that are installed with a single library:

```shell
pip install openstack-voms-auth-type
```

For Keystone-VOMS based installations (Keystone URL ending on `/v2.0`), just
define the location of your proxy and `v2voms` as authorisation plugin:

<!-- markdownlint-disable line-length -->

```shell
openstack --os-auth-url https://<keystone-url>/v2.0 \
          --os-auth-type v2voms --os-x509-user-proxy /tmp/x509up_u1000 \
          token issue
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field   | Value                                                                                                                                                              |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| expires | 2019-02-04T12:41:25+0000                                                                                                                                           |
| id      | gAAAAABcWCTlMoz6Jx9IHF5hj-ZOn-CI17CfX81FTn7yy0ZJ54jkza7QNoQTRU5-KRJkphmes55bcoSaaBRnE3g2clFgY-MR2GVUJZRkCmj9TXsLZ-hVBWXQNENiX9XxUwnavj7KqDn4b9B1K22ijTrjdDVkcdpvMw |
| user_id | 9310054c2b6f4fd28789ee08c2351221                                                                                                                                   |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

<!-- markdownlint-enable line-length -->

For those Keystone installations supporting only `v3`, specify `v3voms` as
authorisation plugin, `egi.eu` as identity provider, `mapped` as protocol, and
the location of your proxy:

<!-- markdownlint-disable line-length -->

```shell
openstack --os-auth-url https://<keystone url>/v3 \
          --os-auth-type v3voms --os-x509-user-proxy /tmp/x509up_u1000 \
          --os-identity-provider egi.eu --os-protocol mapped \
          token issue
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field   | Value                                                                                                                                                                                                        |
+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| expires | 2019-02-04T12:45:32+0000                                                                                                                                                                                     |
| id      | gAAAAABcWCXcXGUDpHUYnI1IDLW3MnEpDzivw_OPaau8DQDYxA7gK9XsmOqZh1pL5Uqqs8aM-tHowdJQnJURww2-UhmQVqk5PxbjdnvLeqtXPYURCLaSsbmhkQg6kB311c_ZA1jfgdT-pG6fZz3toeH66SEFX-H0bThSUy0KFLhcZVkrZIbYgTsAOIzFkTfLjOgTw_tNChS8 |
| user_id | 50fa8516b2554daeae652619ba9ebf96                                                                                                                                                                             |
+---------+----------------------------------------------------------------------------------------------------------------------------------------
```

<!-- markdownlint-enable line-length -->
