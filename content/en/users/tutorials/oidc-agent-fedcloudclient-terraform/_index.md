---
title: "Using Terraform with oidc-agent and fedcloudclient"
type: docs
weight: 10
description: >
  Step by step guide to Terraform with oidc-agent and fedcloudclient
---

## Overview

This tutorial describes how to create a Virtual Machine in the EGI Federation,
leveraging [oidc-agent](https://indigo-dc.gitbook.io/oidc-agent/) to retrieve
ODIC tokens from [EGI Check-in](../../aai/check-in),
[fedcloudclient](https://fedcloudclient.fedcloud.eu/) to simplify interacting
with the [EGI Cloud Compute service](../../compute/cloud-compute),
[terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com/) to
simplify deploying an infrastructure.
[EGI Dynamic DNS](../../compute/cloud-compute/dynamic-dns) is also used to
assign a domain name to the virtual machine.

## Step 1: Signing up

Create an EGI account with [Check-in](../../aai/check-in/signup).

## Step 2: Enrolling to a Virtual Organisation

Once your EGI account is ready you need to join a
[Virtual Organisation (VO)](https://confluence.egi.eu/display/EGIG/Virtual+organisation).
Here are the steps to
[join a VO](../../aai/check-in/joining-virtual-organisation/). Explore the list
of available VOs in the
[Operations Portal](https://operations-portal.egi.eu/vo/a/list). We have a
dedicated VO called
[vo.access.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.access.egi.eu)
for piloting purposes. If you are not sure about which VO to enrol to, please
request access to the _vo.access.egi.eu_ VO with your EGI account by visiting
the [enrolment URL](https://aai.egi.eu/registry/co_petitions/start/coef:240).
Check [AppDB](https://appdb.egi.eu/store/vo/vo.access.egi.eu) to see the list of
Virtual Appliances and Resource Providers participating in the
_vo.access.egi.eu_ VO. AppDB is one of the service in the
[EGI Architecture](../../getting-started/architecture/).

> This tutorial will assume you are using `vo.access.egi.eu`, adapt as required
> for your specific environment.

## Step 3: Creating a VM

Once your membership to a VO has been approved you are ready to create your
first Virtual Machine.

The OpenID Connect (OIDC) protocol is used to authenticate users and authorise
access to [Cloud Compute](../../compute/cloud-compute/) resources that are
integrated with [EGI Check-in](../../aai/check-in/).

While it's not mandatory, a convenient way to manage the OIDC token is to use
[oidc-agent](#setting-up-oidc-agent).

### Setting up oidc-agent

> [oidc-agent](https://indigo-dc.gitbook.io/oidc-agent/) is a set of tools to
> manage OpenID Connect tokens and make them easily usable from the command
> line.

Install `oidc-agent` according to
[official documentation](https://indigo-dc.gitbook.io/oidc-agent/installation),
once `oidc-agent` is installed it can be used to retrieve an OIDC access token
from EGI Check-in.

```shell
# Generate configuration for EGI Check-in
oidc-gen --pub --issuer https://aai.egi.eu/auth/realms/egi \
            --scope "email \
             eduperson_entitlement \
             eduperson_scoped_affiliation \
             eduperson_unique_id" egi
# List existing configuration
oidc-add -l
# Request an OIDC access token
oidc-token egi
# Setting a variable for an access token to be used with OpenStack
# XXX access tokens are short lived, relaunch command to obtain a new token
export OS_ACCESS_TOKEN=`oidc-token egi`
```

It's possible to automatically start `oidc-agent` in your shell initialisation,
example that can be added to `~/.bash_profile` or `~/.zshrc`:

```bash
if command -v oidc-agent-service &> /dev/null
  eval `oidc-agent-service use`
  # for fedcloudclient, once egi account got created
  export OIDC_AGENT_ACCOUNT=egi
fi
```

See [full documentation](https://indigo-dc.gitbook.io/oidc-agent/).

### Identifying a suitable cloud site

It's possible to deploy an OpenStack Virtual Machine (VM) on any of the sites
supporting the Virtual Organisations (VO) you are a member of.

[`fedcloudlcient`](https://fedcloudclient.fedcloud.eu/) is an high-level Python
package for a command-line client designed for interaction with the OpenStack
services in the EGI infrastructure. The client can access various EGI services
and can perform many tasks for users including managing access tokens, listing
services, and mainly execute commands on OpenStack sites in EGI infrastructure.

`fedcloudclient` can leverage [`oidc-agent`](#setting-up-oidc-agent) if it's
installed and properly configured.

`fedcloudclient` and
[`opentackclient`](https://docs.openstack.org/python-openstackclient/latest/)
will be used to interact with the EGI Cloud Compute service. Both of them can be
installed in a
[python virtualenv](https://docs.python.org/3/tutorial/venv.html):

```shell
# Creating a python 3 virutal env
python3 -m venv ~/.virtualenvs/fedcloud
# Activating the virutal env
source ~/.virtualenvs/fedcloud
# Installing required packages
pip install -U openstackclient
pip install -U fedcloudclient
```

```shell
# Listing the VO membership related to your OIDC access token
fedcloud token list-vos
```

In order to look for sites supporting a particular VO, you can use the
[EGI Application Database](https://appdb.egi.eu/browse/vos/cloud).

`vo.access.egi.eu` is a VO for piloting activities, you can enrol via
[EGI Check-in](https://aai.egi.eu/registry/co_petitions/start/coef:240).

You can retrieve information from the AppDB about the sites supporting the
[vo.access.egi.eu VO](https://appdb.egi.eu/store/vo/vo.access.egi.eu).

### Deploying the Virtual Machine

In the following example, the `IN2P3-IRES` site supporting the
`vo.access.egi.eu` VO will be used.

#### Creating the VM manually

```shell
# Setting environement up
export EGI_SITE='IN2P3-IRES'
export EGI_VO='vo.access.egi.eu'
# Export variables for OpenStack access
eval `fedcloud site env`
# Selecting an image
fedcloud select image --image-specs "Name =~ 'EGI.*22'"
export IMAGE_ID="..."
# Selecting a flavor
fedcloud select flavor --flavor-specs "RAM>=2096" --flavor-specs "Disk > 10" --vcpus 2
export FLAVOR_ID="..."
# Selecting network
fedcloud select network --network-specs default
export NETWORK_ID="..."
# Registering an ssh key
openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey
# Identifying and configuring security groups
openstack security group list
openstack security group rule list default
openstack security group rule list http
# Creating the server (the Virtual Machine)
openstack server create --flavor $FLAVOR_ID \
  --image $IMAGE_ID \
  --nic net-id=$NETWORK_ID \
  --security-group default --security-group http \
  --key-name mykey vm1-scoreboard
export SERVER_ID="..."
# Listing VMS
fedcloud openstack --site $EGI_SITE server list
# List the created VM
fedcloud openstack --site $EGI_SITE server show $SERVER_ID
# Listing network and find external one
openstack network list
# Creating a floating IP on external/public network (ext-net for this site)
openstack floating ip create ext-net
export FLOATING_IP='XXX.XXX.XXX.XXX'
# Assigning the public floating IP to the VM
openstack server add floating ip $SERVER_ID $FLOATING_IP
# Accessing the VM
ssh ubuntu@$FLOATING_IP
```

##### Using the EGI Dynamic DNS service

Once connected to the VM, it's possible to use the
[EGI Dynamic DNS service](https://docs.egi.eu/users/compute/cloud-compute/dynamic-dns/)
to get a registered domain name, that can also be used for getting a
[Let's Encrypt certificate](https://letsencrypt.org/).

```shell
# Accessing the VM using its IP Address
ssh ubuntu@$FLOATING_IP
sudo apt update && sudo apt upgrade
# Login to NSupdate service with EGI
# https://docs.egi.eu/users/compute/cloud-compute/dynamic-dns/
https://nsupdate.fedcloud.eu/
# Register a new VM, and get URL with secret
# From the VM
curl "https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update"
# Accessing the VM using its domain name
ssh ubuntu@<hostname>
```

#### Creating the VM with terraform

Instead of creating the server manually, it is possible to use
[terraform with EGI Cloud Compute](../../compute/cloud-compute/openstack/#terraform).

The
[Terraform OpenStack provider](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs)
provides official documentation.

Terraform provides
[installation instructions](https://www.terraform.io/downloads) for all usual
platforms.

Once terraform is installed locally, you can make use of it.

Setting up the environment (OS\_\* variables will be used by terraform):

```shell
source ~/.virtualenvs/fedcloudclient/bin/activate
export EGI_VO='vo.access.egi.eu'
export EGI_SITE='IN2P3-IRES'
eval `fedcloud site env`
# Need an OS_TOKEN for terraform
# XXX this breaks using openstackclient
# rely on fedcloudclient or unset OS_TOKEN before using openstackclient
export OS_TOKEN=$(fedcloud openstack token issue --site "$EGI_SITE" --vo "$EGI_VO" -j | jq -r '.[0].Result.id')
```

Configure flavor, image, network variables for the site you want to use, see
example of [`IN2P3-IRES.tfvars`](IN2P3-IRES.tfvars):

```terraform
# Internal network
internal_net_id = "7ae7b0ca-f122-4445-836a-5fb7af524dcb"

# Public IP pool for floating IPs
public_ip_pool = "ext-net"

# Flavor: m1.medium
flavor_id = "ab1fbd4c-324d-4155-bd0f-72f077f0ebce"

# Image: CentOS 7 with docker
image_id = "8901c279-8aee-4b5b-be03-d4460cfe4008"

# Security groups
security_groups  = ["default"]
```

The initial configuration of the VM is done using a `cloud-init.yaml` file.
Replace `<NSUPATE_HOSTNAME>`, `<NSUPDATE_SECRET>`, `<GITHUB_USER_NAME>` by the
proper values.

```yaml
---
# cloud-config
runcmd:
  - [
      curl,
      "https://<NSUPATE_HOSTNAME>:<NSUPDATE_SECRET>@nsupdate.fedcloud.eu/nic/update",
    ]

users:
  - name: egi
    gecos: EGI
    primary_group: egi
    groups: users
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_import_id:
      - gh:<GITHUB_USER_NAME>

packages:
  - vim

package_update: true
package_upgrade: true
package_reboot_if_required: true
```

```shell
# Initialise working directory, install dependencies
terraform init
# Review plan of actions for creating the infrastructure
# Use relevant site-specific config file
terraform plan --var-file="${EGI_SITE}.tfvars"
# Create the infrastructure
# Manual approval can be skipped using -auto-approve
# The SERVER_ID will be printed (openstack_compute_instance_v2.scoreboard)
terraform apply --var-file="${EGI_SITE}.tfvars"
# Wait a few minutes for the setup to be finalised and connect to the server
ssh egi@$NSUPATE_HOSTNAME
```

##### Debugging terraform

The token used by Terraform for accessing OpenStack is short lived, it will have
to be renewed from time to time.

```shell
# Creating a new token to access the OpenStack endpoint
export OS_TOKEN=$(fedcloud openstack token issue --site "$EGI_SITE" --vo "$EGI_VO" -j | jq -r '.[0].Result.id')
```

It is possible to print a verbose/debug output to get details on interactions
with the OpenStack endpoint.

```shell
# Debugging
OS_DEBUG=1 TF_LOG=DEBUG terraform apply -auto-approve --var-file="${EGI_SITE}.tfvars"
```

##### Destroying the resources created by terraform

```shell
# Debugging
# Destroying the created infrastructure
terraform destroy --var-file="${EGI_SITE}.tfvars"
```

#### Integrating Terraform with Ansible

## Asking for help

If you find issues please do not hesitate to [contact us](../../../support/).
