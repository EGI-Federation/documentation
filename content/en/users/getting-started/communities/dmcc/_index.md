---
title: Disaster Mitigation and Agriculture
linkTitle: Disaster Mitigation and Agriculture
type: docs
weight: 10
description: >
  EGI infrastructure for the Disaster Mitigation and Agriculture community
---

This is the documentation of the resource pool that exists in EGI to support the
**Disaster Mitigation and Agriculture** community in the Asian Pacific region.
The resource pool is called `vo.environmental.egi.eu` Virtual Organisation (VO).

## About the community

Hazard risk estimation and prediction by numerical simulation is crucial to
disaster mitigation studies and applications. The Disaster Mitigation and Agriculture
community investigates in-depth the mechanisms of the selected disaster events and
develops the appropriate simulation models to reproduce the processes by case studies.
The collaboration framework aims at becoming an open science platform of disaster
mitigation so that all the tools, data, resources and simulation facilities are sharable,
and the simulations are reproducible.

## About the Asia Pacific resource pool

The purposes of the `vo.environmental.egi.eu` Virtual Organisation (VO) in EGI are to:

* Facilitate open science in the Asian Pacific region;
* Enable sharing of cloud resources from the region;
* Facilitate application sharing from the region;
* Facilitate data sharing related to environmental sciences from the region.

This resource pool is supported by the following services:

* [EGI Cloud Compute](../../../compute/cloud-compute/),
* [EGI Notebooks](../../../dev-env/notebooks/),
* [EGI Replay](../../../dev-env/replay/)

This resource pool currently includes the following Cloud resources:

* 16 vCPU cores, 48 GB of RAM, and 1 TB of block storage
(provided by [CESNET-MCC](https://www.egi.eu/partner/cesnet/)).

## How to get access to the Asia Pacific resource pool

Getting access to the Asian Pacific resource pool (`vo.environmental.egi.eu`)
consists of the following steps:

1. Sign-up for an [EGI Check-in account](../../../aai/check-in/signup/).
1. Request to join the `vo.environmental.egi.eu` Virtual Organisation (VO) by
    visiting the [enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:369)
    with your EGI Check-in account. The subscription requires approval from the VO Manager.

## How to use the EGI Notebooks service in the Asia Pacific VO

Verify that you have already a valid EGI account and that your are members
of the Asia Pacific resource pool (See the instructions reported in the
[How to get access to the Asia Pacific resource pool](#how-to-get-access-to-the-asia-pacific-resource-pool)
section for more details).

Access the EGI Notebooks service at:
[https://notebooks.egi.eu/](https://notebooks.egi.eu/)

### Write and run your notebook

Use the JupyterLab web interface to launch the notebook with one of the available
Kernel: **R**, **Python**, **Octave**, **Julia** and **Matlab**.

Datasets in the EGI Notebooks can be accessed via:
**CVMFS**, **DataHub**, and **B2DROP**. More additional information on how to
configure notebooks to access data on CVMFS, DataHub and B2DROP will be provided
in the sections below.

### How to make datasets and applications available in CVMFS

* Access the [VO ID card](https://operations-portal.egi.eu/vo/view/voname/vo.environmental.egi.eu)
  in the EGI Operations Portal.
* Get the VO Admin (or VO Manager) for the `vo.environmental.egi.eu` VO
  (see the "Generic contacts" table in the EGI Operations Portal).
* Request access to the service (sending an email to cvmfs-support@gridpp.rl.ac.uk)
  to add new content in the CVMFS repository (for the `vo.environmental.egi.eu` VO).
* Wait until the application is published in the CVMFS repository.
* Sending an email to notebooks-support@mailman.egi.eu to enable
  the access to the CVMFS repository in the EGI Notebooks service.

### How to make your datasets available in DataHub

Whenever you log into the EGI Notebooks service, supported DataHub spaces
will be available under the `datahub` folder. If you need support for any
additional space, please open a [GGUS](https://ggus.eu/) ticket to add it.

By default the `notebooks-shared` space is open for writing to any
EGI Notebooks user part of the `vo.notebooks.egi.eu` VO. Please check the
[File Management](../../../data/management/datahub/file-management/) section in
the EGI DataHub documentation for more information on how to upload files.

### How to make your datasets available in B2DROP

The data on [B2DROP](https://eudat.eu/services/b2drop) can be synchronised
with EGI Notebooks so you can share content between the two services.
This offers an easy-to-use storage and compute platform for the long-tail
of science. Here is how you can get them synchronised:

* First, make sure you have a B2DROP app `Username` and `Password`.
* Upload your datasets in the B2DROP repository.
* Launch your notebook selecting the
  [B2DROP connection](../../../dev-env/notebooks/data/#eudat-b2drop)
  from the available service options.
* A B2DROP folder will be available in the list of folders (left panel)
  of the EGI Notebooks.

## How to use the EGI Replay service in the Asia Pacific VO

Verify that you have already a valid EGI account and that your are members
of the Asia Pacific resource pool (See the instructions reported in the
[How to get access to the Asia Pacific resource pool](#how-to-get-access-to-the-asia-pacific-resource-pool)
section for more details).

Access the EGI Replay service at:
[https://replay.notebooks.egi.eu/](https://replay.notebooks.egi.eu/)

Reproducible notebooks can be provided as GitHub repositories or via DOIs.

### How to make notebooks reproducible and shareable

See the
[EGI training tutorial at ISGC 2023](https://indico4.twgrid.org/event/25/sessions/254/#20230321).

## How to use the Cloud resources allocated to the Asia Pacific resource pool

Access the cloud-based resources at CESNET-MCC via the OpenStack Horizon dashboard:

* [Horizon OpenStack dashboard](https://dashboard.cloud.muni.cz/)
* Authenticate using: `EGI Check-in`
* Project name: `vo.environmental.egi.eu`
* Project ID: `29e6fbf618984a0c98ffcdf0222ad815`
* Network ID: `group-project-network`
* Security Group: ingress traffic to port 22 (SSH) is enabled

### How to share data

For managing data, different Data Management services are available in the
EGI Infrastructure:

* [EGI DataHub](../../../data/management/datahub/)
* [EGI Data Transfer](../../../data/management/data-transfer/)
* [EGI Data Orchestrator](../../../data/management/rucio/)

For more information, please see the
[Data Management](../../../data/management/) section and the
[tutorials](../../../tutorials/).

### How to bring your data in the EGI DataHub from a VM

To access data remotely stored in EGI DataHub like if they were local,
using traditional POSIX command-line commands you need to install the
`oneclient` component. For more details on how to install and configure
the component, please see the
[Access DataHub from a Virtual Machine](../../../tutorials/adhoc/vm-datahub/)
documentation. [Access via API](../../../data/management/datahub/api/)
is also available and it’s leveraging the integration of the service with EGI Check-in.

In order to access an existing space on EGI DataHub or ask for hosting
your data in DataHub please contact our [Helpdesk](https://ggus.eu/).

Additional tutorials may be relevant:

* [Create a Virtual Machine with Jupyter and DataHub](../../../tutorials/adhoc/jupyter-datahub-virtual-machine/)

### How to transfer your data to the EGI infrastructure via EGI Data Transfer

[EGI Data Transfer](https://www.egi.eu/service/data-transfer/),
based on the FTS service, allows scientists to
**move any type of data files asynchronously from one storage to another**.
The storage can be either any grid storage in the EGI infrastructure
or a cloud storage implementing the S3 interface.

Relevant tutorials:

* [Data Transfer with Grid Storage](../../../tutorials/adhoc/data-transfer-grid-storage/)
* [Data Transfer with Object Storage](../../../tutorials/adhoc/data-transfer-object-storage/)

### How to use the  EGI Data Orchestrator

The [EGI Data Orchestrator](../../../data/management/rucio/),
based on the Rucio service developed at [CERN](https://rucio.cern.ch/),
is mainly offered for Communities for specific distributed data management
needs as explained in our [use cases documentation](../../../data/management/rucio/#rucio-use-cases).

Dedicated [Getting Started documentation](../../../data/management/rucio/getting-started/)
is available to start the evaluation of the service and to access
the resources made available by the
[dteam VO](../../../data/management/rucio/dteam-vo/)
that is used for  testing.

## How to contribute with cloud resources

The steps that an OpenStack cloud provider needs to follow to add resources
to the Disaster Mitigation and Agriculture community
Virtual Organisation (i.e. `vo.environmental.egi.eu`) are available in the
[VO Configuration guide for providers](../../../../providers/cloud-compute/openstack/vo_config).
