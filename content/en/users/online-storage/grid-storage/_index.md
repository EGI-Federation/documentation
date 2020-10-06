---
title: "Grid Storage"
linkTitle: "Grid Storage"
type: docs
weight: 55 
description: >
  Grid Storage 
---


The EGI Online Storage service comprises different categories of storage services depending 
on the technology and usage that is foreseen. The 2 following service offerings are available:

- Grid Storage
- Object Storage

The EGI Federation cloud providers are also offering block storage to users, the particular is described under the [Cloud Compute](../cloud-compute/storage/#block-storage) documentation.


## Grid Storage

Gird Storage allows you to store data in a reliable and high-quality environment and share it across distributed teams. Your data can be accessed through different standard protocols and can be replicated across different providers to increase fault-tolerance. Online Storage gives you complete control over the data you share and with whom. Main features:

    Assign global identifiers to files
    Access highly-scalable storage from anywhere
    Control the data you share
    Organise your data using a flexible hierarchical structure

Online Storage is based on GridFTP and SRM technology. 


## Object Storage

The Object storage in EGI is offered via OpenStack SWIFT deployments on some of the EGI Cloud providers.

Available SWIFT providers resources can be discovered in GOCDB. For accessing the endpoint check the URL of the specific provider.
Usage from your application
Integration of the block storage within your application will require a client or set of libraries to be integrated within your application that perform the REST operations on the service endpoints. Check the complete OpenStack object store API for more information.