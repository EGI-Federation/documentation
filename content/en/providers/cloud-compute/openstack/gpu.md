---
title: "GPU Flavors"
weight: 50
type: "docs"
description: >
  Configuring GPU flavors
---

## Setting up GPU flavors

- TBC -

## GPU description in flavor metadata

Users should be able to easily discover the flavors that provide GPUs (or
accelerators in general). The following table describes the agreed metadata for
EGI providers to add to those flavors:

| Metadata                       | Definition                                                  | Comments                                                                                                                                                                                                                      |
| ------------------------------ | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Accelerator:Type               | Type of accelerator (e.g. `GPU`)                            | Possible values: `GPU`, `MIC`, `FPGA`, `TPU`, `NPU`                                                                                                                                                                           |
| Accelerator:Number             | Number of accelerators available in the flavor (e.g. `1.0`) | Non integers allowed for the case of sharing GPU between VMs                                                                                                                                                                  |
| Accelerator:Vendor             | Name of accelerator Vendor (e.g. `NVIDIA`)                  |                                                                                                                                                                                                                               |
| Accelerator:Model              | Model of accelerator (e.g. `Tesla V100`)                    | Need to make consensus and enforce. A100 is usually marketed without "Tesla" classname. Similarly, RTX A6000 usually marketed without “GeForce”. For clarity, full names should be used: “Tesla A100” and “GeForce RTX A6000” |
| Accelerator:Version            | Version of the accelerator                                  | Some cards have different versions, e.g. A100 PCIe and NVLink. Openstack does not allow empty value, so we should give 0 if no version is specified                                                                           |
| Accelerator:Memory             | RAM in GBs of the accelerator                               |                                                                                                                                                                                                                               |
| Accelerator:VirtualizationType | Type of virtualisation used (e.g. `PCI passthrough`)        | Not relevant for accounting, but may be still useful in some cases                                                                                                                                                            |

There are some extra fields that are defined in the GLUE2.1 schema but not so
relevant for GPUs and therefore not considered at the moment. These are listed
below for completeness:

| Metadata                      | Definition                         | Comments                                                                                                                             |
| ----------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Accelerator:ComputeCapability | Compute capabilities               | Defined by GLUE2.1, e.g. floating point type, NVLink, ... may be used informally so far                                 |
| Accelerator:ClockSpeed        | Clockspeed of accelerator          | Defined by GLUE2.1, not so relevant, as ClockSpeed no longer related to performance. May be reserved for other types of accelerators |
| Accelerator:Cores             | Number of cores of the accelerator | Not so useful as there are several types of cores now (CUDA, tensor). May be reserved for other types of accelerators                |

Adding metadata to flavors has no effects on site operations. End-users can see
the metadata easily via `openstack flavor list --long` or
`openstack flavor show <flavor id>` commands without any additional tools, e.g.:

```shell
$ fedcloud openstack flavor show gpu1cpu2  --site IISAS-GPUCloud --vo eosc-synergy.eu -f json
Site: IISAS-GPUCloud, VO: eosc-synergy.eu
{
  "OS-FLV-DISABLED:disabled": false,
  "OS-FLV-EXT-DATA:ephemeral": 0,
  "access_project_ids": null,
  "disk": 40,
  "id": "a8082202-f647-4d1f-9b97-4f5ddb38ae8e",
  "name": "gpu1cpu2",
  "os-flavor-access:is_public": false,
  "properties": "Accelerator:Version='0', Accelerator:Memory='5', Accelerator:Model='Tesla K20m', Accelerator:Number='1.0', Accelerator:Type='GPU', Accelerator:Vendor='NVIDIA', Accelerator:VirtualizationType='PCI passthrough', pci_passthrough:alias='GPU:1'",
  "ram": 8192,
  "rxtx_factor": 1.0,
  "swap": "",
  "vcpus": 2
}
```
