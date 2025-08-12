---
title: Authentication and Authorisation
type: docs
weight: 20
aliases:
  - /users/cloud-compute/auth
description: >
  Authentication and Authorisation in EGI Cloud
---

## Authentication {#oidc-auth-using-check-in}

[OpenID Connect](https://openid.net/connect/) (OIDC) is the main authentication protocol
used on the EGI Cloud. It replaces the legacy VOMS-based authentication for all
OpenStack providers.

Authentication to web based services (like the OpenStack dashboards) will
redirect you to the EGI Check-in authentication page. Just select your
institution or social login and follow the regular authentication process.

Access to APIs or via command-line interfaces (CLI) requires the use of OAuth2.0
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
with specific roles (by default, the `vm_operator` role) will have access to
the providers supporting that VO: they will be able to manage VMs, block
storage and object storage available to the VO. Resources (VMs and storage) are
**shared** across all members of the VO, please do not interfere with the VMs
of other users if you are not entitled to do so (specially do not delete them).

Some users roles may have additional permissions in VOs, check your VO Manager
for the specific documentation.

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

For joining this VO, please click on the
[enrolment URL](https://aai.egi.eu/auth/realms/id/account/#/enroll?groupPath=/vo.access.egi.eu)
using your [EGI account](../../../aai/check-in/).

### Other VOs

Pre-existing VOs of EGI can be also used on IaaS cloud providers. Consult with
your VO manager or browse the existing VOs at the
[EGI Operations Portal](https://operations-portal.egi.eu/vo/a/list).

## Check-in and access tokens

Access tokens can be obtained via several mechanisms, usually involving the use
of a web server and a browser. Command-line clients/APIs without access to a
browser or interactive prompt for user authentication can use refresh tokens. A
refresh token is a special token that is used to generate additional access
tokens. This allows you to have short-lived access tokens without having to
collect credentials every single time one expires. You can request this token
alongside the access and/or ID tokens as part of a user's initial authentication
flow.

If you need to obtain these kinds of tokens for using it in command-line tools or APIs,
you can easily do so with the EGI Check-in Token Portal. You can access the
[EGI Check-in Token Portal](https://aai.egi.eu/token) and click on
\'Authorise\' to log in with your Check-in credentials to obtain:

- a client ID (`token-portal`)
- a refresh token

{{% alert title="Refresh tokens" color="danger" %}}

`Refresh tokens` MUST be treated with care! This is a secret that can be used to
impersonate you in the infrastructure. The life time of `refresh tokens` is up to one year!
It is recommended not to store them in
plain text.{{% /alert %}}

There are more secure alternatives for handling `refresh tokens`:

1. From your personal computer: use
  [oidc-agent](https://indigo-dc.gitbook.io/oidc-agent/user/oidc-gen/provider/egi)
  It is a tool that manages your tokens locally in a secure way `refresh
  tokens` are even encrypted in RAM).
2. [fedcloud](https://fedcloudclient.fedcloud.eu/) client executed inside
  [EGI Notebooks](../../../dev-env/notebooks/integration/#fedcloud-client).
3. [mytoken](https://mytoken.data.kit.edu) Securely stores refresh tokens
   on the mytoken-server. Users obtain `mytokens`, which can be used to
   obtain `access tokens`. `mytokens` are more secure, because they can
   carry `capabilities` and `restrictions` to fine tune their power for
   specific use cases. Details here: <https://mytoken-docs.data.kit.edu>

### Discovering projects in Keystone

The _access token_ will provide you access to a cloud provider, but you may have
access to several different projects within that provider (a project can be
considered equivalent to a VO allocation). In order to discover which projects
are available you can do that using the Keystone API.

You can use the [fedcloud](https://fedcloudclient.fedcloud.eu/) client to
simplify the discovery of projects.

```shell
# Get a list of sites
$ fedcloud site list
# Get list of projects that you are allowed to access
# You can either specify the name of the account in your oidc-agent configuration
# or directly a valid access token
$ fedcloud endpoint projects --site=<name of the site> \
         [--oidc-agent-account <account name>|--oidc-access-token <access token>]
# You can also use environment variables for the configuration
$ export OIDC_ACCESS_TOKEN=<your access token>
$ fedcloud endpoint projects
# or with  oidc-agent
$ export OIDC_AGENT_ACCOUNT=<account name>
$ fedcloud endpoint projects
```

### Using the OpenStack API

Once you know which project to use, you can use your regular openstack cli
commands for performing actual operations in the provider:

```shell
$ fedcloud openstack image list --site <NAME_OF_SITE> --vo <NAME_OF_VO>
```

For third-party tools that can use token based authentication in OpenStack, use
the following command:

```shell
$ export OS_TOKEN=$(fedcloud openstack --site <NAME_OF_SITE> --vo <NAME_OF_VO> \
                  token issue -c id -f value)
```

### Using ssh-oidc

[ssh-oidc](https://github.com/EOSC-synergy/ssh-oidc) is a set of tools that
allows ssh with OIDC.
