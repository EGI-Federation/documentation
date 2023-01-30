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
of on-going transfers and manage storage resource parameters.

EGI Data Transfer is ideal to move large amounts of files or very large
files as the service has mechanisms to verify checksums and ensure automatic
retry in case of failures.

The main features of EGI Data Transfer are:

- **Simplicity**. Easy user interfaces for submitting transfers (command-line,
  Python bindings, WebFTS, Web Monitoring).
- **Reliability**. Checksums are automatically calculated for each transfer and
  failed transfers are retried.
- **Flexibility**. Multi-protocol support (WebDAV/HTTTPS, GridFTP, xrootd, SRM, S3, GCloud).
- **Intelligence**. Parallel transfer optimization ensures users get the most from network
  without burning the storages. Transfers can be classified by _priority_ and _activity_.

{{% alert title="Tip" color="info" %}} Eager to test this service?
Have a look at our tutorial on
[how to transfer data in the grid](../../../tutorials/data-transfer-grid-storage).
{{% /alert %}}

{{% alert title="Note" color="info" %}} EGI Data Transfer is based on the
FTS3 service, developed at CERN.
{{% /alert %}}

## Components

FTS3 Server

: The service is responsible of the asynchronous execution of the file transfer,
checksumming and retries in case of errors

FTS3 REST

: The RESTFul server which is contacted by clients via REST APIs, CLI and Python
bindings

FTS3 Monitoring

: A Web interface to monitor transfers activity and server parameters

WebFTS

: A web interface that provides a file transfer and management solution in order
to allow users to invoke reliable, managed data transfers on distributed
infrastructures

## Service Instances

EGI has signed OLAs with 2 Providers, CERN and UKRI-STFC, in order to access their
FTS3 Service instances.

The following endpoints are available:

### CERN

- [FTS REST](https://fts3-public.cern.ch:8446/)
- [FTS Mon](https://fts3-public.cern.ch/fts3/ftsmon/)
- [WebFTS](https://webfts.cern.ch/) - N.B. Needs personal X.509 certificate
  installed in your Browser

### UKRI-STFC

- [FTS REST](https://fts3egi.scd.rl.ac.uk:8446/)
- [FTS Mon](https://fts3egi.scd.rl.ac.uk:8449/fts3/ftsmon/)

N.B. if you access the endpoints via Browser the following CA certificates need
to be installed:

- [CERN CA certificates](https://cafiles.cern.ch/cafiles/certificates/)
- [UK eScience CA certificates](http://www.ngs.ac.uk/ukca/certificates/cacerts.html)
