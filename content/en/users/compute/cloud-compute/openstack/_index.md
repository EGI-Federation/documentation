---
title: Using OpenStack Providers
type: docs
weight: 10
aliases:
  - /users/cloud-compute/openstack
description: >
  How to interact with the OpenStack providers APIs in the EGI Cloud
---

[OpenStack](https://openstack.org) providers of the EGI Cloud Compute service
offer native OpenStack features via native APIs integrated with EGI Check-in
accounts.

The extensive [OpenStack user documentation](https://docs.openstack.org/user/)
includes details on every OpenStack project most providers offer access to:

- [Keystone](https://docs.openstack.org/keystone/latest/), for identity
- [Nova](https://docs.openstack.org/nova/latest/), for VM management
- [Glance](https://docs.openstack.org/glance/latest/), for VM image
  management
- [Cinder](https://docs.openstack.org/cinder/latest/), for block storage
- [Swift](https://docs.openstack.org/swift/latest/), for object storage
- [Neutron](https://docs.openstack.org/neutron/latest/), for network
  management
- [Horizon](https://docs.openstack.org/horizon/latest/), as a web
  dashboard

The Horizon Web-dashboard of the OpenStack providers can be accessed using your
EGI Check-in credentials directly. See the
[Getting Started guide](../../../getting-started/openstack/) for more information.
The rest of this guide will focus on CLI/API access.

## Installation

The OpenStack client is a command-line client for OpenStack that brings the
command set for Compute, Identity, Image, Object Storage and Block Storage APIs
together in a single shell with a uniform command structure.

{{< tabpanex >}}
{{< tabx header="Linux / Mac" >}}

Installation of the OpenStack client can be done using:

```shell
pip install openstackclient
```

{{< /tabx >}}
{{< tabx header="Windows" >}}

As there are non-pure Python packages needed for installation, the
[Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
is a prerequisite, please make sure it's installed with the following options
selected:

- C++ CMake tools for Windows
- C++ ATL for latest v142 build tools (x86 & x64)
- Testing tools core features - Build Tools
- Windows 10 SDK (`<latest`>)

In case you prefer to use non-Microsoft alternatives for building non-pure
packages, please see [here](https://wiki.python.org/moin/WindowsCompilers).

Installation of the OpenStack client can be done using:

```shell
pip install openstackclient
```

{{< /tabx >}}
{{< /tabpanex >}}

Add IGTF CA to python\'s CA store:

```shell
cat /etc/grid-security/certificates/*.pem >> $(python -m requests.certs)
```

## Authentication

Check the documentation at the
[authentication and authorisation section](../auth) on how to get the right
credentials for accessing the providers.

### OpenStack token for other clients

Most OpenStack clients allow authentication with tokens, so you can easily use
them with EGI Cloud providers just doing a first step for obtaining the token.
With the OpenStack client you can use the following command to set the OS_TOKEN
variable with the needed token:

```shell
$ OS_TOKEN=$(openstack --os-auth-type v3oidcaccesstoken \
            --os-protocol openid --os-identity-provider egi.eu \
            --os-auth-url <keystone  url> \
            --os-access-token <your access token> \
            --os-project-id <your project id> token issue -c id -f value)
```

You can easily obtain an OpenStack token with the
[FedCloud client](../../../getting-started/cli):

```shell
fedcloud openstack --site <NAME_OF_THE_SITE> --vo <NAME_OF_VO> token issue -c id -f value
```

## Useful commands with OpenStack CLI

Usage of the OpenStack client is described in detail
[here](https://docs.openstack.org/python-openstackclient/latest).

Please refer to the
[nova documentation](https://docs.openstack.org/nova/latest/user/) for a
complete guide on the VM management features of OpenStack. We list in the
sections below some useful commands for the EGI Cloud.

### Registering an existing ssh key

It's possible to register an ssh key that can later be used as the default ssh
key for the default user of the VM (via the `--key-name` argument to
`openstack server create`):

```shell
openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey
```

### Creating a VM

```shell
openstack flavor list
FLAVOR=<FLAVOR_NAME>
openstack image list
IMAGE_ID=<IMAGE_ID>
openstack network list
# Pick FedCloud network
NETWORK_ID=<NETWORK_ID>
openstack security group list
openstack server create --flavor $FLAVOR --image $IMAGE_ID \
  --nic net-id=$NETWORK_ID --security-group default \
  --key-name mykey oneprovider
# Creating a floating IP
openstack floating ip create <NETWORK_NAME>
# Assigning floating IP to server
openstack server add floating ip <SERVER_ID> <IP>
# Removing floating IP from server
openstack server show <SERVER_ID>
# Deleting server
openstack server remove floating ip <SERVER_ID> <IP>
openstack server delete <SERVER_ID>
# Deleting floating IP
openstack floating ip delete <IP>
```

- [OpenStack: launch an instance on the provider network](https://docs.openstack.org/mitaka/install-guide-obs/launch-instance-provider.html)
- [OpenStack: Managing IP addresses](https://docs.openstack.org/ocata/user-guide/cli-manage-ip-addresses.html)

### Using cloud-init

```shell
openstack server create --flavor m3.medium \
  --image d0a89aa8-9644-408d-a023-4dcc1148ca01 \
  --user-data userdata.txt --key-name My_Key server01.example.com
```

- [OpenStack: providing user data (cloud-init)](https://docs.openstack.org/nova/latest/user/user-data.html)
- [cloudinit documentation](https://cloudinit.readthedocs.io/en/latest/index.html)

#### Shell script data as user data

```shell
#!/bin/sh
adduser --disabled-password --gecos "" clouduser
```

#### cloud-config data as user data

```yaml
#cloud-config
hostname: mynode
fqdn: mynode.example.com
manage_etc_hosts: true
```

- [Official cloud-config examples](https://cloudinit.readthedocs.io/en/latest/topics/examples.html#yaml-examples)
- [Cloud-init example](https://www.zetta.io/en/help/articles-tutorials/customizing-instance-deployment-cloud-init/)

### Creating a snapshot image from running VM

You can create a new image from a snapshot of an existing VM that will allow you
to easily recover a previous version of your VM or to use it as a template to
clone a given VM.

```shell
openstack server image create <your VM> --name <name of the snapshot>
```

Once the snapshot is ready `openstack image show <name of the snapshot>` will
give your the details you can use it as any other image at the provider:

```shell
openstack server create --flavor <flavor> \
  --image <name of the snapshot> \
  <name of the new VM>
```

You can override files in the snapshot if needed, e.g. changing the SSH keys:

```shell
openstack server create --flavor <flavor> \
  --image <name of the snapshot> \
  --file /home/ubuntu/.ssh/authorized_keys=my_new_keys \
  <name of the new VM>
```

## Terraform

[Terraform](https://terraform.io/) supports EGI Cloud OpenStack providers by
using valid access tokens for Keystone. For using this, just configure your
provider as usual in Terraform, but do not include user/password information.
Instead, use the [FedCloud client](../../../getting-started/cli) client to configure
environment variables as follows:

```shell
# export OS_AUTH_URL and OS_PROJECT_ID with
$ eval "$(fedcloud site show-project-id --site <NAME_OF_SITE> --vo <NAME_OF_VO>)"

# now get a valid token
$ export OS_TOKEN=$(fedcloud openstack --site <NAME_OF_SITE> --vo <NAME_OF_VO> \
                    token issue -c id -f value)
```

Here is a sample `main.tf` configuration file for Terraform:

```terraform
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

# Create a server
resource "openstack_compute_instance_v2" "vm" {
  name = "testvm"
  image_id = "..."
  flavor_id = "..."
  security_groups = ["default"]
}
```

Initialize Terraform with:

```shell
$ terraform init
```

Now check the deployment plan:

```shell
$ terraform plan
```

If you are happy with the plan, perform the deployment with:

```shell
$ terraform apply
```

For more information on how to use Terraform with OpenStack please check the
[OpenStack provider documentation](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/).

## libcloud

[Apache libcloud](https://libcloud.apache.org/index.html) supports OpenStack and
EGI authentication mechanisms by setting the `ex_force_auth_version` to
`3.x_oidc_access_token` or `2.0_voms` respectively. Check the
[libcloud docs on connecting to OpenStack](https://libcloud.readthedocs.io/en/latest/compute/drivers/openstack.html#connecting-to-the-openstack-installation)
for details. See below two code samples for using them

### OpenID Connect

```python
import requests

from libcloud.compute.types import Provider
from libcloud.compute.providers import get_driver

refresh_data = {
    'client_id': '<your client_id>',
    'client_secret': '<your client_secret>',
    'grant_type': 'refresh_token',
    'refresh_token': '<your refresh_token>',
    'scope': 'openid email profile',
}

r = requests.post("https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/token",
                  auth=(client_id, client_secret),
                  data=refresh_data)

access_token = r.json()['access_token']

OpenStack = get_driver(Provider.OPENSTACK)
# first parameter is the identity provider: "egi.eu"
# Second parameter is the access_token
# The protocol 'openid' is specified in ex_tenant_name
# and tenant/project cannot be selected :(
driver = OpenStack('egi.eu', access_token, ex_tenant_name='openid',
                   ex_force_auth_url='https://keystone_url:5000',
                   ex_force_auth_version='3.x_oidc_access_token')
```

### VOMS

```python
from libcloud.compute.types import Provider
from libcloud.compute.providers import get_driver

OpenStack = get_driver(Provider.OPENSTACK)
# assume your proxy is available at /tmp/x509up_u1000
# you can obtain a proxy with the voms-proxy-init command
# no need for username
driver = OpenStack(None, '/tmp/x509up_u1000', ex_tenant_name='EGI_FCTF',
                   ex_force_auth_url='https://sbgcloud.in2p3.fr:5000',
                   ex_force_auth_version='2.0_voms')
```
