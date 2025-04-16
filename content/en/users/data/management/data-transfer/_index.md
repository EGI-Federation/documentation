---
title: EGI Data Transfer
type: docs
weight: 30
aliases:
  - /users/data-transfer
description:
  Very large data transfers in the EGI infrastructure
---

## What is it?

[EGI Data Transfer](https://www.egi.eu/service/data-transfer/)
allows scientists to **move any type of data files asynchronously from one
storage to another**. The service includes dedicated interfaces to display statistics
of ongoing transfers and manage storage resource parameters.

EGI Data Transfer is ideal to move large amounts of files or very large
files as the service has mechanisms to verify checksums and ensure automatic
retry in case of failures.

The main features of EGI Data Transfer are:

- **Simplicity**. Easy user interfaces for submitting transfers (command-line,
  Python bindings, Web Monitoring).
- **Reliability**. Checksums are automatically calculated for each transfer and
  failed transfers are retried.
- **Flexibility**. Multi-protocol support (WebDAV/HTTPS, GridFTP, xrootd, SRM, S3, GCloud).
- **Intelligence**. Parallel transfer optimization ensures users get the most from network
  without burning the storages. Transfers can be classified by _priority_ and _activity_.

{{% alert title="Tip" color="info" %}} Eager to test this service?
Have a look at our tutorial on
[how to transfer data in the grid](../../../tutorials/adhoc/data-transfer-grid-storage).
{{% /alert %}}

{{% alert title="Note" color="info" %}} EGI Data Transfer is based on the
FTS3 service, developed at CERN.
{{% /alert %}}

## Components

FTS3 Server

: The service is responsible for the asynchronous execution of the file transfer,
checksumming and retries in case of errors

FTS3 REST

: The RESTFul server which is contacted by clients via REST APIs, CLI and Python
bindings

FTS3 Monitoring

: A Web interface to monitor transfers activity and server parameters

## Service Instances

The following endpoints are available:

### CERN

- [FTS REST](https://fts-egi.cern.ch:8446/)
- [FTS Mon](https://fts-egi.cern.ch/fts3/ftsmon/)

N.B. if you access the endpoints via Browser the following CA certificates need
to be installed:

- [CERN CA certificates](https://cafiles.cern.ch/cafiles/certificates/)

