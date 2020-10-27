---
title: "Data Transfer"
linkTitle: "Data Transfer"
type: docs
description: "Documentation related to EGI Data Transfer"
weight: 80
---

## Overview

The EGI Data Transfer Service is based on the FTS3 service, developed at CERN.
It allows you to move any type of data files asynchronously from one storage to
another. The service includes dedicated interfaces to display statistics of
on-going transfers and manage storage resources parameters.

The EGI Data Transfer is ideal to move large amounts of files or very large
files as the service has mechanisms to verify checksums and ensure automatic
retry in case of failures.

## Features

Simplicity

: Easy user interfaces for submitting transfers: CLI, Python Bindings, WebFTS
and Web Monitoring.

Reliability

: Checksums and retries are provided per transfer

Flexibility

: Multi-protocol support (Webdav/https, GridFTP, xrootd, SRM, S3, GCloud).

Intelligence

: Parallel transfers optimization to get the most from network without burning
the storages. Priorities/Activities support for transfers classification.

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

EGI has signed OLAs with 2 Providers, CERN and STFC, in order to access their
FTS3 Service instances.

The following endpoints are available:

### CERN

- [FTS REST](https://fts3-public.cern.ch:8446/)
- [FTS Mon](https://fts3-public.cern.ch/fts3/ftsmon/#/)
- [WebFTS](https://webfts.cern.ch/) - N.B. Needs personal X.509 certificate
  installed in your Browser

### STFC

- [FTS REST](https://lcgfts3.gridpp.rl.ac.uk:8446)
- [FTS Mon](https://lcgfts3.gridpp.rl.ac.uk:8449/fts3/ftsmon/#/)

N.B. if you access the endpoints via Browser the following CA certificates need
to be installed:

- [CERN CA certificates](https://cafiles.cern.ch/cafiles/certificates/)
- [UK eScience CA certificates](http://www.ngs.ac.uk/ukca/certificates/cacerts.html)
