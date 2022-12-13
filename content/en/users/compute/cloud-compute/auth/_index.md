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

[OpenID Connect](http://openid.net/connect/) (OIDC) is the main authentication protocol
used on the EGI Cloud. It replaces the legacy VOMS-based authentication for all
OpenStack providers.

Authentication to web based services (like the AppDB) will redirect you to the
EGI Check-in authentication page. Just select your institution or social login
and follow the regular authentication process.

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
that are members of a VO will have access to the providers supporting that VO:
they will be able to manage VMs, block storage and object storage available to
the VO. Resources (VMs and storage) are shared across all members of the VO,
please do not interfere with the VMs of other users if you are not entitled to
do so (specially do not delete them).

Some users roles have special consideration in VOs:

- Users with VO Manager, VO Deputy or VO Expert Role have extra privileges in
  the AppDB for managing the Virtual Appliances to be available at every
  provider. Check the [Virtual Machine Image Management documentation](../images)
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

For joining this VO, please click on the
[enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:240)
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

If you need to obtain these kind of tokens for using it in command-line tools or APIs,
you can easily do so with the EGI Check-in Token Portal. You can access the
[EGI Check-in Token Portal](https://aai.egi.eu/token) and click on
\'Authorise\' to log in with your Check-in credentials to obtain:

- a client ID (`token-portal`)
- a refresh token

{{% alert title="Refresh tokens" color="danger" %}}

Refresh tokens should be treated with care! This is a secret that can be used to
impersonate you in the infrastructure. It is recommended not to store them in
plain text.{{% /alert %}}

Alternatively, you can use the
[oidc-agent](https://indigo-dc.gitbook.io/oidc-agent/user/oidc-gen/provider/egi)
tool that is able to manage your tokens locally, or the
[fedcloud](https://fedcloudclient.fedcloud.eu/) client executed inside
[EGI Notebooks](../../../dev-env/notebooks/integration/#fedcloud-client).

### Discovering projects in Keystone

The _access token_ will provide you access to a cloud provider, but you may have
access to several different projects within that provider (a project can be
considered equivalent to a VO allocation). In order to discover which projects
are available you can do that using the Keystone API.

You can use the [fedcloud](https://fedcloudclient.fedcloud.eu/) client to
simplify the discovery of projects.

```shell
# Get a list of sites (also available in [AppDB](https://appdb.egi.eu))
fedcloud site list
# Get list of projects that you are allowed to access
# You can either specify the name of the account in your oidc-agent configuration
# or directly a valid access token
fedcloud endpoint projects --site=<name of the site> \
         [--oidc-agent-account <account name>|--oidc-access-token <access token>]
# You can also use environment variables for the configuration
export EGI_SITE=<name of the site>
export OIDC_ACCESS_TOKEN=<your access token>
fedcloud endpoint projects
# or with  oidc-agent
export OIDC_AGENT_ACCOUNT=<account name>
fedcloud enpoint projects
```

### Using the OpenStack API

Once you know which project to use, you can use your regular openstack cli
commands for performing actual operations in the provider:

```shell
fedcloud openstack image list --site <NAME_OF_SITE> --vo <NAME_OF_VO>
```

For third-party tools that can use token based authentication in OpenStack, use
the following command:

```shell
export OS_TOKEN=$(fedcloud openstack --site <NAME_OF_SITE> --vo <NAME_OF_VO> \
                  token issue -c id -f value)
```

### Using ssh-oidc

[ssh-oidc](https://github.com/EOSC-synergy/ssh-oidc) is a collection of
tools that enable ssh using OpenID-Connect access tokens.

Most of the individual tools work standalone, but they may be combined to
establish complex installations with dynamic account provisioning in
multi-OP and multi-VO contexts.

The tools share these common design criteria:

- None of the ssh-client or ssh-server components will be modified
- Do not store state whenever possible
    - Single exception: federated-user -> local-user mapping is stored in
        `passwd`
- Small components that work individually (one tool for one job)

#### Installation (client-side)

`ssh-oidc` does not require specific clients per se. OIDC Access-Tokens
may simply be passed, when ssh prompts for the "Access Token".
Unfortunately, the most-popular ssh-client does not support access-tokens
which are longer than 1024 bytes _and_ EGI uses tokens that are typically
longer than 1024 byte.

Hence, we suggest using [mccli](https://mccli.readthedocs.org) (`pip
install mccli`) on Unix/Mac. Windows users should use the putty
`oidc-plugin`, which conveniently ships with
[oidc-agent-for-windows](http://repo.data.kit.edu/windows/oidc-agent/)

For conveniently obtaining access tokens,
[oidc-agent](https://indigo-dc.gitbook.io/oidc-agent) is probably the most
convenient choice.

#### Installation (server-side)

Within the federated cloud, there are multiple options for installing
the ssh-oidc server-side components

1. Via the Infrastructure Manager (IM) <https://im.egi.eu>: IM offers
   starting a variety of VM infrastructures.
   - Choosing the "virtual machine with extra HD".
   - Add **motley-cue** to enable SSH-OIDC.
   - Configure whether you want to allow other members of your VOs (or a
       specific VO) that should be authorised to use ssh.

   The started VM will then allow ssh access with an OIDC Access Token.

   The user that started the VM will be mapped to `cloudadm` and be able to execute
   `sudo`.

1. Manual installation:
    - Install `motley-cue`, and `pam-ssh-oidc` (or
      `pam-ssh-oidc-autoconfig`). Details here:
          <https://github.com/EOSC-synergy/ssh-oidc/blob/master/installation.md>
    - Configure `motley-cue`. Details here:
        <https://github.com/EOSC-synergy/ssh-oidc/blob/master/configuration.md>

