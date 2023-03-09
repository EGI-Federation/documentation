---
title: Rucio
linkTitle: Data Orchestrator
type: docs
weight: 40
description: >-
  Organise and access data at scale with Rucio
---

## What is it?

Built on more than a decade of experience in LHC experiments, Rucio serves the
data needs of any modern scientific experiments. Rucio can manage large amounts
of data, countless numbers of files, heterogeneous storage systems, globally
distributed data centres, with monitoring and analytics.

Rucio **allows management of data with expressive statements**. You to say what
you want, and Rucio will figure out the details of how to do it. For example,
three copies of my file on different continents with a backup on tape. You can
also automatically remove copies of data after a set period or once its access
popularity drops.

While Rucio is extremely scalable, the STFC Rucio Data Management Service is
designed for smaller communities, with expected data needs up to tens of
Petabytes. The fact that the underlying Rucio infrastructure is managed by STFC,
allows communities to easily start using and/or test Rucio with little setup
cost.

## Requirements to consider to use Rucio

For Rucio to manage your data in this setup, Rucio will need X.509 certificate
access, or soon, through
[EGI Check-in](../../../../providers/check-in/_index.md) to:

- Your experiments Storage Element that is X.509 capable
- Your experiments Tape Archive that is X.509 capable
- Your experiments VOMS server information to check Users credentials against

Rucio is a system that sits on top of already established storage elements to
unify users access for data management, and retrieval. Rucio consists of a
database of the storage element's details, users and their access credential
information, access levels, the data, and its location, Rucio is not a direct
data storage solution.

## Rucio Use Cases

Rucio is a data management software, that integrates with your experiments
currently provisioned storage. This section will highlight some use cases that
Rucio will fill for your experiment.

### Management of data for archive when no longer used actively

A simple use case for Rucio is to manage data between 'hot' storage, made of
HDDs or SSD, and 'cold' storage made up of tape. When your experiment generates
data that data will be accessed much more than older data as your colleagues work
with the data. Within Rucio the data will be registered to be on the 'hot' and
'cold' storage. This ensures the integrity of the data by providing multiple
copies of the data, one on the slower tape archive, and one copy on the more
easy to access HDDs and SSDs. Then as the usage of this data declines, the data
on the 'hot' storage can be removed to make way for newer data that is more
frequently accessed. Should the archived data be requested again Rucio can stage
the data from tape back to disk making it available for users.

### Management of data between sites for jobs

Another useful use case for Rucio is to manage the data between different sites
within your experiment. This can provide users with better access to the data
that they want to work on. Another option is to have Rucio integrated with your
workflow management software (Panda and DIRAC both have integrated with Rucio),
so data can be moved to sites as job slots are available, streamlining the
data flow for the user.

## Official Rucio Pages

- [Rucio Homepage](https://rucio.cern.ch/)
- [Rucio Documentation](https://rucio.cern.ch/documentation/)

## Multi-VO specific pages

- [Multi-VO Rucio at RAL as a service](https://www.scd.stfc.ac.uk/Pages/SCD-STFC-Rucio-Data-Management-Service.aspx)
- [Privacy Policy](https://www.scd.stfc.ac.uk/Pages/STFC-Rucio-Privacy-Notice.aspx)
- [Acceptable Use Policy](https://www.scd.stfc.ac.uk/Pages/STFC-Rucio-Acceptable-Use-Policy.aspx)
