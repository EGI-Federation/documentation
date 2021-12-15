---
title: "Object Storage"
linkTitle: "Object Storage"
type: docs
weight: 30
description: >
  Object Storage offered by EGI Cloud providers
---
<!--
// jscpd:ignore-start
-->

## What is it?

Object storage is a standalone service that **stores data as individual
objects, organized into containers**. It is a highly scalable, reliable,
fast, and inexpensive data storage. It has a simple web services interface
that can be used to store and retrieve any amount of data, at any time,
from anywhere on the web.

The main features of object storage:

- Storage containers and objects have unique URLs, which can be used to access,
  manage, and share them.
- Data can be accessed from anywhere, using standard HTTP requests to a REST
  API (e.g. VMs running in the EGI Cloud or in other cloud provider's cloud,
  from any browser/laptop, etc.)
- Access can be public or can be restricted using access control lists.
- There is virtually no limit to the amount of data you can store, only the
  space used is accounted for.

## Concepts

To use object storage effectively, you need to understand the following key
concepts and terminology:

### Storage containers

Storage containers (aka buckets) are the fundamental holders of data. Every
object is stored in a storage container. You can store any number of objects in
a storage container.

Storage containers have an unique name and act as the root folders of the
storage space.

Each storage container has a unique URL (that includes the name) by which
anyone can refer to it.

### Objects

Objects are the fundamental entities stored in object storage. Objects consist
of object data and metadata. The data portion is opaque to object storage. The
metadata is a set of name-value pairs that describe the object. These include
some default metadata, such as the date last modified, and standard HTTP
metadata, such as `Content-Type`. You can also specify custom metadata at the
time the object is stored.

An object is uniquely identified within a storage container by a key (name)
and a version.

Each object has a unique URL, based on the storage container's URL (that
includes the key, and optionally the version) by which anyone can refer to it.

### Permissions

Storage containers and objects can be shared by sharing their URLs.
However, access to a storage container or to an object is controlled by
access control lists (ACLs). When a request is received against a resource,
object storage checks the corresponding ACL to verify that the requester has
the necessary access permissions.

{{% alert title="Note" color="info" %}} It is possible to set permissions so
that the storage container or object can be accessed publicly.
{{% /alert %}}

## Usage from your application

The object storage in the EGI Cloud is offered via
[OpenStack](https://openstack.org/) deployments that implement the
[Swift](https://docs.openstack.org/swift/latest/) service.

Users can manage object storage using the
[OpenStack Horizon dashboard](https://docs.openstack.org/horizon/latest/user/)
of a provider or from the [command-line](#access-from-the-command-line)
(CLI). More advanced usage include access via the
[S3 protocol](#access-via-the-s3-protocol), via the
[OpenStack Object Store API](https://docs.openstack.org/api-ref/object-store/),
or using the [EGI Data Transfer service](#access-via-egi-data-transfer).

{{% alert title="Note" color="info" %}} Available object storage resources
can be discovered in the
[Configuration Database](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=org.openstack.swift&selectItemserviceType=org.openstack.swift&ngi=&searchTerm=&production=TRUE&monitored=TRUE&certStatus=Certified&scopeMatch=all&servKeyNames=&servKeyValue=)
(GOCDB).
{{% /alert %}}

## Access from the command-line

Multiple command-line interfaces (CLIs) are available to manage object
storage:

- The [OpenStack CLI](https://docs.openstack.org/python-openstackclient/latest)
- The [FedCloud Client](../../cloud-compute/openstack) is a high-level CLI for
  interaction with the EGI Federated Cloud (**recommended**)
- The [Swift CLI](https://docs.openstack.org/mitaka/cli-reference/swift.html)
  has some advanced features that are not available through the OpenStack CLI
- The [Davix Client](https://davix.web.cern.ch), developed at CERN for RHEL and
  Debian environments, is another alternative for working with S3-compatible
  object storage

### Access with the FedCloud CLI

The main FedCloud commands for managing storage containers and storage objects are
described below.

{{% alert title="Note" color="info" %}} See
[here](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html)
for documentation on all storage container-related commands, and
[here](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html)
for all object-related commands.
{{% /alert %}}

#### List storage containers

For example, to access to the SWIFT endpoint at IFCA-LCG2 via the
Pilot VO (vo.access.egi.eu), and
[list the available storage containers](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html#container-list),
use the FedCloud command below:

{{< tabpanex >}}
{{< tabx header="Linux / Mac" >}}

  To avoid passing the site, VO, etc. each time, you can use
  [FedCloud CLI environment variables](https://fedcloudclient.fedcloud.eu/usage.html#environment-variables)
  to set them once and reuse them with each command invocation.

  ```shell
  $ export EGI_SITE=IFCA-LCG2
  $ export EGI_VO=vo.access.egi.eu
  $ fedcloud openstack container list
  +------------------+
  | Name             |
  +------------------+
  | test-egi         |
  +------------------+
  ```

{{< /tabx >}}
{{< tabx  header="Windows" >}}

  To avoid passing the site, VO, etc. each time, you can use
  [FedCloud CLI environment variables](https://fedcloudclient.fedcloud.eu/usage.html#environment-variables)
  to set them once and reuse them with each command invocation.

  ```shell
  > set EGI_SITE=IN2P3-IRES
  > set EGI_VO=vo.access.egi.eu
  > fedcloud openstack container list
  +------------------+
  | Name             |
  +------------------+
  | test-egi         |
  +------------------+
  ```

{{< /tabx >}}
{{< tabx  header="PowerShell" >}}

  To avoid passing the site, VO, etc. each time, you can use
  [FedCloud CLI environment variables](https://fedcloudclient.fedcloud.eu/usage.html#environment-variables)
  to set them once and reuse them with each command invocation.

  ```powershell
  > $Env:EGI_SITE="IN2P3-IRES"
  > $Env:EGI_VO="vo.access.egi.eu"
  > fedcloud openstack container list
  +------------------+
  | Name             |
  +------------------+
  | test-egi         |
  +------------------+
  ```

{{< /tabx >}}
{{< /tabpanex >}}

#### Create new storage container

To
[create a new storage container](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html#container-create)
named `test-egi`, use the follwoing FedCloud command:

```shell
$ fedcloud openstack container create test-egi
+---------+-----------+------------------------------------------------------+
| account | container | x-trans-id                                           |
+---------+-----------+------------------------------------------------------+
| v1      | test-egi  | tx000000000000000000afc-005f845160-2bb3ed4-RegionOne |
+---------+-----------+------------------------------------------------------+
```

#### Create new object by uploading a file

To
[upload a file as a new object](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html#object-create)
into a storage container named `test-egi`, use the following FedCloud command:

{{% alert title="Tip" color="info" %}} The newly created object can have a different
name than the file being uploaded, use the `--name` command flag for this.
{{% /alert %}}

{{% alert title="Tip" color="info" %}} Multiple files can be uploaded at once,
but in that case the resulting objects will have the same names as the uploaded
files.
{{% /alert %}}

```shell
$ fedcloud openstack object create test-egi file1.txt
+-----------+-----------+----------------------------------+
| object    | container | etag                             |
+-----------+-----------+----------------------------------+
| file1.txt | test-egi  | 5bbf5a52328e7439ae6e719dfe712200 |
+-----------+-----------+----------------------------------+
```

#### List objects in a storage container

To
[list the objects in a storage container](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html#object-list)
use the FedCloud command below:

```shell
$ fedcloud openstack object list test-egi
+-----------+
| Name      |
+-----------+
| file1.txt |
+-----------+
```

#### Download (the content of) an object

To
[download an object](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html#object-save)
named `file1.txt` located in storage container `test-egi`, and save its content
to a file use the FedCloud command below:

{{% alert title="Tip" color="info" %}} The object can be saved into a file
named differently than the object itselft, by using the `--filename` command
flag.
{{% /alert %}}

{{% alert title="Tip" color="info" %}} Multiple files can be downloaded at
once, but in that case the resulting files will have the same names as the
downloaded objects.
{{% /alert %}}

```shell
$ fedcloud openstack object save test-egi file1.txt
```

#### Add metadata to an object

You can [add/update object metadata](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html#object-set),
stored as key-value pairs among the object properties.
E.g. to add a property named `key1` with the value `value2` to an object
named `file1.txt` located in the storage container named `test-egi`, you can
use the FedCloud command below:

```shell
$ fedcloud openstack object set \
      --property key1=value2 test-egi file1.txt
```

#### Remove metadata from an object

You can also [remove metadata from objects](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html#container-unset).
E.g. to remove the property named `key1` from the object named `file1.txt`
located in the storage container named `test-egi`, you can use the FedCloud
command below:

{{% alert title="Note" color="info" %}} Only metadata added by users can be
removed (system properties cannot be removed).
{{% /alert %}}

```shell
$ fedcloud openstack object unset \
      --property key test-egi file1.txt
```

#### Remove an object from a storage container

To
[delete an object](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html#object-delete)
named `file1.txt` from the storage container `test-egi`, use the following
FedCloud command:

{{% alert title="Caution" color="warning" %}} Deleting object from storage
containers is final, there is no way to recover deleted objects. Unlike in
[AWS S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html),
objects in OpenStack storage containers cannot be protected against deletion.
{{% /alert %}}

```shell
$ fedcloud openstack object delete test-egi file1.txt
```

#### Removing an entire container

To
[delete a storage container](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html#container-delete),
including all objects in it, use the FedCloud command below.

{{% alert title="Tip" color="info" %}} You can add the `-r` option
to recursively remove sub-containers.
{{% /alert %}}

{{% alert title="Caution" color="warning" %}} Deleting all objects from a
storage container is final, there is no way to recover deleted objects. Unlike in
[AWS S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html),
objects in OpenStack storage containers cannot be protected against deletion.
{{% /alert %}}

```shell
$ fedcloud openstack container delete test-egi
```

### Access via the S3 protocol

The OpenStack [Swift](https://docs.openstack.org/swift/latest/) service is
compatible with the S3 protocol, therefore when properly configured, it can be
accessed as any other S3-compatible object store.

{{% alert title="Note" color="info" %}} The S3 protocol was created by [Amazon
Web Services](https://www.aws.com) (AWS) for their object storage,
called [Simple Storage Service](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
(S3), but it was
[adopted as the de-facto standard](https://www.architecting.it/blog/object-storage-standardising-on-the-s3-api/)
to access object storage offered by other providers.
{{% /alert %}}

In order to access the storage via S3, an EGI Federated Cloud site admin needs to create
and associate to your EGI credentials both `access` and  `secret` keys which could then
be used by clients like `davix` to have access to the storage.

For example, to list containers/objects via the S3 protocol, use the command:

```shell
$ davix-ls --s3accesskey 'access' --s3secretkey 'secret' \
  --s3alternate s3s://s3.cl2.du.cesnet.cz/<bucket-name>
```

`davix-get`, `davix-put` and `davix-del` are also available to download, store
and delete objects from the storage.

## Access via EGI Data Transfer

The [EGI Data Transfer](../../data-transfer) service can move files
to and from object storages that are compatible with the S3 protocol.
You will have to upload the `access` keys to the EGI Data Transfer
service, which will be able  to generate properly signed URLs for the
objects in the storage.

{{% alert title="Note" color="info" %}} Please contact support
at `support` `<at>` `egi.eu` for more details.
{{% /alert %}}

You can then refer to this [tutorial](../../tutorials/data-transfer-object-storage)
to see how to transfer to/from an Object storage endpoint.

<!--
// jscpd:ignore-end
-->
