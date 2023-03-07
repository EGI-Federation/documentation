---
title: Block Storage
type: docs
weight: 10
aliases:
  - /users/online-storage/block-storage
description: >
  Block Storage offered by EGI Cloud providers
---

<!--
// jscpd:ignore-start
-->

## What is it?

Block storage provides **block-level storage volumes** for use within virtual
machines (VMs). Block storage volumes are raw, unformatted
[block devices](https://en.wikipedia.org/wiki/Device_file#BLOCKDEV), which can
be mounted as devices in VMs.

Block storage volumes that are attached to a VM are exposed as storage volumes
that **persist independently from the life of the VM**, and need to be
explicitly destroyed when data is not needed anymore. Users can create a file
system on top of these volumes, or use them in any way you would use a block
device (such as a hard drive).

The content of block storage volumes can be accessed only from within the VM
they are mounted to, and they can be mounted to a single VM at any given time.

The main features of block storage:

- Block storage is recommended for data that must be quickly accessible and
  requires long-term persistence.
- Block storage volumes are well suited to both database-style applications that
  rely on random reads and writes, and to throughput-intensive applications that
  perform long, continuous reads and writes.
- Users can create point-in-time snapshots of block storage volumes, which
  protect data for long-term durability, and they can be used as the starting
  point for new block storage volumes.

{{% alert title="Note" color="info" %}} Block storage volumes can can only be
mounted to VMs running at the same provider where the block storage is located.
{{% /alert %}}

{{% alert title="Note" color="info" %}} Block storage usage is accounted for the
entire block storage device, regardless how much of it is actually used.
{{% /alert %}}

{{% alert title="Important" color="warning" %}} There is a limit on the number
of block storage devices you can attach on a VM and there is a limit to the
maximum size of such virtual disks. These values will depend on the particular
provider and your SLA. {{% /alert %}}

## Manage volumes

The block storage in the EGI Cloud is offered via
[OpenStack](https://openstack.org/) deployments that implement the
[Cinder](https://docs.openstack.org/cinder/latest/) service.

Users can manage block storage using the
[OpenStack Horizon dashboard](https://docs.openstack.org/horizon/latest/user/)
of a provider, from a [command-line interface](#manage-from-the-command-line)
(CLI), or via the
[OpenStack Block Storage API](https://docs.openstack.org/api-ref/block-storage/).

## Manage from the command-line

Multiple command-line interfaces (CLIs) are available to manage block storage:

- The [OpenStack CLI](https://docs.openstack.org/python-openstackclient/latest)
- The [FedCloud Client](../../../getting-started/cli) is a high-level CLI for
  interaction with the EGI Federated Cloud (**recommended**)
- The
  [Cinder CLI](https://docs.openstack.org/python-cinderclient/latest/user/shell.html)
  has some advanced features and administrative commands that are not available
  through the OpenStack CLI

The main FedCloud commands for managing volumes are detailed below.

{{% alert title="Note" color="info" %}} For more information see the
documentation about
[volume management](https://docs.openstack.org/cinder/latest/cli/cli-manage-volumes.html).
{{% /alert %}}

### List volumes

For example, to
[list the volumes](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume.html#volume-list)
in the site IN2P3-IRES via the Pilot VO (vo.access.egi.eu), use the following
FedCloud command:

{{< tabpanex >}}

{{< tabx header="Linux / Mac" >}}

To avoid passing the site, VO, etc. each time, you can use
[FedCloud CLI environment variables](../../../getting-started/cli#environment-variables)
to set them once and reuse them with each command invocation.

```shell
$ export EGI_SITE=IN2P3-IRES
$ export EGI_VO=vo.access.egi.eu
$ fedcloud openstack volume list --site $EGI_SITE
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list
+---------------------------+--------+-----------+------+--------------------------------+
| ID                        | Name   | Status    | Size | Attached to                    |
+---------------------------+--------+-----------+------+--------------------------------+
| aa711296-5cff-46ac-bbe... | Matlab | in-use    |   50 | Attached to Moodle on /dev/vdb |
| b0abc762-a503-129d-3c1... |        | available |   30 |                                |
+---------------------------+--------+-----------+------+--------------------------------+
```

{{< /tabx >}}

{{< tabx  header="Windows" >}}

To avoid passing the site, VO, etc. each time, you can use
[FedCloud CLI environment variables](../../../getting-started/cli#environment-variables)
to set them once and reuse them with each command invocation.

```shell
> set EGI_SITE=IN2P3-IRES
> set EGI_VO=vo.access.egi.eu
> fedcloud openstack volume list --site %EGI_SITE%
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list
+---------------------------+--------+-----------+------+--------------------------------+
| ID                        | Name   | Status    | Size | Attached to                    |
+---------------------------+--------+-----------+------+--------------------------------+
| aa711296-5cff-46ac-bbe... | Matlab | in-use    |   50 | Attached to Moodle on /dev/vdb |
| b0abc762-a503-129d-3c1... |        | available |   30 |                                |
+---------------------------+--------+-----------+------+--------------------------------+
```

{{< /tabx >}}

{{< tabx  header="PowerShell" >}}

To avoid passing the site, VO, etc. each time, you can use
[FedCloud CLI environment variables](../../../getting-started/cli#environment-variables)
to set them once and reuse them with each command invocation.

```powershell
> $Env:EGI_SITE="IN2P3-IRES"
> $Env:EGI_VO="vo.access.egi.eu"
> fedcloud openstack volume list --site $Env:EGI_SITE
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list
+---------------------------+--------+-----------+------+--------------------------------+
| ID                        | Name   | Status    | Size | Attached to                    |
+---------------------------+--------+-----------+------+--------------------------------+
| aa711296-5cff-46ac-bbe... | Matlab | in-use    |   50 | Attached to Moodle on /dev/vdb |
| b0abc762-a503-129d-3c1... |        | available |   30 |                                |
+---------------------------+--------+-----------+------+--------------------------------+
```

{{< /tabx >}}

{{< /tabpanex >}}

### Create volume

To
[create a new volume](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume.html#volume-create)
use the FedCloud command below:

```shell
$ fedcloud openstack volume create --size 10 my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume create --size 10 my-volume
+---------------------+------------------------------------------------------------------+
| Field               | Value                                                            |
+---------------------+------------------------------------------------------------------+
| attachments         | []                                                               |
| availability_zone   | nova                                                             |
| bootable            | false                                                            |
| consistencygroup_id | None                                                             |
| created_at          | 2021-08-05T13:10:42.000000                                       |
| description         | None                                                             |
| encrypted           | False                                                            |
| id                  | a711296-5cff-46ac-bbe3-58e00712ee3e                              |
| multiattach         | False                                                            |
| name                | my-volume                                                        |
| properties          |                                                                  |
| replication_status  | None                                                             |
| size                | 10                                                               |
| snapshot_id         | None                                                             |
| source_volid        | None                                                             |
| status              | creating                                                         |
| type                | ceph                                                             |
| updated_at          | None                                                             |
| user_id             | 1a3ef4b64714f86ac71f1c9512345678c157a94ae1b37f167b6a663baa3b915b |
+---------------------+------------------------------------------------------------------+
```

The status of the new volume will probably be returned as `creating`. To check
if the volume finished creating, look at the
[details of the volume](#see-volume-details), or list only the newly created
volume (filter by volume name or ID):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+-----------+------+-------------+
| ID                                   | Name      | Status    | Size | Attached to |
+--------------------------------------+-----------+-----------+------+-------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | available |   10 |             |
+--------------------------------------+-----------+-----------+------+-------------+
```

When the status of the volume is `available` the volume is ready to be
[attached to a VM](#attach-volume-to-vm).

### See volume details

To
[view details of a volume](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume.html#volume-show)
use the FedCloud command below:

{{% alert title="Tip" color="info" %}} The volume can be specified either by its
ID or by its name (if it has one). {{% /alert %}}

```shell
$ fedcloud openstack volume show Matlab
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume show Matlab
+------------------------------+------------------------------------------------------------+
| Field                        | Value                                                      |
+------------------------------+------------------------------------------------------------+
| attachments                  | [{'server_id': 'a4ab00a1-d458-41a9-a091-ee707bc9357e',     |
|                              |   'attachment_id': '291111d3-f43c-494c-b64c-5c0abcda3d37', |
|                              |   'attached_at': '2021-08-05T08:50:19.000000',             |
|                              |   'host_name': 'sbgcsrv17.in2p3.fr',                       |
|                              |   'volume_id': '9a4000fb-0bcc-47e8-96fb-85a222295402',     |
|                              |   'device': '/dev/vdb',                                    |
|                              |   'id': '9a4000fb-0bcc-47e8-96fb-85a222295402'}]           |
| availability_zone            | nova                                                       |
| bootable                     | false                                                      |
| consistencygroup_id          | None                                                       |
| created_at                   | 2021-08-05T08:48:41.000000                                 |
| description                  |                                                            |
| encrypted                    | False                                                      |
| id                           | 9a4000fb-0bcc-47e8-96fb-85a222295402                       |
| multiattach                  | False                                                      |
| name                         | Matlab                                                     |
| os-vol-tenant-attr:tenant_id | 7a910xxxxae74ed9yyyy7497zzzz9499                           |
| properties                   |                                                            |
| replication_status           | None                                                       |
| size                         | 50                                                         |
| snapshot_id                  | None                                                       |
| source_volid                 | None                                                       |
| status                       | in-use                                                     |
| type                         | ceph                                                       |
| updated_at                   | 2021-08-05T08:50:20.000000                                 |
| user_id                      | babzz8c3b4cxxxx6286dacyyyy01e5a3                           |
+------------------------------+------------------------------------------------------------+
```

### Attach volume to VM

Mapping block devices to VMs is described in detail in the
[OpenStack documentation](https://docs.openstack.org/nova/latest/user/block-device-mapping.html).

To
[attach a volume to a VM](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/server.html#server-add-volume)
use the FedCloud command below:

{{% alert title="Note" color="info" %}} To be able to attach a volume to a VM,
the volume must not be attached to any VM (volume status must be `available`).
{{% /alert %}}

{{% alert title="Caution" color="warning" %}} The optional `--device` argument
to specify the device name in the VM should not be used. It does not work
properly, and will be removed in the near future. {{% /alert %}}

```shell
$ fedcloud openstack server add volume my-server my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: server add volume my-server my-volume
```

You can check that the volume got attached to the VM (and with what device name)
by either looking at the [details of the volume](#see-volume-details), the
[details of the VM](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/server.html#server-show),
or by listing only the volume in question (filter by volume name or ID):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+-----------+------+-----------------------+
| ID                                   | Name      | Status    | Size | Attached to           |
+--------------------------------------+-----------+-----------+------+-----------------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | in-use    |   10 | my-server on /dev/vdc |
+--------------------------------------+-----------+-----------+------+-----------------------+
```

When the volume status is `in-use` the volume is attached to a VM, and it can be
[used from the VM](#access-from-your-vms).

### Detach volume from VM

To
[detach a volume from a VM](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/server.html#server-remove-volume)
use the FedCloud command below:

```shell
$ fedcloud openstack server remove volume my-server my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: server remove volume my-server my-volume
```

You can check that the volume got detached by either looking at the
[details of the volume](#see-volume-details), the
[details of the VM](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/server.html#server-show),
or by listing only the volume in question (filter by volume name or ID):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+-----------+------+-------------+
| ID                                   | Name      | Status    | Size | Attached to |
+--------------------------------------+-----------+-----------+------+-------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | available |   10 |             |
+--------------------------------------+-----------+-----------+------+-------------+
```

When the volume status is `available` the volume is not attached to any VM.

### Resize volume

To
[resize a volume](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume.html#volume-set)
set its `size` property to the desired size. For example, if there is a volume
named `my-volume` with a size of 10GB, it can be resized using the FedCloud
command below:

{{% alert title="Tip" color="info" %}} Other volume properties can be altered in
the same way. {{% /alert %}}

{{% alert title="Note" color="info" %}} To be able to resize a volume, the
volume must not be attached to any VM (volume status must be `available`),
unless the volume driver supports
[in-use extend](https://docs.openstack.org/cinder/latest/cli/cli-manage-volumes.html#extend-attached-volume).
{{% /alert %}}

```shell
$ fedcloud openstack volume set --size 20 my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume set --size 20 my-volume
```

You can check that the volume got resized by either looking at the
[details of the volume](#see-volume-details), or by listing only the volume in
question (filter by volume name or ID):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+-----------+------+-------------+
| ID                                   | Name      | Status    | Size | Attached to |
+--------------------------------------+-----------+-----------+------+-------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | available |   20 |             |
+--------------------------------------+-----------+-----------+------+-------------+
```

### Snapshot a volume

Users can create snapshots of a volume that can later be used to create other
volumes or to rollback to a precedent point in time. **Volume snapshots are
pointers in the read-write history of a volume**.

To
[take a snapshot](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-snapshot.html#volume-snapshot-create)
of a volume, use the FedCloud command below:

{{% alert title="Tip" color="info" %}} See also the documentation about the
other
[snapshot management commands](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-snapshot.html).
{{% /alert %}}

{{% alert title="Note" color="info" %}} To be able to create a snapshot of a
volume, the volume must not be attached to any VM (volume status must be
`available`). To create a snapshot while the volume is attached to a VM, use the
`--force` command flag, but be aware that there may be inconsistencies if the
VM’s OS is not aware of the snapshot being taken. {{% /alert %}}

```shell
$ fedcloud openstack volume snapshot create --volume my-volume my-snapshot --force
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume snapshot create --volume my-volume my-snapshot
+-------------+--------------------------------------+
| Field       | Value                                |
+-------------+--------------------------------------+
| created_at  | 2021-08-06T16:08:37.631226           |
| description | None                                 |
| id          | 15149b42-032f-4cec-b6f3-41aa5c958081 |
| name        | my-snapshot                          |
| properties  |                                      |
| size        | 10                                   |
| status      | creating                             |
| updated_at  | None                                 |
| volume_id   | aa711296-5cff-46ac-bbe3-58e0712ee3e9 |
+-------------+--------------------------------------+
```

The status of the snapshot will probably be returned as `creating`. To check if
the snapshot is ready, look at the
[details of the snapshot](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-snapshot.html#volume-snapshot-show),
or list only the newly created snapshot (filter by snapshot name or ID):

```shell
$ fedcloud openstack volume snapshot list --name my-snapshot
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume snapshot list --name my-snapshot
+--------------------------------------+-------------+-------------+-----------+------+
| ID                                   | Name        | Description | Status    | Size |
+--------------------------------------+-------------+-------------+-----------+------+
| 15149b42-032f-4cec-b6f3-41aa5c958081 | my-snapshot | None        | available |   10 |
+--------------------------------------+-------------+-------------+-----------+------+
```

When the status of the snapshot is `available` the snapshot is ready, and can be
used to create new volumes or to restore the source volume to the point-in-time
when the snapshot was taken.

### Backup a volume

Users can also create backups of a volume, but backups can only be used later to
create or replace other volumes. A **volume backup is a copy of a volume** saved
to cold storage, which is cheaper than the performant storage used for volumes
and snapshots.

To
[make a backup](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-snapshot.html#volume-backup-create)
of a volume, use the FedCloud command below:

{{% alert title="Tip" color="info" %}} See also the documentation of the other
[backup management commands](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-backup.html).
{{% /alert %}}

{{% alert title="Note" color="info" %}} Not all OpenStack deployments support
volume backups. {{% /alert %}}

{{% alert title="Note" color="info" %}} Backups use as much storage as the
source volume, albeit in a cheaper storage layer. This means backups take a long
time to create (~4h for 500GB), and the space is accounted for the same way as
for regular volumes (the entire size of the backed up volume, regardless of how
much of the volume space is actually used). Thus backups should be deleted when
no longer needed. {{% /alert %}}

{{% alert title="Note" color="info" %}} To be able to make a backup of a volume,
the volume must not be attached to any VM (volume status must be `available`).
To make a backup while the volume is attached to a VM, use the `--force` command
flag, but be aware that there may be inconsistencies if the VM’s OS is not aware
of the backup being taken. {{% /alert %}}

```shell
$ fedcloud openstack volume backup create --name my-backup my-volume --force
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume backup create --name my-backup my-volume
+-------------+--------------------------------------+
| Field       | Value                                |
+-------------+--------------------------------------+
| created_at  | 2021-08-06T16:08:37.631226           |
| description | None                                 |
| id          | 158bcb42-032f-4cec-b6f3-890a5c958081 |
| name        | my-backup                            |
| properties  |                                      |
| size        | 10                                   |
| status      | creating                             |
| updated_at  | None                                 |
| volume_id   | aa711296-5cff-46ac-bbe3-58e0712ee3e9 |
+-------------+--------------------------------------+
```

The status of the backup will probably be returned as `creating`. To check if
the backup has finished, look at the
[details of the backup](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume-snapshot.html#volume-backup-show),
or list only the newly created backup (filter by backup name or ID):

```shell
$ fedcloud openstack volume backup list --name my-backup
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume backup list --name my-backup
+--------------------------------------+-----------+-------------+-----------+------+
| ID                                   | Name      | Description | Status    | Size |
+--------------------------------------+-----------+-------------+-----------+------+
| 158bcb42-032f-4cec-b6f3-890a5c958081 | my-backup | None        | available |   10 |
+--------------------------------------+-----------+-------------+-----------+------+
```

When the status of the backup is `available` the backup operation is complete.

### Delete volume

To
[delete a volume](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/volume.html#volume-delete)
use the following FedCloud command:

{{% alert title="Note" color="info" %}} To be able to delete a volume, the
volume must not be attached to any VM (volume status must be `available`).
{{% /alert %}}

```shell
$ fedcloud openstack volume delete my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume delete my-volume
```

This starts deletion of the specified volume (the volume status changes to
`deleting`):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+----------+------+-------------+
| ID                                   | Name      | Status   | Size | Attached to |
+--------------------------------------+-----------+----------+------+-------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | deleting |   10 |             |
+--------------------------------------+-----------+----------+------+-------------+
```

Once deletion of the specified volume is complete, it will no longer show up in
the list of volumes.

## Access from your VMs

<!-- markdownlint-disable no-inline-html -->
<!-- TODO Move this under Tutorials -->

Block storage volumes attached to a VM will appear as a
[block device](https://en.wikipedia.org/wiki/Device_file#BLOCKDEV) in the VM.

To find out the device name that got assigned to a volume when it was attached
to a VM, look at the [details of the volume](#see-volume-details), or list only
the volume in question (filter by volume name or ID):

```shell
$ fedcloud openstack volume list --name my-volume
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list --name my-volume
+--------------------------------------+-----------+--------+------+-----------------------+
| ID                                   | Name      | Status | Size | Attached to           |
+--------------------------------------+-----------+--------+------+-----------------------+
| aa711296-5cff-46ac-bbe3-58e00712ee3e | my-volume | in-use |   10 | my-server on /dev/vdb |
+--------------------------------------+-----------+--------+------+-----------------------+
```

In this example the device name is `/dev/vdb`. To validate this, run the
following command in the VM:

```shell
$ lsblk
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    252:0    0  20G  0 disk
└─vda1 252:1    0  20G  0 part /
vdb    252:16   0  10G  0 disk
```

Usually these devices are empty upon creation. The first time you attach them to
a VM, you will need to partition the device and create filesystem(s) on it, by
running the following command in the VM:

{{% alert title="Tip" color="info" %}} Using a file system volume label is
useful to avoid the need to find the out the device name, especially when
multiple block storage volumes are attached to a VM. It is recommended to use a
file system volume label in the VM that is the same as the name of the block
storage volume. {{% /alert %}}

{{% alert title="Tip" color="info" %}} The filesystem type can be one supported
by the Linux distribution in the VM, but `xfs` and `ext4` are the most widely
used. {{% /alert %}}

{{% alert title="Caution" color="danger" %}} Only run this command the first
time you use the device, as it deletes all data! Make sure you use the correct
device name, otherwise you will destroy data on other devices! {{% /alert %}}

```shell
$ sudo mkfs.ext4 -L my-volume /dev/vdb
```

Once you created a filesystem on the device, you can mount it at any desired
path by running the following command in the VM:

```shell
$ sudo mount /dev/vdb1 /<path>
```

Continuing with the example above, if we check again the block devices by
running the following command in the VM:

```shell
$ lsblk
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vda    252:0    0  20G  0 disk
└─vda1 252:1    0  20G  0 part /
vdb    252:16   0  10G  0 disk
└─vdb1 252:1    0  10G  0 part /<path>
```

If non-root users should be able to access the mounted volume similar to the way
e.g. `/tmp` is accessible, set the sticky bit on the mount point, with this
command in the VM:

```shell
$ sudo chmod +t /<path>
```

If the desired behaviour is to mount the file system automatically on VM
restart, add it to `/etc/fstab`. Using the `LABEL` parameter will ensure the
correct volume is chosen if multiple volumes are attached:

`LABEL=my-volume /<path> ext4 noatime,nodiratime,user_xattr,nofail 0 0`

{{% alert title="Note" color="info" %}} The use of option `nofail` is
recommended in order to skip (and not block on) mounting the file system volume
if it is unavailable, e.g. in case of network issues. Remove this option from
the _fstab_ line if you want the VM to block the boot process if the volume is
unavailable. {{% /alert %}}

{{% alert title="Note" color="info" %}} The use of option `nobarrier` is not
recommended as volumes are accessed via a cache, and ignoring the correct
ordering of journal commits may result in a corrupted file system in case of a
hardware problem. {{% /alert %}}

With that you can access `/<path>` inside the VM, where all data stored on the
volume will be available. Applications will not see any difference between a
block storage device and a regular disk, thus no major changes should be
required in the application logic.

## Storage Encryption

This section describes the usage of the tool
[cryptsetup](https://gitlab.com/cryptsetup/cryptsetup) to enable the permanent
encryption of the data stored in the disk. The tool is available in standard
linux distributions, and for this guide we assume the installation in an Ubuntu
distribution.

```shell
$ sudo su -
$ apt -y install cryptsetup
```

To encrypt the disk, it must be first initialized correctly. In the example
below, the disk named `/dev/vdb` is first filled with random data and then
initialized using the cryptsetup luksFormat command below. This first step can
be quite long.

```shell
$ dd if=/dev/urandom of=/dev/vdb bs=4k
$ cryptsetup -v --cipher aes-xts-plain64 --key-size 512 --hash sha512 \
    --iter-time 5000 --use-random luksFormat /dev/vdb
```

If this last command slows down or even blocks with the following message:

```shell
System is out of entropy while generating volume key.
Please move mouse or type some text in another window to gather some random events.
Generating key (0% done).
```

you can make the `cryptsetup luksFormat` command running faster by first
installing the `haveged` program in your virtual machine.

The following command verifies that the disk is now of type LUKS:

```shell
$ cryptsetup luksDump /dev/vdb
LUKS header information for /dev/vdb

Version:        1
Cipher name:    aes
Cipher mode:    xts-plain64
Hash spec:      sha512
Payload offset: 4096
MK bits:        512
MK digest:      c4 f7 4b 02 2a 3f 12 c1 2c ba e5 c9 d2 45 9a cd 89 20 6c 73
MK salt:        98 58 3e f3 f6 88 99 ea 2a f3 cf 71 a0 0d e5 8b
                d5 76 64 cb d2 5c 9b d1 8a d3 1d 18 0e 04 7a eb
MK iterations:  81250
UUID:           c216d954-199e-4eab-a167-a3587bd41cb3

Key Slot 0: ENABLED
    Iterations:             323227
    Salt:                   a0 45 3e 98 fa cf 60 74 c6 09 3d 54 97 89 be 65
                            5b 96 7c 1c 39 26 47 b4 8b 0e c1 3a c9 94 83 c2
    Key material offset:    8
    AF stripes:             4000
Key Slot 1: DISABLED
Key Slot 2: DISABLED
Key Slot 3: DISABLED
Key Slot 4: DISABLED
Key Slot 5: DISABLED
Key Slot 6: DISABLED
Key Slot 7: DISABLED
```

The disk is now ready for use. The first time you use it, you must perform the
following steps:

Step 1: Open the encrypted disk with the `cryptsetup luksOpen` command. The name
`storage1` is only indicative, you can choose what you want:

```shell
$ cryptsetup luksOpen /dev/vdb storage1
```

Step 2: Create a filesystem on disk:

```shell
$ mkfs.ext4 /dev/mapper/storage1
```

Step 3: Create the disk mount point:

```shell
$ mkdir /storage1
```

Step 4: Mount the disk:

```shell
$ mount -t ext4 /dev/mapper/storage1 /storage1
```

Step 5: Check available space (this may be slightly different from what was
entered during the `openstack volume create` command):

```shell
$ df -h /storage1
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/storage1  2.0G  6.0M  1.9G   1% /storage1
```

Once the disk is operational, steps 2 and 3 are no longer necessary.

You can now send files (for example `DATA.dat`) from your personal computer to
your virtual machine in a secure way, for example with `scp`:

```shell
$ scp -i ${HOME}/.ssh/cloudkey DATA.dat ubuntu@134.158.151.224:/storage1
DATA.dat                               100%   82     0.1KB/s   00:00
```

When you are done with your work on the disk, you can remove it cleanly with the
following commands:

```shell
$ umount /storage1
$ cryptsetup close storage1
```

For subsequent uses of the persistent disk, there will be no need to perform
all these operations, only the following are necessary:

```shell
$ cryptsetup luksOpen /dev/vdb storage1
$ mkdir -p /storage1
$ mount -t ext4 /dev/mapper/storage1 /storage1
```

Note that directory `/storage1` will be created only if it does not already
exist.

## Access via EGI Data Transfer

[EGI Data Transfer](../../../data/management/data-transfer) allows you to move
any type of data files asynchronously from one storage to another. If you want
to copy data from/to one VM running on the EGI cloud, you will need to run a
compatible server (Webdav/HTTPS, GridFTP, xrootd, SRM, S3, GCloud) that can
interact with the FTS3 software.

An easy way to provide a GridFTP server on your VM is to use the
[gridftp-le ready2go docker stack](https://github.com/cern-fts/ready2go/tree/master/gridftp-le)
for deploying a GridFTP Docker Container with certificates from Let's Encrypt.
Take into account:

- Security groups for the VM must allow ports 80, 2811 and the 50000-50200
  range.
- The VM must have a valid DNS entry (you can use
  [Dynamic DNS](https://nsupdate.fedcloud.eu) in FedCloud to get one)
- The default setup uses `/srv` as path to expose and maps users to the `nobody`
  user. Make sure that `nobody` is able to read (and write if needed) on that
  location or set the mapping to the appropriate users.
- The Let's Encrypt certificates may not be accepted by some of the EGI
  infrastructure endpoints, you may want to consider using IGTF certificates
  instead. Check your CA for instructions on how to get those.
- You can add direct mappings for specific DNs by adding a
  `/etc/localgridmap.conf` file in your running container. See the example below
  to map the
  `/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Enol Fernandez del Castillo`
  DN to `nobody`. You can add as many lines as needed:

  ```plaintext
  "/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Enol Fernandez del Castillo" nobody
  ```

- You need to specify the environment variables in the `docker-compose.yml` file
  for obtaining the Let's Encrypt certificate. An extra variable
  `GLOBUS_HOSTNAME` must be also set:

  ```yaml
  environment:
    - TESTCERT
    - EMAIL=youremail@domain.com
    - DOMAIN=mygridftp.example.com
    - GLOBUS_HOSTNAME=mygridftp.example.com
  ```

- If you are running on a site with MTU smaller than 1500 (e.g. CESNET-MCC),
  make sure that you set the MTU to a value smaller than the interface MTU(you
  can check this with `ip addr`). In your `docker-compose.yml`, add:

  ```yaml
  networks:
    default:
      driver: bridge
      driver_opts:
        com.docker.network.driver.mtu: 1434
  ```

<!--
// jscpd:ignore-end
-->
