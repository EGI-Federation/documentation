---
title: "Object  Storage"
linkTitle: "Object Storage"
type: docs
weight: 55 
description: >
  Access to Object Storage provided by the EGI Federation Cloud providers
---


## Object Storage

Object storage is a standalone service that stores data as sets of individual objects 
organized within containers. Each object has its own URL, which can be used to access 
the resource, to share the file with other people, and to setup custom metadata and access 
control lists. These objects are accessed and managed via a REST API. 
There is virtually no limit to the amount of data you  can store, only the space used is 
accounted, you can access the data from any location 
(from any VM running at any EGI provider or even from other cloud providers or from your 
own laptop/browser), you can expose the data via external portals (using HTTP as transport 
protocols),  you can set access control lists per container and even make the data publicly 
available. 
On the other hand, data is accessed via a API requests, thus integration with existing 
applications may require a change to the application logic.


### Usage from your application

The Object storage in EGI is offered via OpenStack SWIFT deployments on some of the EGI 
Cloud providers.

Available SWIFT providers resources can be discovered in
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Services&serviceType=org.openstack.swift&selectItemserviceType=org.openstack.swift&ngi=&searchTerm=&production=TRUE&monitored=TRUE&certStatus=Certified&scopeMatch=all&servKeyNames=&servKeyValue=).

For accessing the endpoint check the `URL` of the specific provider.

OpenStack SWIFT offers a RESTful API to manage your storage and you can manage it via 
the OpenStack CLI or web dashboard. Check the complete [OpenStack object store API](https://docs.openstack.org/api-ref/object-store/) for more
information.

### Clients installations

