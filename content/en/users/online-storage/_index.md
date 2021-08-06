---
title: "Online Storage"
linkTitle: "Online Storage"
type: docs
weight: 55
description: >
  EGI Online Storage services
---

## Overview

EGI Online Storage includes a wide category of services that allow
users to **store, share and access data in the cloud**, using the EGI Cloud
infrastructure. Different categories of storage are available, depending on
how data is stored, the technology used to access and consume data,
and the foreseen usage.

Thee major service offerings are available:

- [Block Storage](block-storage) is block level storage that can be attached to
virtual machines (VMs) as volumes, a simple solution for durable data that does not need to be shared beside a single VM.
- [Grid Storage](grid-storage) is serving file access and storage for
[EGI High Throughput Compute](../high-throughput-compute) (HTC) scenarios.
- [Object Storage](object-storage) is persistent storage for cases when data
needs to be exposed within portals or shared between different steps of
processing workflows.

## Comparison of storage types

The main differences between Block, Grid, and Object Storage is summarized in
the following table:

<!-- markdownlint-disable line-length -->
| Type       | Sharing                                                       | Accounting              | Usage                                   |
| ---------- | ------------------------------------------------------------- | ------------------------| --------------------------------------- |
| **Block**  | Only from within VMs, only at the same site the VM is located | For the entire block    | POSIX access, use as local disk         |
| **Grid**   | From any device connected to the Internet                     | For the data stored     | Grid protocols and HTTP/WebDAV          |
| **Object** | From any device connected to the Internet                     | For the data stored     | HTTP requests to REST API               |
<!-- markdownlint-enable line-length -->
