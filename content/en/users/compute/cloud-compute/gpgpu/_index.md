---
title: GPUs
type: docs
weight: 55
aliases:
  - /users/cloud-compute/gpgpu
description: >
  GPU resources in the EGI Cloud
---

## GPU resources on EGI Cloud

GPUs resources are available on selected providers of the EGI Cloud. These are
available as specific **flavours** that when used to instantiate a Virtual
Machine will make the hardware available to the user.

The table below summarises the available options:

<!-- markdownlint-disable line-length -->

| Site | VM configuration options | Flavors | Supported VOs with GPUs | Access conditions | More information |
| ---- | ------------------------ | ------- | ----------------------- | ----------------- | ---------------- |
| IISAS-FedCloud | up to 7 NVIDIA A100 40GB, up to 8 NVIDIA Tesla K20m | g1.c08r30-K20m, g1.c16r60-2xK20m, A100 GPUs accessible using private flavors | vo.access.egi.eu, training.egi.eu, eosc-synergy.eu, vo.ai4eosc.eu, icecube, vo.beamide.com | Sponsored, conditions to be negotiated | |
| IFCA-LCG2 | up to 80 NVIDIA T4, up to 20 NVIDIA V100 | | | Pay-per-use | [IFCA-LCG2 Documentation](https://confluence.ifca.es/display/IC/Cloud+Compute+Flavors) |
| CESNET-MCC | up to 2 NVIDIA Tesla T4, up to 4 NVIDIA A40, up to 2 GeForce RTX 1080/2080 (experimental use only) | hpc.8core-64ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-2080-glados, hpc.32core-256ram-nvidia-t4-single-gpu, hpc.64core-238ram-nvidia-t4, hpc.64core-512ram-nvidia-t4, meta-hdm.16core-120ram-nvidia-a40, meta-hdm.64core-485ram-nvidia-a40-quad | vo.clarin.eu, biomed, eosc-synergy.eu, peachnote.com, cryoem.instruct-eric.eu, fusion, icecube, vo.carouseldancing.org, vo.pangeo.eu, vo.neanias.eu, umsa.cerit-sc.cz, vip, vo.notebooks.egi.eu, vo.emphasisproject.eu, vo.inactive-sarscov2.eu | Sponsored, conditions to be negotiated | [CESNET-MCC Documentation](https://docs.cloud.muni.cz/cloud/gpus/) |
| IN2P3-IRES | up to 1 NVIDIA Tesla T4 per VM, up to 1 NVIDIA A40 per VM, up to 4 GeForce RTX 2080 per VM (experimental use only) | g1.xlarge-4xmem, g2.xlarge-4xmem, g4.xlarge-4xmem | biomed, vo.emphasisproject.eu, vo.france-grilles.fr | Sponsored, conditions to be negotiated | |

<!-- markdownlint-enable line-length -->

## Access to GPU resources on EGI Cloud

Check whether you belong to one of the supported
[Virtual Organisations (VOs)](https://confluence.egi.eu/display/EGIG/Virtual+organisation).
If you are not sure what VO to join, request access to the pilot VO
[vo.access.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.access.egi.eu)
by visiting the [enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:240)
with your Check-In account. More information is available in the
[Check-in](../../../aai//check-in/joining-virtual-organisation) section.

GPUs sites can be accessed in different ways: via site-specific dashboards and
endpoints or via common federated-cloud services like the OpenStack Horizon
dashboards, [VMOps Dashboard](../monitor), or a [cloud orchestrator](../automate).

It is also possible to use the
[FedCloud Client](../../../getting-started/cli) for command-line access. Below is
an example on how to use the `fedcloud` command to show the GPU properties of
the available GPU flavors on all sites for the specific VO in the command:

```shell
fedcloud openstack flavor list --long --site ALL_SITES --vo vo.access.egi.eu --json-output | \
    jq -r 'map(select(."Error code" ==  0)) |
           map(.Result = (.Result| map(select(.Properties."Accelerator:Type" == "GPU")))) |
           map(select(.Result | length >  0))'
```

Site-specific dashboards and endpoints are described in the following table:

<!-- markdownlint-disable line-length -->

| Site           | Openstack Horizon dashboard       | Keystone endpoint                    |
| -------------- | --------------------------------- | ------------------------------------ |
| IISAS-FedCloud | `https://cloud.ui.savba.sk`       | `https://cloud.ui.savba.sk:5000/v3/` |
| IFCA-LCG2      | `https://portal.cloud.ifca.es`    | `https://api.cloud.ifca.es:5000/`    |
| CESNET-MCC     | `https://dashboard.cloud.muni.cz` | `https://identity.cloud.muni.cz/`    |

<!-- markdownlint-enable line-length -->

A VM image with pre-installed NVIDIA driver and Docker is available at
[AppDB](https://appdb.egi.eu/store/vappliance/nvidia.docker.centos.7). Some VOs
(vo.access.egi.eu, eosc-synergy.eu) have the image included in the VO image list.
