---
title: Automating Deployments
type: docs
weight: 60
description: >
  Use Infrastrucure-as-Code in the EGI Cloud
---

The [OpenStack](../../../getting-started/openstack) sites in the EGI Cloud that
provide compute resources to run virtual machines (VMs) allow nearly everything
to be done via an Application Programming Interface (API) or a
[command-line interface](../../../getting-started/cli) (CLI). This means that
repetitive tasks or complex architectures can be turned into shell scripts.

But creating VMs happens so often in the EGI Cloud that tools were developed to
capture the provisioning of these VMs, and allow users to recreate them in a
flash, in a **deterministic** and **repeatable** way, using an
Infrastructure-as-Code (IaC) approach.

Automating this activity will help researchers to:

- Not forget important configuration (e.g. the size and type of the hardware
  resources needed).
- Ensure the same steps are performed, in the same order (e.g. making sure the
  correct datasets are attached to each VM).
- Easily share scientific pipelines with collaborators.
- Make scientific applications cloud agnostic.

## Infrastructure Manager

[Infrastructure Manager](https://im.egi.eu) is the recommended orchestration
service to manage virtual infrastructures in EGI Cloud. Check the
[service documentation](../../orchestration/im/) for more information

## Terraform

[Terraform](https://terraform.io/) supports EGI Cloud OpenStack providers by
using valid access tokens for Keystone. For using this, just configure your
provider as usual in Terraform, but do not include user/password information.
Instead, use the [FedCloud client](../../../getting-started/cli) client to
configure environment variables as follows:

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

## Pulumi

[Pulumi](https://www.pulumi.com/) provides Infrastructure as Code using
different programming languages. Similarly to [Terraform](#terraform),
it can use credentials obtained out of band to interact with the OpenStack
services. Check the documentation of the
[Pulumi OpenStack Provider](https://www.pulumi.com/registry/packages/openstack/)
for details on how to interact with sites.

You can set the `OS_AUTH` and `OS_TOKEN` variables with the
[FedCloud client](../../../getting-started/cli):

```shell
# export OS_AUTH_URL and OS_PROJECT_ID with
$ eval "$(fedcloud site show-project-id --site <NAME_OF_SITE> --vo <NAME_OF_VO>)"

# now get a valid token
$ export OS_TOKEN=$(fedcloud openstack --site <NAME_OF_SITE> --vo <NAME_OF_VO> \
                    token issue -c id -f value)
```

### Example: creating a VM with Pulumi and Python

You can follow these steps for getting started with Pulumi and EGI Cloud. It
assumes you have a working installation of Pulumi and Python. We will be using
IN2P3-IRES site with `vo.access.egi.eu` VO:

1. Create new project

   ```shell
   $ mkdir egi-pulumi
   $ cd egi-pulumi
   $ pulumi new openstack-python
   ```

   The `pulumi new` command will interactively initialize a new project, once
   done you will have several configuration files and a `___main__.py` file
   with some boilerplate code.

2. Edit `__main__.py` to create a VM using EGI's alma 9 image, a flavor with
   2 cores and set the right network:

   ``` python
   """An OpenStack Python Pulumi program"""

   import pulumi
   from pulumi_openstack import compute, images

   # Create an OpenStack resource (Compute Instance)

   # Get image EGI alma:9
   alma = images.get_image(
       most_recent=True,
       properties={
           "os_distro": "alma",
           "os_version": "9",
           "image_list": "egi_vm_images",
       },
   )

   flavor = compute.get_flavor(vcpus=2)

   # Create instance
   # Network name vary for every provider, in this case using
   # the name of the network for vo.access.egi.eu VO at IN2P3-IRES
   # It can be discovered by login into the dashboard or with:
   # `fedcloud openstack --site IN2P3-IRES --vo vo.access.egi.eu network list`
   instance = compute.Instance(
       "pulumi-test",
       flavor_id=flavor.id,
       networks=[
           {
               "name": "egi-access-net",
           }
       ],
       image_id=alma.id,
   )

   # Export the IP of the instance
   pulumi.export("instance_ip", instance.access_ip_v4)
   ```

3. Get your environment ready for interaction with the site:

   ```shell
   $ eval "$(fedcloud site show-project-id --site IN2P3-IRES --vo vo.access.egi.eu)"
   $ export OS_TOKEN=$(fedcloud openstack --site IN2P3-IRES \
                        --vo vo.access.egi.eu token issue -c id -f value)
   ```

4. Deploy by running `pulumi up`:

   ```shell
   $ pulumi up
   Enter your passphrase to unlock config/secrets
       (set PULUMI_CONFIG_PASSPHRASE or PULUMI_CONFIG_PASSPHRASE_FILE to remember):
   Enter your passphrase to unlock config/secrets
   Previewing update (dev):
        Type                           Name            Plan       Info
    +   pulumi:pulumi:Stack            egi-pulumi-dev  create     1 warning
    +   └─ openstack:compute:Instance  pulumi-test     create

   Diagnostics:
     pulumi:pulumi:Stack (egi-pulumi-dev):
       warning: provider config warning: Users not using loadbalancer resources can ignore this message. Support for neutron-lbaas will be removed on next major release. Octavia will be the only supported method for loadbalancer resources. Users using octavia will have to remove 'use_octavia' option from the provider configuration block. Users using neutron-lbaas will have to migrate/upgrade to octavia.

   Outputs:
       instance_ip: [unknown]

   Resources:
       + 2 to create

   Do you want to perform this update? yes

   Updating (dev):
        Type                           Name            Status            Info
    +   pulumi:pulumi:Stack            egi-pulumi-dev  created (15s)     1 warning
    +   └─ openstack:compute:Instance  pulumi-test     created (13s)

   Diagnostics:
     pulumi:pulumi:Stack (egi-pulumi-dev):
       warning: provider config warning: Users not using loadbalancer resources can ignore this message. Support for neutron-lbaas will be removed on next major release. Octavia will be the only supported method for loadbalancer resources. Users using octavia will have to remove 'use_octavia' option from the provider configuration block. Users using neutron-lbaas will have to migrate/upgrade to octavia.

   Outputs:
       instance_ip: "172.16.21.167"

   Resources:
       + 2 created

   Duration: 17s
   ```

4. Clean up the resources by using `pulumi destroy`

   ```shell
   $ pulumi destroy
   Enter your passphrase to unlock config/secrets
       (set PULUMI_CONFIG_PASSPHRASE or PULUMI_CONFIG_PASSPHRASE_FILE to remember):
   Enter your passphrase to unlock config/secrets
   Previewing destroy (dev):
        Type                           Name            Plan
    -   pulumi:pulumi:Stack            egi-pulumi-dev  delete
    -   └─ openstack:compute:Instance  pulumi-test     delete

   Outputs:
     - instance_ip: "172.16.21.167"

   Resources:
       - 2 to delete

   Do you want to perform this destroy? yes
   Destroying (dev):
        Type                           Name            Status
    -   pulumi:pulumi:Stack            egi-pulumi-dev  deleted (0.00s)
    -   └─ openstack:compute:Instance  pulumi-test     deleted (11s)

   Outputs:
     - instance_ip: "172.16.21.167"

   Resources:
       - 2 deleted

   Duration: 12s

   The resources in the stack have been deleted, but the history and configuration associated with the stack are still maintained.
   If you want to remove the stack completely, run `pulumi stack rm dev`.
   ```

