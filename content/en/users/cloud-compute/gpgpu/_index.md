---
title: "GPUs"
type: docs
weight: 70
description: >
  GPU resources on EGI Cloud
---

GPUs resources are available on selected providers of the EGI Cloud.
These are available as specific **flavors** that when used to
instantiate a Virtual Machine will make the hardware available to the
user.

The table below summarises the available options:


| Site | VM configuration options | Flavors | Supported VOs with GPUs | Access conditions |
| ---- | ------------------------ | ------- | ----------------------- | ----------------- |
| IISAS-GPUCloud | up to 2 NVIDIA Tesla K20m | gpu1cpu6, gpu2cpu12 | acc-comp.egi.eu, eosc-synergy.eu, enmr.eu, training.egi.eu | Sponsored access for limited testing, conditions to be negotiated for long-term usage |
| IISAS-Nebula | up to 2 NVIDIA Tesla K20m | resource_tpl#large_gpu | acc-comp.egi.eu, biomed | Sponsored access for limited testing, conditions to be negotiated for long-term usage |
| IFCA-LCG2 | up to 4 NVIDIA GT200GL | | | Pay-per-use |
| IFCA-LCG2 | up to 1 NVIDIA TITAN X | | | Pay-per-use |
| IFCA-LCG2 | up to 10 NVIDIA GeForce GTX 1080Ti | | | Pay-per-use |
| CESNET-MCC | up to 2 NVIDIA T4 | hpc.8core-64ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-1080-glados, hpc.38core-372ram-nvidia-1080-glados, hpc.19core-176ram-nvidia-2080-glados, hpc.38core-372ram-nvidia-2080-glados | vo.clarin.eu, biomed, eosc-synergy.eu, peachnote.com |Sponsored, conditions to be negotiated |
