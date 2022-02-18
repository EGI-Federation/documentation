---
title: DataHub Use-Cases
linkTitle: Use-Cases
weight: 10
type: docs
description: >
    Use-cases for EGI DataHub
---

An overview of the use cases and possible deployment scenarios of the
[EGI DataHub](https://datahub.egi.eu/).

## Transparent data access

![image](datahub-transparent-data-access.png)

- Clients use one ore more providers to access data
- Data can be accessed over multiple protocols

## Federation of service providers

![image](datahub-federation-of-service-providers.png)

- Heterogeneous backend storage
- Common interfaces (Web, REST, POSIX, CDMI)
- Common AAI with Check-in
- Discovery of Datasets in the EGI DataHub

## Smart caching

![image](datahub-smart-caching.png)

- Site A hosts data and computing resources
- Site B hosts only data
- Site X uses data from A and B without pre-staging
- Pre-staging can also be done using APIs
- Data is accessed locally "à la" POSIX with FUSE

## Publication of datasets

![image](datahub-publication-of-datasets.png)

- PID minting
- Publishing, discovery and access to datasets

## Integrating DataHub and EGI Notebooks

![image](datahub-notebooks-integration.png)
