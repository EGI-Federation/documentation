---
title: Data Management
type: docs
weight: 20
description: >
  Data management services in the EGI infrastructure
---

## Overview

The data management services of EGI comprises two groups of services:

- Services that provide data **management capabilities** to enhance the
  [raw storage](../storage) available in the EGI infrastructure
- Specialized services that offer **advanced organisation of data during
  ongoing research projects**, as an integrated environment with
  data management and digital lab notebook
  
The EGI data management services offer both application programming
interfaces (APIs) and command-line interfaces (CLIs) that are integrated
with the advanced EGI services and platforms
(such as [development environments](../../dev-env),
[machine learning](../../machine-learning), or
[cloud orchestrators](../../compute/orchestration)),
and can be accessed from most [compute services](../../compute).

## Generic data management

These higher-level data management services are available to researchers:

- [EGI Rucio](rucio) is tailored to medium/big scientific collaborations, allowing
  users to organise, manage, and access their data at scale. Data can be distributed
  across heterogeneous data centers at widely distributed locations.
- [EGI DataHub](datahub) is a high-performance data management solution that
  offers unified data access across multiple types of underlying storage, allowing
  users to share, collaborate and easily perform computations on the stored data.

## Specialized data management

The following specialized data management services are also available:

- [EGI Data Transfer](data-transfer) is a low-level service to move data from
  one [Grid](../storage/grid-storage) or [Object](../storage/object-storage) storage
  to another. It is used internally by [Rucio](rucio) to schedule transfers based
  on the data policies defined by the users.
- [openRDM](open-rdm) is a combined [FAIR](https://en.wikipedia.org/wiki/FAIR_data)
  data management platform, Electronic Laboratory Notebook (ELN) and Inventory Management System
  allowing a complete overview of workflows and information, from initial data generation
  to data analysis and publication.

## Use-cases for storing and managing research data

Depending on the type of the employed compute services and the use-cases being addressed,
users might need to choose different data service to store, access, and manage data.

| User           | Data storage                                             | Data management (optional) |
| -------------- | -------------------------------------------------------- | -------------------------- |
| **Cloud user** | Block and Object storage                                 | DataHub                    |
| **HTC user**   | Grid storage                                             | Rucio                      |
| **HPC user**   | High-performance parallel file systems or Object storage | DataHub or Rucio           |

The following sections offer detailed descriptions for each data management service.
