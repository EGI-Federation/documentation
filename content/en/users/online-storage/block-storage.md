---
title: "Block Storage"
type: docs
weight: 60
description: >
  Block storage offered by EGI Cloud providers
---

If you are in need of more storage than the one provided within image disk of
your VMs, or need to persist data independently from the VMs storage, you will
need to use one of the solutions available as part of the
[EGI online storage service](../../online-storage/).

This page describes the Block Storage offering of the online storage which is
only accessible from VMs running on the EGI Cloud.

## Block Storage

**Block storage** provides additional storage blocks which can be attached to a
virtual machine. A storage block is a virtual disk of a given size, which can be
exposed as a virtual device in the VM. You can think of this can of devices as a
USB stick that can be plugged into the VMs and can be used as a regular drive.
You can format it with any file system you want and mount it in your VM. Block
devices are persistent, thus they keep all the data after VM shutdown and need
to be explicitly destroyed when data is not needed anymore. Block storage disks
can be accessed only from within a VM, and only from VMs running at the same
provider where the block storage is located. Also, they can be accessed by only
one VM at the same time. As part of the IaaS service, block storage is managed
via OpenStack/OCCI APIs. There is a limit on the number of block storage devices
you can attach on a VM and there is a limit to the maximum size of such virtual
disks. These values will depend on the particular provider and your SLA.
Moreover, the disk space is accounted for the entire block storage device,
regardless how much of it is actually used.

Block storage is created and managed via requests to specific APIs. Once the
storage is attached to a VM, it is managed as a regular disk that can be used as
any other disk from within the VM.

### Management

OpenStack providers offer block storage using their native API. Both the CLI
client or dashboard can be used. Main commands for managing volumes are listed
below:

<!-- markdownlint-disable line-length -->

| Command                                  | function                                               |
| ---------------------------------------- | ------------------------------------------------------ |
| `volume create --size <size> <name>`     | create a volume of size `<size>` GBs and name `<name>` |
| `volume list`                            | list available volumes                                 |
| `volume show <volume>`                   | show details of a given volume                         |
| `volume delete <volume>`                 | deletes a volume                                       |
| `server add volume <server> <volume>`    | Attach a volume to a server                            |
| `server remove volume <server> <volume>` | Dettach a volume from a server                         |

<!-- markdownlint-enable line-length -->

For using the legacy OCCI interface refer to
[OCCI How-to](https://wiki.egi.eu/wiki/HOWTO11_How_to_use_the_rOCCI_Client#How_to_create_block_storage.3F).

### Using block storage from your VMs

Block Storage will appear as block devices into your VM. Usually these devices
are empty upon creation. The first time you attach them to a VM, you will need
to partition and create filesystems on the device.

You can just create a filesystem on the block device with the following command
(run this at your VM!).

{{% alert title="Danger" color="danger" %}} Only run this command the first time
you use the device, it deletes all data! {{% /alert %}}

```shell
# mkfs.ext4 /dev/<volume device>
```

The `<volume device>` (e.g `vdb`) can be obtained with the
`openstack volume show` command

Once you have a filesystem you can mount it at the desired path:

```shell
# mount /dev/<volume device> /<path>
```

With that you can access `/<path>` where all your data will be available.
Applications will not see any difference between a block storage device and a
regular disk, thus no major changes should be required in the application logic.

## Exposing storage to EGI File Transfer service

The [File Transfer service](../../data-transfer) allows you to move any type of
data files asynchronously from one storage to another. If you want to copy data
from/to one VM running on the EGI cloud, you will need to run a compatible
server (Webdav/https, GridFTP, xrootd, SRM, S3, GCloud) that can interact with
the FTS3 software.

An easy way to provide a GridFTP server on your VM is to use the
[gridftp-le ready2go docker stack](https://github.com/cern-fts/ready2go/tree/master/gridftp-le)
for deploying a GridFTP Docker Container with certificates from Let's Encrypt.
Take into account:

- Security groups for the VM must allow ports 80, 2811 and the 50000-50200
  range.
- The VM must have a valid DNS entry (you can use
  [FedCloud's Dynamic DNS](https://nsupdate.fedcloud.eu) for getting one)
- The default setup uses `/srv` as path to expose and maps users to the `nobody`
  user. Make sure that `nobody` is able to read (and write if needed) on that
  location or set the mapping to the appropriate users.
- The Let's Encrypt certificates may not be accepted by some the EGI
  infrastructure endpoints, you may want to consider using IGTF certificates
  instead. Check your CA for instructions on how to get those.
- You can add direct mappings for specific DNs by adding a
  `/etc/localgridmap.conf` file in your running container. See the example below
  to map the
  `/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Enol Fernandez del Castillo`
  DN to `nobody`. You can add as many lines as needed:

  <!-- markdownlint-disable line-length -->

  ```plaintext
  "/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Enol Fernandez del Castillo" nobody
  ```

  <!-- markdownlint-enable line-length -->

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
