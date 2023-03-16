---
title: Disaster Mitigation and Agriculture
linkTitle: Disaster Mitigation and Agriculture
type: docs
weight: 10
description: >
  EGI infrastructure for the Disaster Mitigation and Agriculture community
---

This is the documentation to support the **Disaster Mitigation and Agriculture**
community in the Asian Pacific region.

## About the community

Hazard risk estimation and prediction by numerical simulation is crucial to
disaster mitigation studies and applications. The Disaster Mitigation and Agriculture
community investigates in-depth the mechanisms of the selected disaster events and
develops the appropriate simulation models to reproduce the processes by case studies.
The collaboration framework aims at becoming an open science platform of disaster
mitigation so that all the tools, data, resources and simulation facilities are sharable,
and the simulations are reproducible.

This knowledge base is enriched by the simulation models, portals, data and visualisation
facilities that are contributed to by the members:

* Academia Sinica, Taiwan (Leading Partner, represented by
  [Academia Sinica Grid Computing Centre (ASGC)](https://www.twgrid.org/wordpress/))
* [Institute of Earth Science, Academia Sinica, Taiwan](https://www.earth.sinica.edu.tw/en)
* [Research Centre of Environmental Changes, Academia Sinica, Taiwan](https://rcec.sinica.edu.tw/index_en.php)
* [National Central University, Taiwan](https://www.ncu.edu.tw/tw/index.html)
* [Institute Teknologi Bandung (ITB), Indonesia](https://www.itb.ac.id/)
* [Korean Institute of Science and Technology Information (KISTI), Korea](https://www.kisti.re.kr/eng/)
* [Universiti Putra Malaysia (UPM), Malaysia](https://upm.edu.my/)
* [Advanced Science and Technology Institute (ASTI), Philippine](https://asti.dost.gov.ph/)
* [Thailand National Electronics and Computer Technology Centre (NECTEC), Thailand](https://www.nectec.or.th/en/)
* [Leibniz Supercomputing Centre (LRZ), Germany](https://www.lrz.de/english/)
* [University of St. Andrews, United Kingdom](https://www.st-andrews.ac.uk/)

## Researchers

### How to get access

Getting access to the EGI infrastructure consists of the following steps:

1. [Sign-up](../../../aai/check-in/signup/) for an EGI Check-In account.
1. Request to join the `vo.environmental.egi.eu` Virtual Organisation (VO)
    by visiting the [enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:369)
    with your EGI Check-In account. The subscription requires approval from the
    VO Manager.
1. Access the cloud-based resources at CESNET-MCC via the OpenStack Horizon dashboard:
   * [Horizon OpenStack dashboard](https://dashboard.cloud.muni.cz/)
   * Project name: `vo.environmental.egi.eu`
   * Project ID: `29e6fbf618984a0c98ffcdf0222ad815`
   * Network ID: `group-project-network`
   * Security Group: ingress traffic to port 22 (SSH) is enabled
1. Access the EGI Notebooks and the EGI Replay services:
   * EGI Notebooks server URL: [https://notebooks.egi.eu/](https://notebooks.egi.eu/)
   * EGI Replay server URL: [https://replay.notebooks.egi.eu/](https://replay.notebooks.egi.eu/)

### How to bring your scientific application to the EGI infrastructure

The official solution to distribute software in the EGI Infrastructure
is to use [CVMFS](https://cernvm.cern.ch/fs/), the Software
Distribution Service developed to assist High Energy Physics collaborations
at CERN. For more details, please refer to the
[Contend Distribution](../../../compute/software-distribution/) documentation.

The following alternative solutions for sharing scientific software in the
EGI Infrastructure are also available:

* Use the [EGI Applications Database](https://appdb.egi.eu/) (AppDB):
  either [packaging your application in a custom Virtual Machine](../../../compute/cloud-compute/images/)
  or [uploading a Virtual Appliance](https://wiki.appdb.egi.eu/main:faq:how_to_register_a_virtual_appliance).
* Use [Docker](https://www.docker.com/) containers via the
  [EGI Cloud Container Compute Service](../../../compute/cloud-container-compute/).

### How to bring your scientific application in CVMFS

* Access the [VO ID card](https://operations-portal.egi.eu/vo/view/voname/vo.environmental.egi.eu)
  in the EGI Operations Portal.
* Get the VO Admin (or VO Manager) for the `vo.enrivonmental.egi.eu` VO
  (see "Generic contacts" table).
* Request the VO admin to trigger the
  [PROC22](https://ims.egi.eu/display/EGIPP/PROC22+Support+for+CVMFS+replication+across+the+EGI+Infrastructure)
  procedure, if a new software repository has to be created in CVMFS
  for the `vo.environmental.egi.eu` VO.
* Request access to the service (sending an email to cvmfs-support@gridpp.rl.ac.uk)
  to add new content in the CVMFS repository (if the VO is already supported).

### Enable CVMFS with the EGI Notebooks

Sending an email to notebooks-support@mailman.egi.eu to enable
the access to the CVMFS repository in the EGI Notebooks service.

### How to bring your data to the EGI infrastructure

For managing data, different Data Management services are available in the EGI Infrastructure:

* [EGI DataHub](../../../data/management/datahub/)
* [EGI Data Transfer](../../../data/management/data-transfer/)
* [EGI Data Orchestrator](../../../data/management/rucio/)

### How to bring your data in the EGI DataHub from a VM

To access data remotely stored in EGI DataHub like if they were local,
using traditional POSIX command-line commands you need to install the
`oneclient` component. For more details on how to install and configure
the component, please see the
[Access DataHub from a Virtual Machine](../../../tutorials/vm-datahub/)
documentation. [Access via API](../../../data/management/datahub/api/)
is also available and it’s leveraging the integration of the service with EGI Check-in.

In order to access an existing space on EGI DataHub or ask for hosting
your data in DataHub please contact our [Helpdesk](https://ggus.eu/).

Additional tutorials may be relevant:

* [Create a Virtual Machine with Jupyter and DataHub](../../../tutorials/jupyter-datahub-virtual-machine/)

### How to transfer your data to the EGI infrastructure via EGI Data Transfer

[EGI Data Transfer](https://www.egi.eu/service/data-transfer/),
based on the FTS service, allows scientists to
**move any type of data files asynchronously from one storage to another**.
The storage can be either any grid storage in the EGI infrastructure
or a cloud storage implementing the S3 interface.

Relevant tutorials:

* [Data Transfer with Grid Storage](../../../tutorials/data-transfer-grid-storage/)
* [Data Transfer with Object Storage](../../../tutorials/data-transfer-object-storage/)

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

## Service Providers

### How to contribute cloud resources

The steps that an OpenStack cloud provider needs to follow to add resources
to the Disaster Mitigation and Agriculture community
Virtual Organisation (i.e. `vo.environmental.egi.eu`) are available in the
[VO Configuration guide for providers](../../../../providers/cloud-compute/openstack/vo_config).
