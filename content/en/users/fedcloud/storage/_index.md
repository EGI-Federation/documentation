---
title: "Storage"
type: docs
weight: 60
description: >
  Storage features of the EGI Cloud
---

This page aims to give a brief description of the storage features
provided by the EGI Cloud and a basic tutorial on how to use and
integrate them into your application.

If you are in need of more storage than the one provided within image
disk of your VMs, or need to persist data independently from the VMs
storage, you will need to use one of the solutions available on the [EGI
service catalogue](https://www.egi.eu/services/).

There are two kind of storage services, Block and Object. Both of them
have their own set of advantages and disadvantages

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

**Object storage** is a standalone service that stores data as sets of
individual objects organized within containers (e.g. folders). Each
object has its own URL, which can be used to access the resource, to
share the file with other people, and to setup custom metadata and
access control lists. These objects are accessed and managed via a REST
API ([OpenStack
SWIFT](https://docs.openstack.org/api-ref/object-store/index.html)).
Differently from the block storage, there is virtually no limit to the
amount of data you can store, only the space used is accounted, you can
access the data from any location (from any VM running at any EGI
provider or even from other cloud providers or from your own
laptop/browser), you can expose the data via external portals (using
HTTP as transport protocols), you can set access control lists per
container and even make the data publicly available. On the other hand,
data is accessed via a API requests, thus integration with existing
applications may require a change to the application logic.

A summary of the main differences between Block and Object Storage is
reported in the following table.

| Access | Sharing | Accounting | Usage |
| ------ | ------- | ---------- | ----- |
| **Block Storage** | only from within a VM only at the same site the VM is located | Not possible | for the entire block | POSIX access, use as local disk |
| **Object Storage** | from any device connected to the internet | Possible | only for the data stored | via HTTP requests to server |

According to your application needs, you may select one technology over
the other. In general, block storage is a good and simple solution for
temporary data and data which you do not need to share beside the single
application running on a single VM. If you need to have your data
exposed within portals or shared between different steps of your
processing workflow, it is usually best to use the object storage.

## Block Storage

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
How-to](https://wiki.egi.eu/wiki/HOWTO11_How_to_use_the_rOCCI_Client).

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

## Object Storage

{{% alert title="Note" color="info" %}}
We are currently re-evaluating the object storage capabilities of EGI
Cloud and will update this documentation as soon as possible.
{{% /alert %}}

OpenStack SWIFT offers a RESTful API to manage your storage. As with
block storage you can manage it via the OpenStack CLI or web dashboard.

Available SWIFT providers resources can be discovered in
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=org.openstack.swift&selectItemserviceType=org.openstack.swift&ngi=&searchTerm=&production=TRUE&monitored=TRUE&certStatus=Certified&scopeMatch=all&servKeyNames=&servKeyValue=).
For accessing the endpoint check the `URL` of the specific provider.

### Usage from your application

Integration of the block storage within your application will require a
client or set of libraries to be integrated within your application that
perform the REST operations on the service endpoints. Check the complete
[OpenStack object store
API](https://docs.openstack.org/api-ref/object-store/) for more
information.
