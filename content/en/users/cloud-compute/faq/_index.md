---
title: "FAQ"
type: docs
weight: 120
description: >
  Frequenlty Asked Questions
---

## Basics

### How can I get access to the cloud compute service?

There is a VO available for 6 months piloting activities that any researcher in
Europe can join. Just place an order into the
[EGI Marketplace](https://marketplace.egi.eu/31-cloud-compute).

### How can I get an OAuth2.0 token?

Authentication via CLI or API requires a valid Check-in token. The
[FedCloud Check-in client](https://aai.egi.eu/fedcloud) allows you to get one as
needed. Check the [Authentication and Authorisation](../auth) guide for more
information.

### Is OCCI still supported?

OCCI is now deprecated as API for the EGI Cloud providers using OpenStack. Some
providers still support OCCI (a list of active endpoints can be queried at
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=eu.egi.cloud.vm-management.occi&selectItemserviceType=eu.egi.cloud.vm-management.occi&ngi=&searchTerm=&production=TRUE&monitored=&certStatus=Certified&mscope%5B%5D=FedCloud&selectItemmscope%5B%5D=FedCloud&scopeMatch=all&servKeyNames=&servKeyValue=))
but it should note be used for any new developments.

Migration from rOCCI CLI to OpenStack CLI is quite straightforward, we summarize
the main commands in rOCCI and OpenStack equivalent in the table below:

<!-- markdownlint-disable line-length -->

| Action           | rOCCI                                                                                                                | OpenStack                                                                                |
| ---------------- | -------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| List images      | `occi -a list -r os_tpl`                                                                                             | `openstack image list`                                                                   |
| Describe images  | `occi -a describe -r <image_id>`                                                                                     | `openstack image show <image_id>`                                                        |
| List flavors     | `occi -a list -r resorce_tpl`                                                                                        | `openstack flavor list`                                                                  |
| Describe flavors | `occi -a describe -r <template_id>`                                                                                  | `openstack flavor show <image_id>`                                                       |
| Create VM        | `occi -a create -r compute -t occi.core.title="MyFirstVM" -M <flavor id> -M <image id> -T user_data="file://<file>"` | `openstack server create --flavor <flavor> --image <image> --user-data <file> MyFirstVM` |
| Describe VM      | `occi -a describe -r <vm id>`                                                                                        | `openstack server show <vm id>`                                                          |
| Delete VM        | `occi -a delete -r <vm id>`                                                                                          | `openstack server delete <vm id>`                                                        |
| Create volume    | `occi -a create -r storage -t occi.storage.size='num(<site in GB>)' -t occi.core.title=<storage_resource_name>`      | `openstack volume create --size <size in GB> <storage resource name>`                    |
| List volume      | `occi -a list -r storage`                                                                                            | `openstack volume list`                                                                  |
| Attach volume    | `occi -a link -r <vm_id> -j <storage_resource_id>`                                                                   | `openstack server add volume <vm id> <volume id>`                                        |
| Dettach volume   | `occi -a unlink -r <storage_link_id>`                                                                                | `openstack server remove volume <vm id> <volume id>`                                     |
| Delete volume    | `occi -a delete -r <volume id>`                                                                                      | `openstack volume delete <volume id>`                                                    |
| Attach public IP | `occi -a link -r <vm id> --link /network/public`                                                                     | `openstack server add floating ip <vm id> <ip>`                                          |

<!-- markdownlint-enable line-length -->

If you still rely on OCCI for your access, please contact us at
`support _at_ egi.eu` for support on the migration. OpenNebula sites still use
OCCI as main API, but its direct use is not recommended as the support will be
deprecated. Instead use an Orchestrator like IM for interacting with those
sites.

## Discovery

### How can I get the list of the EGI Cloud providers?

The list of certified providers is available in [GOCDB](https://goc.egi.eu). The
`egicli endpoint list` command can help you to get that list:

```shell
$ egicli endpoint list
Site                type                URL
------------------  ------------------  ------------------------------------------------
IFCA-LCG2           org.openstack.nova  https://api.cloud.ifca.es:5000/v3/
IN2P3-IRES          org.openstack.nova  https://sbgcloud.in2p3.fr:5000/v3
UA-BITP             org.openstack.nova  https://openstack.bitp.kiev.ua:5000/v3
RECAS-BARI          org.openstack.nova  https://cloud.recas.ba.infn.it:5000/v3
NCG-INGRID-PT       org.openstack.nova  https://nimbus.ncg.ingrid.pt:5000/v3
CLOUDIFIN           org.openstack.nova  https://cloud-ctrl.nipne.ro:443/v3
IISAS-GPUCloud      org.openstack.nova  https://keystone3.ui.savba.sk:5000/v3/
IISAS-FedCloud      org.openstack.nova  https://nova.ui.savba.sk:5000/v3/
UNIV-LILLE          org.openstack.nova  https://thor.univ-lille.fr:5000/v3
INFN-PADOVA-STACK   org.openstack.nova  https://egi-cloud.pd.infn.it:443/v3
CYFRONET-CLOUD      org.openstack.nova  https://api.cloud.cyfronet.pl:5000/v3/
SCAI                org.openstack.nova  https://fc.scai.fraunhofer.de:5000/v3
CESNET-MCC          org.openstack.nova  https://identity.cloud.muni.cz/v3
INFN-CATANIA-STACK  org.openstack.nova  https://stack-server.ct.infn.it:35357/v3
CESGA               org.openstack.nova  https://fedcloud-osservices.egi.cesga.es:5000/v3
100IT               org.openstack.nova  https://cloud-egi.100percentit.com:5000/v3/
```

The providers also generate dynamic information about their characteristics via
the Argo Messaging System which is easily browsable from AppDB.

### How can I choose which site to use?

Sites offer their resources to users through Virtual Organisations (VO). First,
you need to join a Virtual Organisation that matches your research interests,
see [authorisation section](../auth) on how VOs work. AppDB shows the supported
VOs and for each VO you can browse the resource providers that support it.

### How can I get information about the available VM images?

The [Application Database](https://appdb.egi.eu) contains information about the
VM images available in the EGI Cloud. Within the AppDB Cloud Marketplace, you
can look for a VM and get all the information about which VO the VM is
associated, the sites where the VM is available and the endpoints and
identifiers to use it in practice.

## Managing VMs

### The disk on my VM is full, how can I get more space?

There are several ways to increase the disk space available at the VM. The
fastest and easiest one is to use block storage, creating a new storage disk
device and attaching it to the VM. Check the [storage guide](../storage) for
more information.

### How can I keep my data after the VM is stopped?

After a VM has been stopped and unless backed up in a block storage volume, all
data in the VM is destroyed and cannot be recovered. To ensure your data will be
available after the VM is deleted, you need to use some form of persistent
storage.

### How can I assign a public IP to my VM?

Some providers do not automatically assign a public IP address to a VM during
the creation phase. In this case, you can attach a public IP by first allocating
a new public IP and then assigning it to the VM.

### How can I assign a DNS name to my VM?

If you need a domain name for your VMs, we offer a Dynamic DNS service that
allows any EGI user to create names for VMs under the _fedcloud.eu_ domain.

Just go to [EGI Cloud nsupdate](https://nsupdate.fedcloud.eu) and login with
your Check-in account. Once in, you can click on \"Add host\" to register a new
hostname in an available domain.

### What is contextualisation?

Contextualisation is the process of installing, configuring and preparing
software upon boot time on a pre-defined virtual machine image. This way, the
pre-defined images can be stored as generic and small as possible, since
customisations will take place on boot time.

Contextualisation is particularly useful for:

- Configuration not known until instantiation (e.g. data location).
- Private Information (e.g. host certs)
- Software that changes frequently or under development.

Contextualisation requires passing some data to the VMs on instantiation (the
context) and handling that context in the VM.

### How can I inject my public SSH key into the machine?

The best way to login into the virtual server is to use SSH keys. If you don\'t
have one, you need to generate it with the `ssh-keygen` command:

```shell
ssh-keygen -f fedcloud
```

This will generate two files:

- `fedcloud`, the private key. This file should never be shared
- `fedcloud.pub`, the public key. That will be sent to your VM.

To inject the public SSH key into the VM you can use the `key-name` option when
creating the VM in OpenStack. Check
[keypair management](https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/keypair.html)
option in OpenStack documentation. This key will be available for the default
configured user of the VM (e.g. `ubuntu` for Ubuntu, `centos` for CentOS).

You can also create users with keys with a contextualisation file:

```yaml
#cloud-config
users:
  - name: cloudadm
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock-passwd: true
    ssh-import-id: cloudadm
    ssh-authorized-keys:
      - <paste here the contents of your SSH key pub file>
```

{{% alert title="Warning" color="warning" %}} YAML format requires that the
spaces at the beginning of each line is respected in order to be correctly
parsed by `cloud-init`. {{% /alert %}}

### How can I use a contextualisation file?

If you have a contextualisation file, you can use it with the `--user-data`
option to `server create` in OpenStack.

```shell
openstack server create --flavor <your-flavor> --image <your image> \
          --user-data <your contextualisation file> \
          <server name>
```

{{% alert title="Note" color="info" %}} We recommend using `cloud-init` for
contextualisation. EGI images in AppDB do support `cloud-init`. Check the
[documentation](https://cloudinit.readthedocs.io/) for more information.
{{% /alert %}}

### How can I pass secrets to my VMs?

EGI Cloud endpoints use **HTTPS** so information passed to contextualise the VMs
can be assumed to be safe and only readable within your VM. However, take into
account that anyone with access to the VM may be able to access also the
contextualisation information.

{{% alert title="Warning" color="warning" %}} Take into account that anyone with
access to the VM may be able to access also the contextualisation information,
so ensure that no sensitive data like clear text passwords is used during
contextualisation. {{% /alert %}}

### How can I use ansible?

Ansible relies on ssh for accessing the servers it will configure. VMs at EGI
Cloud can be also accessed via ssh, just make sure you inject the correct public
keys in the VMs to be able to access.

If you don\'t have public IPs for all the VMs to be managed, you can also use
one as a gateway as described in the
[Ansible FAQ](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-configure-a-jump-host-to-access-servers-that-i-have-no-direct-access-to).

### How can I release resources without destroying my data?

Whenever you delete a VM, the ephemeral disks associated with it will be also
deleted so if you don't plan to use your VM for some time but still be able
to recover the data or boot your VM in the same state, you will need to use
some of the following strategies:

- Use a volume to store the data to be kept: Check the [Storage section of the
  documentation](../storage) to learn how to use volumes. If you start your VM
  from a volume, the VM can be destroyed and recreated easily. OpenStack
  docs cover how to [start a VM from a volume with CLI](https://docs.openstack.org/nova/latest/user/launch-instance-from-volume.html)
  or [using the Horizon dashboard](https://docs.openstack.org/horizon/latest/user/launch-instances.html)

- Suspend or shelve instances: Suspending a VM will release CPU and memory
  usage of a VM but keep a copy of the RAM contents so it can be restored
  later in time at the exact same state. Shelving shuts down the VM, thus RAM
  contents will be lost but disk will be kept. This releases more resources
  from the provider while still allows to easily recover the VM back to its
  previous state.

- Create snapshot of instances: a snapshot will create a new image on your
  provider that can be used to boot a new instance of the VM with the same
  disk contents. You can use this technique for creating a base template
  image that can be later re-used to start similar VMs easily.
