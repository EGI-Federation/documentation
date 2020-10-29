---
title: "DataHub"
linkTitle: "DataHub"
type: docs
description: "Documentation related to EGI DataHub"
weight: 90
---

## Overview

The DataHub allows to:

- Bring data close to the computing to exploit it efficiently.
- Publish a dataset and make it available to a specific community or worldwide
  across federated sites.

The main features offered by the DataHub are:

- Discovery of data via a central portal.
- Access to data conforming to required policies which may be:
  1. unauthenticated open access;
  1. access after user registration or
  1. access restricted to members of a Virtual Organization (VO).\
  This access may be via a GUI (e.g. a webpage) or an API (e.g. programmatic
  access to the data)
- Replication of data from data providers for resiliency and availability
  purposes. Replication may take place either on­demand or automatically.
  Replication will require the introduction of a file catalogue to enable
  tracking of logical and physical copies of data.
- Access to data from the AppDB to enable VOs to associate appropriate data with
  matching Virtual Appliances
- Authentication and Authorization Infrastructure (AAI) integration between the
  EGI DataHub and with other EGI components and with user communities existing
  infrastructure
- File catalog to track replication of data: logical and physical file

It is based on the [OneData technology](https://onedata.org/).

## Motivations

- Putting up a (scalable) distributed data infrastructure needs specific
  expertise, resources and knowledge
- No easy way to discover and transfer data
- No easy way of making data (publicly) accessible without transferring it with
  a sharing service
- No easy way of combining multiple datasets from different data providers
- Users need to access data locally and from compute resources

## Components and concepts

Space

: a virtual volume where users will organize their data. A space is supported by
one or multiple Oneproviders providing actual storage resources

Onezone

: a central component federating providers. It takes care of Authentication and
Authorization and other management tasks (like space creation). EGI DataHub is a
Onezone instance.

EGI DataHub

: the central Onedata Onezone instance of the EGI Federation. Single Sign On
(SSO) with all the connected storage providers (Oneprovider) is guaranteed
through EGI Check-in

Oneprovider

: a data management component deployed in the data centres, provisioning data
and managing transfers. A Oneprovider is typically deployed at a site near the
local storage resources, and can access local storage resources over multiple
connectors (CEPH, POSIX,\...). A default one is operated for EGI by CYFRONET.

Oneclient

: a client application providing access to the spaces through a FUSE mount point
(local POSIX access). Spaces are accessible as if they were part of the local
file system. Oneclient can be used from VM, containers, desktop,\...

    Web interfaces and APIs are also available

## Highlighted features

![Viewing a data space using the EGI DataHub web interface](datahub-space-web.png)

Using the EGI DataHub web interface it\'s possible to manage the space.

![Viewing a data space in a console locally mounted using Oneclient](datahub-space-oneclient.png)

Using Oneclient it\'s possible to mount a space locally, and access it over a
POSIX interface, using files as they were stored locally. The file\'s blocks are
downloaded on demand.

![Viewing file distribution over the Oneproviders](datahub-replica-management.png)

In Onedata the file distribution is done on a block basis, blocks will be
replicated on the fly, and it\'s possible to instrument the replication.

![Management of metadata using the web interface](datahub-metadata-management.png)

Three different formats of metadata can be attached to files: basic (key/value),
JSON and RDF. The metadata can be managed using the Web interface and the APIs.
It\'s also possible to create indexes and query them.

![Viewing file popularity for smart caching](datahub-file-popularity-smarch-caching.png)

It\'s possible to view the popularity of a file and manage smart caching.
