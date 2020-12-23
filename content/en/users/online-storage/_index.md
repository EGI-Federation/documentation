---
title: "Online Storage"
linkTitle: "Online Storage"
type: docs
weight: 55
description: >
  Store, share and access your files and their metadata on a global scale
---

The EGI Online Storage includes a wide category of services which allows
storing, sharing and accessing files on the EGI infrastructure. The service
comprises different categories of storage services depending on the technology
and usage that is foreseen. The 3 following service offerings are available:

- [Grid Storage](grid-storage/)
- [Object Storage](object-storage/)
- [Block Storage](../cloud-compute/storage/#block-storage), which is described
  under the Cloud Compute section

A summary of the main differences between Grid, Block and Object Storage is
reported in the following table.

| Access             | Sharing                                                       | Accounting                        | Usage                                   |
| ------------------ | ------------------------------------------------------------- | --------------------------------- | --------------------------------------- |
| **Grid Storage**   | from any device connected to the internet                     | Available for the data stored     | Grid protocols and HTTP/Webdav requests |
| **Block Storage**  | only from within a VM only at the same site the VM is located | Not possible for the entire block | POSIX access, use as local disk         |
| **Object Storage** | from any device connected to the internet                     | Possible only for the data stored | via HTTP requests to server             |

Grid Storage is mainly serving data access and storage for EGI High Throughput
Compute scenarios. For EGI Federated Cloud use cases it depends on the
application needs either Block or Object storage could be use. In general, block
storage is a good and simple solution for temporary data and data which you do
not need to share beside the single application running on a single VM. If you
need to have your data exposed within portals or shared between different steps
of your processing workflow, it is usually best to use the object storage.
