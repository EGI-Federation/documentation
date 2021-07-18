---
title: "Object Storage"
linkTitle: "Object Storage"
type: docs
weight: 55
description: >
  Object Storage offered by EGI Cloud providers
---

## Object Storage

Object storage is a standalone service that stores data as sets of individual
objects organized within containers. Each object has its own URL, which can be
used to access the resource, to share the file with other people, and to setup
custom metadata and access control lists. These objects are accessed and managed
via a REST API. There is virtually no limit to the amount of data you can store,
only the space used is accounted, you can access the data from any location
(from any VM running at any EGI provider or even from other cloud providers or
from your own laptop/browser), you can expose the data via external portals
(using HTTP as transport protocol), you can set access control lists per
container and even make the data publicly available. On the other hand, data is
accessed via a API requests, thus integration with existing applications may
require a change to the application logic.

### Usage from your application

The Object storage in EGI is offered via OpenStack SWIFT deployments on some of
the EGI Cloud providers.

Available SWIFT providers resources can be discovered in
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=org.openstack.swift&selectItemserviceType=org.openstack.swift&ngi=&searchTerm=&production=TRUE&monitored=TRUE&certStatus=Certified&scopeMatch=all&servKeyNames=&servKeyValue=).

For accessing the endpoint check the `URL` of the specific provider.

OpenStack SWIFT offers a RESTful API to manage your storage and you can manage
it via the OpenStack CLI or web dashboard. Check the complete
[OpenStack object store API](https://docs.openstack.org/api-ref/object-store/)
for more information. More advanced usage include access via the S3 protocol and
the EGI Data Transfer Service which are also described in the following
sections.

### Access via Openstack CLI

The Openstack CLI can be used to perform operations over the SWIFT endpoints
available on the infrastructure.

First the Openstack environment needs to be properly setup, and for this purpose
the [fedcloud](https://fedcloudclient.fedcloud.eu) client is quite handy. For
instance to setup the access to the SWIFT endpoint at IFCA-LCG2 via the Pilot VO
(vo.access.egi.eu) you can use the `fedcloud openstack` command. Start listing
the available containers(buckets):

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container list
+------------------+
| Name             |
+------------------+
| egi_endorsed_vas |
+------------------+
```

Creating a new container:

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container create test-egi
+---------+-----------+------------------------------------------------------+
| account | container | x-trans-id                                           |
+---------+-----------+------------------------------------------------------+
| v1      | test-egi  | tx000000000000000000afc-005f845160-2bb3ed4-RegionOne |
+---------+-----------+------------------------------------------------------+
```

Creating a new Object by uploading a file:

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
           object create test-egi file1.txt
+-----------+-----------+----------------------------------+
| object    | container | etag                             |
+-----------+-----------+----------------------------------+
| file1.txt | test-egi  | 5bbf5a52328e7439ae6e719dfe712200 |
+-----------+-----------+----------------------------------+
```

Listing objects inside a container:

```shell
$ fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu object list test-egi
+-----------+
| Name      |
+-----------+
| file1.txt |
+-----------+
```

Download an object:

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object save test-egi file1.txt
```

Removing an object from the container:

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu \
         object delete test-egi file1.txt
```

Removing the entire container (`-r` option for recursive):

```shell
fedcloud openstack --site IFCA-LCG2 --vo vo.access.egi.eu container delete test-egi
```

### Access via S3 protocol

Openstack SWIFT is compatible with S3 protocol, therefore if the SWIFT
deployment are properly configured they can be accessed as any other S3
compatible storage.

In order to access the storage via S3 you need to create first the EC2
credentials from the Openstack deployment.

The following command is needed:

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

The `access` and `secret` values are needed in order to access the SWIFT via the
S3 protocol

A lot of clients are available to access S3 compatible storages (awscli, s3cmd,
etc). In EGI we are using the [Davix client](https://davix.web.cern.ch), which
has been developed at CERN and is available both in RHEL and Debian
environments.

In order to list via S3 protocol the SWIFT server just type:

```shell
davix-ls --s3accesskey 'access' --s3secretkey 'secret'  --s3alternate s3s://api.cloud.ifca.es:8080/swift/v1/test-egi

```

`davix-get`, `davix-put` and `davix-del` are also available to download, store
and delete objects from the storage.

### Access via the EGI Data Transfer

The [EGI Data Transfer](../../data-transfer) can be also configured to move file
to/from Object storages using the S3 protocol.

This will require to upload the EC2 access keys to the EGI Data Transfer
service, which will be then entitled to generate the proper signed URL to access
the storage.

Please contact the support (_support_at_egi_dot_eu_) in order to have more
details.
