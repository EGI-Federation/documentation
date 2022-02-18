---
title: Online Storage
type: docs
weight: 10
description: >
  Storage services in the EGI infrastructure
---

## Overview

[Online Storage](https://www.egi.eu/services/online-storage/) includes services
that allow users to **store, share and access data** using the EGI infrastructure.
Different categories of storage are available, depending on how data is stored,
the technology used to access and consume data, and the foreseen usage.

Three major service offerings are available:

- [Block Storage](block-storage) is block-level storage that can be attached to
  virtual machines (VMs) as volumes, a simple solution for durable data that
  does not need to be shared beside a single VM.
- [Grid Storage](grid-storage) is file storage for
  [High Throughput Compute](../../compute/high-throughput-compute) (HTC) and/or
  [High Performance Compute](../../compute/high-performance-compute) (HPC)
  scenarios.
- [Object Storage](object-storage) is persistent, hierarchical blob storage for
  cloud native applications, archiving, or when data is shared between different
  VMs or multiple steps of processing workflows.

## Comparison of storage types

The differences between Block, Grid, and Object Storage are summarized below:

| Type       | Sharing                                                  | Accounting           | Usage                           |
| ---------- | -------------------------------------------------------- | -------------------- | ------------------------------- |
| **Block**  | From within VMs, only at the same site the VM is located | For the entire block | POSIX access, use as local disk |
| **Grid**   | From any device connected to the internet                | For the data stored  | Grid protocols and HTTP/WebDAV  |
| **Object** | From any device connected to the internet                | For the data stored  | HTTP requests to REST API       |

The following sections offer a more detailed description of each storage service.
