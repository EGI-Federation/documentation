---
title: "Disaster Mitigation and Agriculture community"
linkTitle: "Disaster Mitigation and Agriculture community"
type: docs
weight: 150
description: >
  How to to use the EGI infrastructure for Disaster Mitigation and Agriculture community
---

This is the documentation to suppor the Disaster Mitigation and Agriculture community.

## Researchers

### How to get access

Getting access to the EGI infrastructure consist of the following steps:

1. [Sign-up](../../../aai/check-in/signup/) for an EGI Check-In account.
1. Request to join the `vo.environmental.egi.eu`
   [Virtual Organisation (VO)](https://confluence.egi.eu/display/EGIG/Virtual+organisation)
   by visiting the [enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:369)
   with your EGI Check-In account. The subscription requires approval from the
   VO Manager. For further information, please check the
   [VO ID card](https://operations-portal.egi.eu/vo/view/voname/vo.environmental.egi.eu).
1. Access the cloud-based resources at CESNET-MCC:
   * [Horizon OpenStack dashboard](https://dashboard.cloud.muni.cz/)
   * Project name: `vo.environmental.egi.eu`
   * Project ID: `29e6fbf618984a0c98ffcdf0222ad815`
   * Network ID: `group-project-network`
   * Security Group: ingress traffic to port 22 (SSH) is enabled

### How to bring your scientific application to the EGI infrastructure

The official solution to distribute software in the EGI Infrastructure
is to use [CVMFS](https://cernvm.cern.ch/fs/), the Software
Distribution Service developed to assist High Energy Physics collaborations
at CERN. For more details, please refer to the
[CVMFS](../../../compute/content-distribution/) documentation.

The following alternative solutions to share scientific software in the
EGI Infrastructure are also possible:
* Use the [EGI Applications Database](http://appdb.egi.eu/) (AppDB):
  either [packaging your application in a custom Virtual Machine](../../../compute/cloud-compute/images/)
  or [uploading a Virtual Appliance](https://wiki.appdb.egi.eu/main:faq:how_to_register_a_virtual_appliance).
* Use [Docker](https://www.docker.com/) containers.

### How to bring your data to the EGI infrastructure

Different Data Management services are available in the EGI Infrastructure for dealing with data:
* [EGI DataHub](../../../data/management/datahub/)
* [EGI Data Transfer](../../../data/management/data-transfer/)
* [EGI Data Orchestrator](../../../data/management/rucio/)
* [OpenRDM](../../../data/management/open-rdm/)

For more information, please see the [Data Management section](../../../data/management/).

## Service Providers

### How to contribute cloud resources

The steps that an OpenStack cloud provider needs to follow to add resources
to the Disaster Mitigation and Agriculture community 
[Virtual Organisation](https://confluence.egi.eu/display/EGIG/Virtual+organisation)
(i.e. `vo.environmental.egi.eu`) are available in the
[VO Configuration guide for providers](../../../../providers/cloud-compute/openstack/vo_config/).
