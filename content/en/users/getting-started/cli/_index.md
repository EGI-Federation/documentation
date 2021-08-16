---
title: "Command Line Interface"
linkTitle: "Command Line"
type: docs
weight: 30
description: >
  EGI FedCloud command line interface
---

## Command line tools

The various [public EGI services](https://www.egi.eu/services/) can be managed
and used/accessed with a wide variety of command line interface (CLI) tools.
The documentation of each service contains a summary of the CLIs that can be
used wih that service, together with recommendations on which one to use in
what context.

## The FedCloud client

The [FedCloud client](https://fedcloudclient.fedcloud.eu/index.html) is a
high-level Python package for a command-line client designed for interaction
with the [OpenStack services](../openstack) in the EGI Federated Cloud
(FedCloud).

{{% alert title="Tip" color="info" %}} The FedCloud client is the recommended
command line interface to use with most EGI services.
{{% /alert %}}

FedCloud client has the following modules (features):

- [**Check-in**](https://fedcloudclient.fedcloud.eu/fedcloudclient.html#module-fedcloudclient.checkin)
  allows checking validity of access tokens and listing
  [Virtual Organisations](../../check-in/vos) (VOs) of a token
- [**Endpoint**](https://fedcloudclient.fedcloud.eu/fedcloudclient.html#module-fedcloudclient.endpoint)
  can search endpoints in the [Configuration Database](../../../internal/configuration-database) and extract site-specific information from
  unscoped/scoped tokens
- [**Sites**](https://fedcloudclient.fedcloud.eu/fedcloudclient.html#module-fedcloudclient.sites)
  allows management of site configurations
- [**OpenStack**](https://fedcloudclient.fedcloud.eu/fedcloudclient.html#module-fedcloudclient.openstack)
  can perform commands on [OpenStack services](../openstack) deployed to sites
- **EC3** allows deploying [elastic cloud compute clusters](../../cloud-compute/ec3)

### Installation

The FedCloud client can be installed with the `pip3` Python package manager
(without root or aministrator privileges).

{{< tabpanex >}}
{{< tabx header="Linux / Mac" >}}

To install the FedCloud client:

```shell
$ pip3 install fedcloudclient
```

This installs the latest version of the FedCloud client, together with
its required packages (like _openstackclient_). It will also create
executables **fedcloud** and **openstack**, adding them to the _bin_
folder  corresponding to your current Python execution environment
(_$VIRTUAL_ENV/bin_ for executing pip3 in a Python virtual environment,
_~/.local/bin_ for executing pip3 as user (with --user option), and
_/usr/local/bin_ when executing pip3 as root).

{{< /tabx >}}
{{< tabx header="Windows" >}}

As there are non-pure Python packages needed for installation, the
[Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
is a prerequisite, make sure it's installed with the following options
selected:

- C++ CMake tools for Windows
- C++ ATL for latest v142 build tools (x86 & x64)
- Testing tools core features - Build Tools
- Windows 10 SDK (`<latest`>)

In case you prefer to use non-Microsoft alternatives for building non-pure
packages, please see [here](https://wiki.python.org/moin/WindowsCompilers).

To install the FedCloud client:

```shell
> pip3 install fedcloudclient
```

This installs the latest version of the FedCloud client, together with
its required packages (like _openstackclient_). It will also create
executables **fedcloud** and **openstack**, adding them to the _bin_
folder corresponding to your current Python execution environment.

{{< /tabx >}}
{{< /tabpanex >}}

Check if the installation is correct by executing the client:

```shell
$ fedcloud --version
```

#### Installing EGI Core Trust Anchor certificates

Some sites in the EGI infrastructure use certificates issued by
Certificate Authorities (CAs) that are not included in the default OS
distribution. If you receive error message "_SSL exception connecting
to..._", install the EGI Core Trust Anchor Certificates by running
the following commands:

```shell
$ wget https://raw.githubusercontent.com/tdviet/python-requests-bundle-certs/main/scripts/install_certs.sh
$ bash install_certs.sh
```

{{% alert title="Note" color="info" %}} The above script does not work on all
Linux distributions. Change _python_ to _python3_ in the script if needed,
see the [README](https://github.com/tdviet/python-requests-bundle-certs#usage)
for more details, or follow the
[official instructions](https://github.com/tdviet/python-requests-bundle-certs/blob/main/docs/Install_certificates.md)
for installing EGI Core Trust Anchor certificates in production environments.
{{% /alert %}}

### Using via Docker container

The FedCloud client can also be used without installation, by running it in a
Docker container. In this case, the EGI Core Trust Anchor certificates are
preinstalled.

To run the FedCloud client in a container, make sure
[Docker is installed](https://docs.docker.com/engine/install/), then run the
following commands:

```shell
$ sudo docker pull tdviet/fedcloudclient
$ sudo docker run -it  tdviet/fedcloudclient bash
```

Once you have a shell running in the container with the FedCloud client, usage
is the same as from [the command line](#using-from-the-command-line).

### Using from the command line

The FedCloud client has these subcommands:

- **fedcloud token** for checking access tokens
  (see [subcommands](https://fedcloudclient.fedcloud.eu/usage.html#fedcloud-token-commands))
- **fedcloud endpoint** for querying the Configuration Database
  (see [subcommands](https://fedcloudclient.fedcloud.eu/usage.html#fedcloud-endpoint-commands))
- **fedcloud site** for manipulating site configurations
  (see [subcommands](https://fedcloudclient.fedcloud.eu/usage.html#fedcloud-site-commands))
- **fedcloud openstack** or **fedcloud openstack-int** for performing
  OpenStack commands on sites
  (see [subcommands](https://fedcloudclient.fedcloud.eu/usage.html#fedcloud-openstack-commands))
- **fedcloud ec3** for provisioning elastic cloud compute clusters
  (see [subcommands](https://fedcloudclient.fedcloud.eu/usage.html#fedcloud-ec3-commands))

{{% alert title="Note" color="info" %}} See also the
[complete documentation](https://fedcloudclient.fedcloud.eu/index.html)
or read and contribute to the
[source code](https://github.com/EGI-Federation/fedcloudclient).
{{% /alert %}}

Performing any OpenStack command on any site requires only three options: the
site, the VO and the command. For example, to list virtual machine (VM) images
available to members of VO _fedcloud.egi.eu_ on the site _CYFRONET-CLOUD_, run
the following command:

```shell
$ fedcloud openstack image list --vo fedcloud.egi.eu --site CYFRONET-CLOUD
```

#### Authentication

Many of the FedCloud client commands need access tokens for authentication.
Users can choose whether to provide access tokens directly (via option
`--oidc-access-token`), or generate them on the fly with **oidc-agent**
(via option `--oidc-agent-account`) or from refresh tokens (via option
`--oidc-refresh-token`, which must be provided together
with a option `--oidc-client-id` and option `--oidc-client-secret`).

{{% alert title="Tip" color="info" %}} Users of EGI Check-in can get a Check-in
client ID, client secret, and refresh token, as well as all the information
needed to obtain access tokens for their FedCloud client, by visiting
[Check-in FedCloud client](https://aai.egi.eu/fedcloud/).
{{% /alert %}}

{{% alert title="Tip" color="info" %}} To provide access tokens automatically
via **oidc-agent**, follow [these instructions](https://indigo-dc.gitbook.io/oidc-agent/user/oidc-gen/provider/egi/)
to register a client, then pass the client name (account name used during
client registration) to the FedCloud client via option `--oidc-agent-account`.
{{% /alert %}}

{{% alert title="Important" color="warning" %}} Refresh tokens have long
lifetime (one year in EGI Check-in), so they must be properly protected.
Exposing refresh tokens via environment variables or command-line options is
considered insecure and will be disabled in the near future in favor of using
**oidc-agent**.
{{% /alert %}}

If multiple methods of getting access tokens are given at the same time, the
FedCloud client will try to get an access tokens from the **oidc-agent** first,
then obtain one using the refresh token.

The default authentication protocol is `openid`. Users can change the default
protocol via the option `--openstack-auth-protocol`. However, sites may have
the protocol fixed in the site configuration (e.g. `oidc` for the site
INFN-CLOUD-BARI).

The default OIDC identity provider is EGI Check-in (https://aai.egi.eu/oidc).
Users can set another OIDC identity provider via option `--oidc-url`. 

{{% alert title="Note" color="info" %}} Remember to also set the identity
provider's name accordingly for OpenStack commands, by using the option `--openstack-auth-provider`.
{{% /alert %}}

#### Environment variables

Most of the FedCloud client options can be set via environment variables:

{{% alert title="Tip" color="info" %}} To save a lot of time, set the frequently
used options like site, VO, access tokens, etc. using environment variables.
{{% /alert %}}



#### Getting help

The FedCloud client can display help for the commands and subcommands it
supports. Try running the following command to see the commands supported
by the FedCloud client:

```shell
$ fedcloud --help
Usage: fedcloud [OPTIONS] COMMAND [ARGS]...

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  ec3            EC3 related comands
  endpoint       endpoint command group for interaction with GOCDB and...
  openstack      Executing OpenStack commands on site and VO
  openstack-int  Interactive OpenStack client on site and VO
  site           Site command group for manipulation with site...
  token          Token command group for manipulation with tokens
```

Similarly, you can see help for e.g. the `openstack` subcommand by running the
command below:

```shell
$ fedcloud openstack --help
Usage: fedcloud openstack [OPTIONS] OPENSTACK_COMMAND...

  Executing OpenStack commands on site and VO

Options:
  --oidc-client-id TEXT           OIDC client id
  --oidc-client-secret TEXT       OIDC client secret
  --oidc-refresh-token TEXT       OIDC refresh token
  --oidc-access-token TEXT        OIDC access token
  --oidc-url TEXT                 OIDC URL  [default: https://aai.egi.eu/oidc]
  --oidc-agent-account TEXT       short account name in oidc-agent
  --openstack-auth-protocol TEXT  Check-in protocol  [default: openid]
  --openstack-auth-type TEXT      Check-in authentication type  [default:
                                  v3oidcaccesstoken]
  --openstack-auth-provider TEXT  Check-in identity provider  [default:
                                  egi.eu]
  --site TEXT                     Name of the site  [required]
  --vo TEXT                       Name of the VO  [required]
  -i, --ignore-missing-vo         Ignore sites that do not support the VO
  -j, --json-output               Print output as a big JSON object
  --help                          Show this message and exit.
```

{{% alert title="Note" color="info" %}} Most commands support multiple levels
of subcommands, you can get help for all of them using the same principle as
above.
{{% /alert %}}

### Using from Python

### Using in scripts

