---
title: "Object Storage"
linkTitle: "Object Storage"
type: docs
weight: 30
description: >
  Object Storage offered by EGI Cloud providers
---

## What is it?

Object storage is a standalone service that **stores data as individual
objects, organized into containers**. It is a highly scalable, reliable,
fast, and inexpensive data storage. It has a simple web services interface
that can be used to store and retrieve any amount of data, at any time,
from anywhere on the web.

The main features of object storage:

- Storage containers and objects have unique URLs, which can be used to access, manage, and share them.
- Data can be accessed from anywhere, using standard HTTP requests to a REST API (e.g. VMs running in the EGI Cloud or in other cloud provider's cloud, from any browser/laptop, etc.)
- Access can be public or can be restricted using access control lists.
- There is virtually no limit to the amount of data you can store, only the space used is accounted for.

## Concepts

To use object storage effectively, you need to understand the following key
concepts and terminology:

### Storage containers

Storage containers (aka buckets) are the fundamental holders of data. Every
object is stored in a storage container. You can store any number of objects in
a storage container.

Storage containers have an unique name and act as the root folders of the
storage space.

Each storage container has a unique URL (that includes the name) by which anyone
can refer to it.

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

The Object Storage in the EGI Cloud is offered via
[OpenStack](https://openstack.org/) SWIFT deployments on (some of
the) EGI Cloud providers.

You can access and manage the storage via the
[command line](#access-from-the-command-line) or the web dashboard of the
selected provider. More advanced usage include access via the 
[S3 protocol](#access-via-the-s3-protocol), or via the
[EGI Data Transfer service](#access-via-egi-data-transfer).

{{% alert title="Note" color="info" %}} Available SWIFT resources
can be discovered in the
[Configuration Database](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=org.openstack.swift&selectItemserviceType=org.openstack.swift&ngi=&searchTerm=&production=TRUE&monitored=TRUE&certStatus=Certified&scopeMatch=all&servKeyNames=&servKeyValue=)
(GOCDB).
{{% /alert %}}

{{% alert title="Note" color="info" %}} OpenStack SWIFT offers a REST API
to manage storage. See the
[OpenStack object store API](https://docs.openstack.org/api-ref/object-store/)
for more details.
{{% /alert %}}

## Access from the command line

Multiple command clients interfaces (CLIs) are available to access object
storage:

- For SWIFT endpoints the recommended CLI is the
  [FedCloud client](../../cloud-compute/openstack).
- For S3-compatible object storage the recommended CLI is the
  [Davix client](https://davix.web.cern.ch), which has been developed at CERN
  and is available both in RHEL and Debian environments.

### Access with the FedCloud CLI

The [FedCloud command line interface](../../cloud-compute/openstack)
(CLI) can be used to perform operations on the SWIFT endpoints available in
the EGI Cloud. This means using the command `fedcloud openstack` to query
and manipulate storage containers and objects.

{{% alert title="Note" color="info" %}} See 
[here](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/container.html)
for documentation on all storage container-related commands, and 
[here](https://docs.openstack.org/python-openstackclient/latest/cli/command-objects/object.html)
for all object-related commands.
{{% /alert %}}

#### List storage containers

For example, to access to the SWIFT endpoint at IFCA-LCG2 via the
Pilot VO (vo.access.egi.eu), use the `fedcloud openstack` command to
list the available storage containers:

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container list
+------------------+
| Name             |
+------------------+
| egi_endorsed_vas |
+------------------+
```

#### Create new storage container

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container create test-egi
+---------+-----------+------------------------------------------------------+
| account | container | x-trans-id                                           |
+---------+-----------+------------------------------------------------------+
| v1      | test-egi  | tx000000000000000000afc-005f845160-2bb3ed4-RegionOne |
+---------+-----------+------------------------------------------------------+
```

#### Create new object by uploading a file

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
           object create test-egi file1.txt
+-----------+-----------+----------------------------------+
| object    | container | etag                             |
+-----------+-----------+----------------------------------+
| file1.txt | test-egi  | 5bbf5a52328e7439ae6e719dfe712200 |
+-----------+-----------+----------------------------------+
```

#### List objects in a storage container

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu object list test-egi
+-----------+
| Name      |
+-----------+
| file1.txt |
+-----------+
```

#### Download (the content of) an object

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object save test-egi file1.txt
```

#### Add metadata to an object

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object set --property key=value test-egi file1.txt
```

#### Remove metadata from an object

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object unset --property key test-egi file1.txt
```

#### Remove an object from a storage container

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object delete test-egi file1.txt
```

#### Removing an entire container

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container delete test-egi
```

{{% alert title="Tip" color="info" %}} You can add the `-r` option
to recursively remove sub-containers.
{{% /alert %}}

### Access via the S3 protocol

Openstack SWIFT is compatible with S3 protocol, therefore if the SWIFT
deployment is properly configured, it can be accessed as any other
S3-compatible storage.

{{% alert title="Note" color="info" %}} The S3 protocol was created by [Amazon
Web Services](https://www.aws.com) (AWS) for their object storage,
called [Simple Storage Service](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
(S3), but it was 
[adopted as the de-facto standard](https://www.architecting.it/blog/object-storage-standardising-on-the-s3-api/)
to access object storage offered by other providers.
{{% /alert %}}

In order to access the storage via S3, you need
[EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)-compatible
credentials from the Openstack deployment. Use the following command:

<!-- markdownlint-disable line-length -->
```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu ec2 credentials create

+------------+------------------------------------------------------------------------------------------------------------------------------------------+
| Field      | Value                                                                                                                                    |
+------------+------------------------------------------------------------------------------------------------------------------------------------------+
| access     | zxxxxxxxxxxxxxxxxxxxxxxxxxx                                                                                                              |
| links      | {'self': 'https://api.cloud.ifca.es:5000/v3/users/5495cd688ad7401b8e87b46bdea92f33/credentials/OS-EC2/xxxxxxxxxxxxxxxxx'}                |
| project_id | 999f045cb1ff4684a15ebb338af69460                                                                                                         |
| secret     | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                                                                                                        |
| trust_id   | None                                                                                                                                     |
| user_id    | xxxxxxxxxxxxxxxxxxxxxxxxxxxx                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------------------------+
```
<!-- markdownlint-enable line-length -->

{{% alert title="Important" color="warning" %}} Save the `access` and `secret`
values, as those are needed in subsequent commands that use the S3 protocol.
{{% /alert %}}

To list containers/objects via the S3 protocol, use the command:

```shell
davix-ls --s3accesskey 'access' --s3secretkey 'secret' --s3alternate s3s://api.cloud.ifca.es:8080/swift/v1/test-egi

```

`davix-get`, `davix-put` and `davix-del` are also available to download, store
and delete objects from the storage.

## Access via EGI Data Transfer

The [EGI Data Transfer](../../data-transfer) service can move files
to and from object storages that are compatible with the S3 protocol.
You will have to upload the EC2 access keys to the EGI Data Transfer
service, which will be able  to generate properly signed URLs for the
objects in the storage.

{{% alert title="Note" color="info" %}} Please contact support
at `support` `<at>` `egi.eu` for more details.
{{% /alert %}}
