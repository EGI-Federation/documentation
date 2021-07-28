---
title: "GPUs"
type: docs
weight: 70
description: >
  GPU resources on EGI Cloud
---

## GPU resources on EGI Cloud

GPUs resources are available on selected providers of the EGI Cloud. These are
available as specific **flavours** that when used to instantiate a Virtual
Machine will make the hardware available to the user.

The table below summarises the available options:

<!-- markdownlint-disable line-length -->

| Site           | VM configuration options               | Flavors                                                                                                                                                                                    | Supported VOs with GPUs                                    | Access conditions                                                                     |
| -------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| IISAS-GPUCloud | up to 2 NVIDIA Tesla K20m              | gpu1cpu6, gpu2cpu12                                                                                                                                                                        | acc-comp.egi.eu, eosc-synergy.eu, enmr.eu, training.egi.eu | Sponsored access for limited testing, conditions to be negotiated for long-term usage |
| IISAS-Nebula   | up to 2 NVIDIA Tesla K20m              | resource_tpl#large_gpu                                                                                                                                                                     | acc-comp.egi.eu, biomed                                    | Sponsored access for limited testing, conditions to be negotiated for long-term usage |
| IFCA-LCG2      | up to 2 NVIDIA T4, up to 2 NVIDIA V100 |                                                                                                                                                                                            |                                                            | Pay-per-use                                                                           |
| CESNET-MCC     | up to 2 NVIDIA T4                      | hpc.8core-64ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-1080-glados, hpc.38core-372ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-2080-glados, hpc.38core-372ram-nvidia-2080-glados | vo.clarin.eu, biomed, eosc-synergy.eu, peachnote.com       | Sponsored, conditions to be negotiated                                                |

<!-- markdownlint-enable line-length -->

## Access to GPU resources on EGI Cloud

GPUs sites can be accessed by different ways: via site-specific dashboards and
endpoints or via common federated-cloud services like common Horizon dashboard,
[VMOps dashboard](../vmops), or [Infrastructure manager](../im).

Site-specific dashboards and endpoints are described in the following table:

<!-- markdownlint-disable line-length -->

| Site           | Openstack Horizon dashboard         | Keystone endpoint                     |
| -------------- | ----------------------------------- | ------------------------------------- |
| IISAS-GPUCloud | `https://nova3.ui.savba.sk/horizon` | `https://keystone3.ui.savba.sk:5000/` |
| IFCA-LCG2      | `https://portal.cloud.ifca.es`      | `https://api.cloud.ifca.es:5000/`     |
| CESNET-MCC     | `https://dashboard.cloud.muni.cz`   | `https://identity.cloud.muni.cz/`     |

<!-- markdownlint-enable line-length -->

A VM image with pre-installed NVIDIA driver and Docker is available at
[AppDB](https://appdb.egi.eu/store/vappliance/nvidia.docker.centos.7). Some VOs
(acc-comp.egi.eu, eosc-synergy.eu) have the image included in the VO image list.

For a more detailed presentation on how to access GPUs in the EGI Federation
please have a look at the [EGI Webinars](https://www.egi.eu/webinars/) on
[27th November 2020](https://indico.egi.eu/event/5271/). There is also a video
recording available on [Youtube](https://youtu.be/vAuYg2oISFc).
