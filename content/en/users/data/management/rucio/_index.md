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

For Rucio to mangage your data in this setup, Rucio will need X509 certificate
access, or soon, through [EGI Check-in](../../providers/check-in) to:

- Your experiments Storage Element that is X509 capable
- Your experiments Tape Archive that is X509 capable
- Your experiments Voms server information to check Users credentials against

Rucio is a system that sits on top of already established storage elements to
unify users access for data management, and retrival. Rucio consists of a
database of the storage element's details, users and their access credential
information, and access levels, and the data and its location, not a direct data
storage solution.

## Rucio Use Cases

Rucio is a data management software, that integrates with your experiments
currently provisioned storage. Therefore, this section will deal with usecases
that you should consider Rucio for.

### Management of data for archive when no longer used actively

One that may be useful is if your experiment has data that is newly generated,
that data will be accessed much more than older data. This new data is also
precious and needs to be preserved. To ensure the integrity of the data, Rucio
can be instructed by two rules, one to write the data to a cheap long term
archive of tape storage, the second to ensure the data is also available on HDDs
or, if available SSDs. Then as the usage of this data declines, the data on the
more accessible HDD or SSD can be removed, in the knowledge that if the data is
ever required again, Rucio can stage the data from tape back to disk.

### Management of data between sites for jobs

Another useful usecase for Rucio is to mangage the data between different sites
within your experiment. This can provide users with better access to the data
that they want to work on. Another option is to have Rucio integrated with your
workflow management software (PanDA and DiRAC both have integrated with Rucio),
so data can be moved to sites as job slots are available, streamlining the
dataflow for the user.

## Official Rucio Pages

- [Rucio Homepage](https://rucio.cern.ch/)
- [Rucio Documentation](https://rucio.cern.ch/documentation/)

## Multi-VO specific pages

- [Multi-VO Rucio at RAL as a service](https://www.scd.stfc.ac.uk/Pages/SCD-STFC-Rucio-Data-Management-Service.aspx)
- [Privacy Policy](https://www.scd.stfc.ac.uk/Pages/STFC-Rucio-Privacy-Notice.aspx)
- [Acceptable Use Policy](https://www.scd.stfc.ac.uk/Pages/STFC-Rucio-Acceptable-Use-Policy.aspx)
