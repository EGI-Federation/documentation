---
title: "Automating with oidc-agent, fedcloudclient, terraform and Ansible"
type: docs
weight: 150
description: >
  Step by step guide to automating the deployment using Ansible with Terraform,
  oidc-agent and fedcloudclient
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
assign a domain name to the virtual machine, which can then be used to get a
valid TLS certificate from [Let's Encrypt](https://letsencrypt.org/).

## Step 1: Signing up for an EGI Check-in account

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
# Generating configuration for EGI Check-in
$ oidc-gen --pub --issuer https://aai.egi.eu/auth/realms/egi \
            --scope "email \
             eduperson_entitlement \
             eduperson_scoped_affiliation \
             eduperson_unique_id" egi
# Listing existing configuration
$ oidc-add -l
# Requesting an OIDC access token
$ oidc-token egi
# Exporting a variable with a Check-in OIDC access token to be used with OpenStack
# XXX access tokens are short lived, relaunch command to obtain a new token
# This is *not* required for following this tutorial, it's an example
$ export OS_ACCESS_TOKEN=$(oidc-token egi)
```

It's possible to automatically start `oidc-agent` in your shell initialisation,
example that can be added to `~/.bash_profile` or `~/.zshrc`:

```bash
if command -v oidc-agent-service &> /dev/null
  eval $(oidc-agent-service use)
  # for fedcloudclient, selecting egi configuration generated with oidc-gen
  export OIDC_AGENT_ACCOUNT=egi
fi
```

When using `oidc-agent-service`,
[fedcloudclient](#installing-fedcloudclient-and-ansible) will be able to
automatically request a new access token from `oidc-agent`.

See [full documentation](https://indigo-dc.gitbook.io/oidc-agent/).

### Installing fedcloudclient and ansible

[`fedcloudclient`](https://fedcloudclient.fedcloud.eu/) is an high-level Python
package for a command-line client designed for interaction with the OpenStack
services in the EGI infrastructure. The client can access various EGI services
and can perform many tasks for users including managing access tokens, listing
services, and mainly execute commands on OpenStack sites in EGI infrastructure.

`fedcloudclient` can leverage [`oidc-agent`](#setting-up-oidc-agent) if it's
installed and properly configured.

`fedcloudclient` and
[`openstackclient`](https://docs.openstack.org/python-openstackclient/latest/),
the official OpenStack python client, will be used to interact with the EGI
Cloud Compute service.

Required python dependencies are documented in a `requirements.txt` file
(Ansible will be used at a later stage, but is installed at the same time):

```requirements.txt
openstackclient
fedcloudclient
ansible
```

For keeping the main system tidy and isolating the environment, the python
packages will be installed in a dedicated
[python virtualenv](https://docs.python.org/3/tutorial/venv.html):

```shell
# Creating an arbitrary directory where to store python virtual environments
$ mkdir -p ~/.virtualenvs
# Creating a python 3 virtual environment
$ python3 -m venv ~/.virtualenvs/fedcloud
# Activating the virtual environment
$ source ~/.virtualenvs/fedcloud
# Installing required python packages in the virtual environment
$ pip install -r requirements.txt
```

### Identifying a suitable cloud site

It's possible to deploy an OpenStack Virtual Machine (VM) on any of the sites
supporting the Virtual Organisations (VO) you are a member of.

Once [fedcloudclient](#installing-fedcloudclient-and-ansible) is installed it's
possible to get information about the OIDC token accessed via
[oidc-agent](#setting-up-oidc-agent).

```shell
# Listing the VO membership related to the OIDC access token
$ fedcloud token list-vos
```

In order to look for sites supporting a particular VO, you can use the
[EGI Application Database](https://appdb.egi.eu/browse/vos/cloud).

You can retrieve information from the AppDB about the sites supporting the
[vo.access.egi.eu VO](https://appdb.egi.eu/store/vo/vo.access.egi.eu).

> In the following example, the `IN2P3-IRES` site supporting the
> `vo.access.egi.eu` VO will be used, see
> [Step 2: Enrolling to a Virtual Organisation](#step-2-enrolling-to-a-virtual-organisation)
> to request access.

### Deploying the Virtual Machine with terraform

Instead of creating the server manually, it is possible to use
[terraform with EGI Cloud Compute](../../compute/cloud-compute/openstack/#terraform).

The
[Terraform OpenStack provider](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs)
provides official documentation.

Terraform provides
[installation instructions](https://www.terraform.io/downloads) for all usual
platforms.

Once terraform is installed locally, we will create a deployment as documented
in the following sections.

#### Setting up the environment

The `OS_*` variables that will be used by terraform can be generated using
`fedcloudclient`.

```shell
# Activating the virtual environment
$ source ~/.virtualenvs/fedcloudclient/bin/activate
# Exporting variable for VO and SITE to avoid having to repeat them
$ export EGI_VO='vo.access.egi.eu'
$ export EGI_SITE='IN2P3-IRES'
eval $(fedcloud site env)
# Obtaining an OS_TOKEN for terraform
# XXX this breaks using openstackclient: use fedcloudclient
# or unset OS_TOKEN before using openstackclient
$ export OS_TOKEN=$(fedcloud openstack token issue --site "$EGI_SITE" \
    --vo "$EGI_VO" -j | jq -r '.[0].Result.id')
```

#### Describing the terraform variables

The main terraform configuration file,
[main.tf](#creating-the-main-terraform-deployment-file) is using variables that
have to be described in a `vars.tf` file:

```terraform
# Terraform variables definition
# Values to be provided in a *.tfvars file passed on the command line

variable "internal_net_id" {
  type        = string
  description = "The id of the internal network"
}

variable "public_ip_pool" {
  type        = string
  description = "The name of the public IP address pool"
}

variable "image_id" {
  type        = string
  description = "VM image id"
}

variable "flavor_id" {
  type        = string
  description = "VM flavor id"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security groups"
}
```

The SITE and VO specific values for those variables will be
[identified](#identifying-the-cloud-resources) and documented in a
[`$EGI_SITE.tfvars` file](#documenting-the-cloud-resources-for-the-selected-site).

#### Identifying the cloud resources

Once the [environment is properly configure](#setting-up-the-environment),
`fedcloudclient` is used to gather information and identify flavor, image,
network and security groups for the site you want to use.

> `fedcloud openstack` currently requires an explicit `--site` parameter, this
> will be addressed in a
> [future fedcloud release](https://github.com/tdviet/fedcloudclient/issues/150).
> In the meantime the `$EGI_SITE` environment variable can be reused using
> `--site "$EGI_SITE"`.

```shell
# Selecting an image
$ fedcloud select image --image-specs "Name =~ 'EGI.*22'"
# Selecting a flavor
$ fedcloud select flavor --flavor-specs "RAM>=2096" \
    --flavor-specs "Disk > 10" --vcpus 2
# Identifying available networks
$ fedcloud openstack --site "$EGI_SITE" network list
$ fedcloud select network --network-specs default
# Identifying security groups
$ fedcloud openstack --site "$EGI_SITE" security group list
# Listing rules of a specific security group
$ fedcloud openstack --site "$EGI_SITE" security group rule list default
```

#### Documenting the cloud resources for the selected site

The chosen flavor, image, network and security group should be documented in a
`$EGI_SITE.tfvars` file that will be passed as an argument to terraform
commands.

> The network configuration can be tricky, and is usually dependant on the site.
> For `IN2P3-IRES`, one has to request a floating IP from the public network IP
> pool `ext-net`, and assign this floating IP to the created instance. For
> another site it may not be needed, in that case the
> [main.tf](#creating-the-main-terraform-deployment-file) will have to be
> adjusted accordingly.

See the example `IN2P3-IRES.tfvars` below, to be adjusted according to the
requirements and to the selected site and VO:

```terraform
# Internal network
internal_net_id = "7ae7b0ca-f122-4445-836a-5fb7af524dcb"

# Public IP pool for floating IPs
public_ip_pool = "ext-net"

# Flavor: m1.medium
flavor_id = "ab1fbd4c-324d-4155-bd0f-72f077f0ebce"

# Image for EGI CentOS 7
# https://appdb.egi.eu/store/vappliance/egi.centos.7
image_id = "09093c70-f2bb-46b8-a87f-00e2cc0c8542"
# Image: EGI CentOS 8
# https://appdb.egi.eu/store/vappliance/egi.centos.8
# image_id = "38ced5bf-bbfd-434b-ae41-3ab35d929aba"
# Image: EGI Ubuntu 22.04
# https://appdb.egi.eu/store/vappliance/egi.ubuntu.22.04
# image_id = "fc6c83a3-845f-4f29-b44d-2584f0ca4177"

# Security groups
security_groups  = ["default"]
```

#### Creating the main terraform deployment file

To be more reusable, the `main.tf` configuration file is referencing variables
described in the [vars.tf](#describing-the-terraform-variables) file created
previously, and will take the values from the
[`$EGI_SITE.tfvars`](#documenting-the-cloud-resources-for-the-selected-site)
file passed as an argument to the terraform command.

```terraform
# Terraform versions and providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

# Allocate a floating IP from the public IP pool
resource "openstack_networking_floatingip_v2" "egi_vm_floatip_1" {
  pool = var.public_ip_pool
}

# Creating the VM
resource "openstack_compute_instance_v2" "egi_vm" {
  name = "egi_test_vm"
  image_id = var.image_id
  flavor_id = var.flavor_id
  security_groups = var.security_groups
  user_data = file("cloud-init.yaml")
  network {
    uuid = var.internal_net_id
  }
}

# Attach the floating public IP to the created instance
resource "openstack_compute_floatingip_associate_v2" "egi_vm_fip_1" {
  instance_id = "${openstack_compute_instance_v2.egi_vm.id}"
  floating_ip = "${openstack_networking_floatingip_v2.egi_vm_floatip_1.address}"
}

# Create inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.cfg.tpl",
    {
      ui = "${openstack_networking_floatingip_v2.egi_vm_floatip_1.address}"
    }
  )
  filename = "./inventory/hosts.cfg"
}
```

The last resource is relying on
[templatefile](https://www.terraform.io/language/functions/templatefile) to
populate the inventory file that will later be used by
[ansible](#step-4-using-ansible).

#### Initial configuration of the VM using cloud-init

> [cloud-init](https://cloudinit.readthedocs.io/) is the industry standard
> multi-distribution method for cross-platform cloud instance initialization.

The initial configuration of the VM is done using a `cloud-init.yaml` file.

The `curl` call from the
[runcmd](https://cloudinit.readthedocs.io/en/latest/topics/modules.html#runcmd)
block in the `cloud-init.yaml` configuration below, will register the IP of the
virtual machine in the DNS zone managed using the
[EGI Dynamic DNS service](https://nsupdate.fedcloud.eu/), allowing to access the
virtual machine using a fully qualified hostname and allowing to retrieve a
[Let's Encrypt certificate](https://letsencrypt.org/).

> Please look at the
> [EGI Dynamic DNS documentation](../../compute/cloud-compute/dynamic-dns/) for
> instructions on creating the configuration for a new host.

The
[users](https://cloudinit.readthedocs.io/en/latest/topics/modules.html#users-and-groups)
block in the `cloud-init.yaml` configuration below, will create a new user with
password-less [sudo](https://www.sudo.ws/) access.

> While this `egi` user can only be accessed via the specified SSH key(s),
> setting a user password and requesting password verification for using sudo
> should be considered, as a compromise of this user account would mean a
> compromise of the complete virtual machine.

Replace `<NSUPDATE_HOSTNAME>`, `<NSUPDATE_SECRET>`, `<SSH_AUTHORIZED_KEY>` (the
content of your SSH public key) by the proper values.

```yaml
---
# cloud-config
runcmd:
  - [
      curl,
      "https://<NSUPDATE_HOSTNAME>:<NSUPDATE_SECRET>@nsupdate.fedcloud.eu/nic/update",
    ]

users:
  - name: egi
    gecos: EGI
    primary_group: egi
    groups: users
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - <SSH_AUTHORIZED_KEY>

packages:
  - vim

package_update: true
package_upgrade: true
package_reboot_if_required: true
```

#### Launching the terraform deployment

Now that all the files have been created, it's possible to deploy the
infrastructure, currently only a single VM, but it can easily be extended to a
more complex setup, using terraform:

```shell
# Initialising working directory, install dependencies
$ terraform init
# Reviewing plan of actions for creating the infrastructure
# Use relevant site-specific config file
$ terraform plan --var-file="${EGI_SITE}.tfvars"
# Creating the infrastructure
# Manual approval can be skipped using -auto-approve
# The SERVER_ID will be printed (openstack_compute_instance_v2.scoreboard)
$ terraform apply --var-file="${EGI_SITE}.tfvars"
# Wait a few minutes for the setup to be finalised
# Connecting to the server using ssh
$ ssh egi@$NSUPDATE_HOSTNAME
```

> From here you can extend the
> [cloud-init.yaml](#initial-configuration-of-the-vm-using-cloud-init) and/or
> use [Ansible](#step-4-using-ansible) to configure the remote machine, as well
> as doing manual work via SSH.

#### Debugging terraform

The token used by Terraform for accessing OpenStack is short lived, it will have
to be renewed from time to time.

```shell
# Creating a new token to access the OpenStack endpoint
$ export OS_TOKEN=$(fedcloud openstack token issue --site "$EGI_SITE" \
    --vo "$EGI_VO" -j | jq -r '.[0].Result.id')
```

It is possible to print a verbose/debug output to get details on interactions
with the OpenStack endpoint.

```shell
# Debugging
$ OS_DEBUG=1 TF_LOG=DEBUG terraform apply --var-file="${EGI_SITE}.tfvars"
```

#### Destroying the resources created by terraform

```shell
# Destroying the created infrastructure
$ terraform destroy --var-file="${EGI_SITE}.tfvars"
```

## Step 4: Using Ansible

[Ansible](https://www.ansible.com/) can be used to manage the configuration of
the crated virtual machine.

The [terraform deployment](#deploying-the-virtual-machine-with-terraform)
generated an
[Ansible inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html),
`inventory/hosts.cfg`, that can directly be used by
[Ansible](https://www.ansible.com/).

Configure a basic Ansible environment in the `ansible.cfg` file:

```ini
[defaults]
# Use user created using cloud-init.yml
remote_user = egi
# Use inventory file generated by terraform
inventory = ./inventory/hosts.cfg

[privilege_escalation]
# Escalate privileges using password-less sudo
become = yes
```

Then you can verify that the Virtual Machine is accessible by Ansible:

```shell
# Confirming ansible can reach the VM
$ ansible all -m ping
```

Once this works, you can
[create advanced playbooks](https://docs.ansible.com/ansible/latest/user_guide/index.html)
to configure your deployed host(s).

Various Ansible roles are available in the
[egi-qc/ansible-playbooks repository](https://github.com/egi-qc/ansible-playbooks)
and in the
[EGI Federation GitHub organisation](https://github.com/EGI-Federation?q=ansible-role).

> A
> [style guide for writing Ansible roles](https://github.com/EGI-Federation/ansible-style-guide)
> is providing a skeleton that you can use fore creating new roles.

## Additional resources

Additional resources are available, and can help with addressing different use
cases, or be used as a source of inspiration:

- [egi-qc/deployment-howtos](https://github.com/egi-qc/deployment-howtos):
  Deployment recipes extracted from Jenkins builds for the
  [UMD](https://go.egi.eu/umd) and [CMD](https://go.egi.eu/cmd) products
- [EGI-ILM/fedcloud-terraform](https://github.com/EGI-ILM/fedcloud-terraform):
  providing an advanced helper script allowing to interact with EGI Cloud
  Compute.
- [EGI-ILM/automated-containers](https://github.com/EGI-ILM/automated-containers):
  providing documentation for automated on-demand execution of Docker containers

## Asking for help

If you find issues please do not hesitate to [contact us](../../../support/).
