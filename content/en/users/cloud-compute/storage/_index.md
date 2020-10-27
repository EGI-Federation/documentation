---
title: "Storage"
type: docs
weight: 60
description: >
  Storage features of the EGI Cloud
---

If you are in need of more storage than the one provided within image
disk of your VMs, or need to persist data independently from the VMs
storage, you will need to use one of the solutions available as part
of the [EGI online storage service](../../online-storage/).

This page describes the Block Storage offering of the online
storage which is only accessible from VMs running on the EGI Cloud.

## Block Storage

**Block storage** provides additional storage blocks which can be
attached to a virtual machine. A storage block is a virtual disk of a
given size, which can be exposed as a virtual device in the VM. You can
think of this can of devices as a USB stick that can be plugged into the
VMs and can be used as a regular drive. You can format it with any file
system you want and mount it in your VM. Block devices are persistent,
thus they keep all the data after VM shutdown and need to be explicitly
destroyed when data is not needed anymore. Block storage disks can be
accessed only from within a VM, and only from VMs running at the same
provider where the block storage is located. Also, they can be accessed
by only one VM at the same time. As part of the IaaS service, block
storage is managed via OpenStack/OCCI APIs. There is a limit on the
number of block storage devices you can attach on a VM and there is a
limit to the maximum size of such virtual disks. These values will
depend on the particular provider and your SLA. Moreover, the disk space
is accounted for the entire block storage device, regardless how much of
it is actually used.

Block storage is created and managed via requests to specific APIs. Once
the storage is attached to a VM, it is managed as a regular disk that
can be used as any other disk from within the VM.

### Management

OpenStack providers offer block storage using their native API. Both the
CLI client or dashboard can be used. Main commands for managing volumes
are listed below:

| Command                                  | function |
| ---------------------------------------- | -------- |
| `volume create --size <size> <name>`     | create a volume of size `<size>` GBs and name `<name>` |
| `volume list`                            | list available volumes |
| `volume show <volume>`                   | show details of a given volume |
| `volume delete <volume>`                 | deletes a volume |
| `server add volume <server> <volume>`    | Attach a volume to a server |
| `server remove volume <server> <volume>` | Dettach a volume from a server |

For using the legacy OCCI interface refer to [OCCI
How-to](https://wiki.egi.eu/wiki/HOWTO11_How_to_use_the_rOCCI_Client#How_to_create_block_storage.3F).

### Using block storage from your VMs

Block Storage will appear as block devices into your VM. Usually these
devices are empty upon creation. The first time you attach them to a VM,
you will need to partition and create filesystems on the device.

You can just create a filesystem on the block device with the following
command (run this at your VM!).

{{% alert title="Danger" color="danger" %}}
Only run this command the first time you use the device, it deletes all
data!
{{% /alert %}}

``` {.console}
# mkfs.ext4 /dev/<volume device>
```

The `<volume device>` (e.g `vdb`) can be obtained with the
`openstack volume show` command

Once you have a filesystem you can mount it at the desired path:

``` {.console}
# mount /dev/<volume device> /<path>
```

With that you can access `/<path>` where all your data will be
available. Applications will not see any difference between a block
storage device and a regular disk, thus no major changes should be
required in the application logic.
