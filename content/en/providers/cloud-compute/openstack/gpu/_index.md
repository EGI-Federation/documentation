---
title: "GPU flavours"
weight: 50
type: "docs"
description: >
  Configuring GPU flavours
---

## Setting up GPU flavours

Support for GPU can be added to flavours using the
[PCI passthrough feature in OpenStack](https://docs.openstack.org/nova/xena/admin/pci-passthrough.html).
This allows to plug any kind of PCI device to the Virtual Machines.

As a summary of the OpenStack documentation, these are the steps needed to add a
GPU enabled flavour (be aware this may need tuning to your specific
hardware/configuration!):

1. On computing node, get vendor/product ID of your hardware:
   `lspci | grep NVIDIA` to get pci slot of GPU, then
   `virsh nodedev-dumpxml pci_xxxx_xx_xx_x`
1. On computing node, unbind device from host kernel driver. Unbinding is system
   dependent, and can be done in many ways, e.g.:
   - if the kernel does not uses the devices (no GPU drivers included in kernel,
     or drivers disable in GRUB), nothing to unbind
   - via pci-stub
     `grubby --args="pci-stub.ids=10de:11fa" --update-kernel DEFAULT` (see
     [RedHat manual, section 12.1, step 1-2](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/configuring_and_managing_virtualization/index#proc_assigning-a-gpu-to-a-virtual-machine_assembly_managing-gpu-devices-in-virtual-machines);
     where the `pci-stub.ids` value is `vendor_ID: product_id` from `lspci`.
   - via echo command: `echo $dev > /sys/bus/pci/devices/$dev/driver/unbind`
     where `$dev` is the PCI device ID `xx:xx.x` or `xxxx:xx:xx.x` from `lspci`
1. On computing node, add
   `pci_passthrough_whitelist = {"vendor_id":"xxxx","product_id":"xxxx"}` to
   `nova.conf` (see
   [nova-compute](https://docs.openstack.org/nova/xena/admin/pci-passthrough.html#configure-nova-compute))
1. On controller node, add
   `pci_alias = {"vendor_id":"xxxx","product_id":"xxxx", "name":"GPU"}` to
   `nova.conf` (see
   [nova-api](https://docs.openstack.org/nova/xena/admin/pci-passthrough.html#configure-nova-scheduler))
1. On controller node, enable `PciPassthroughFilter` in the scheduler (see
   [nova-scheduler](https://docs.openstack.org/nova/xena/admin/pci-passthrough.html#configure-nova-scheduler))
1. Create new flavours with `pci_passthrough:alias` (or add key to existing
   flavour), e.g.
   `openstack flavor set m1.large --property "pci_passthrough:alias"="GPU:2"`

## GPU description in flavour metadata

Users should be able to easily discover the flavours that provide GPUs (or
accelerators in general). The following table describes the agreed metadata for
EGI providers to add to those flavours:

| Metadata                       | Definition                                                  | Comments                                                                                                                                                                                                                      |
| ------------------------------ | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Accelerator:Type               | Type of accelerator (e.g. `GPU`)                            | Possible values: `GPU`, `MIC`, `FPGA`, `TPU`, `NPU`                                                                                                                                                                           |
| Accelerator:Number             | Number of accelerators available in the flavour (e.g. `1.0`) | Non integers allowed for the case of sharing GPU between VMs                                                                                                                                                                  |
| Accelerator:Vendor             | Name of accelerator Vendor (e.g. `NVIDIA`)                  |                                                                                                                                                                                                                               |
| Accelerator:Model              | Model of accelerator (e.g. `Tesla V100`)                    | Need to make consensus and enforce. A100 is usually marketed without "Tesla" classname. Similarly, RTX A6000 usually marketed without “GeForce”. For clarity, full names should be used: “Tesla A100” and “GeForce RTX A6000” |
| Accelerator:Version            | Version of the accelerator                                  | Some cards have different versions, e.g. A100 PCIe and NVLink. Openstack does not allow empty value, so we should give 0 if no version is specified                                                                           |
| Accelerator:Memory             | RAM in GB of the accelerator                                |                                                                                                                                                                                                                               |
| Accelerator:VirtualizationType | Type of virtualisation used (e.g. `PCI passthrough`)        | Not relevant for accounting, but may be still useful in some cases                                                                                                                                                            |

There are some extra fields that are defined in the GLUE2.1 schema but not so
relevant for GPUs and therefore not considered at the moment. These are listed
below for completeness:

| Metadata                      | Definition                         | Comments                                                                                                                             |
| ----------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Accelerator:ComputeCapability | Compute capabilities               | Defined by GLUE2.1, e.g. floating point type, NVLink, ... may be used informally so far                                              |
| Accelerator:ClockSpeed        | Clockspeed of accelerator          | Defined by GLUE2.1, not so relevant, as ClockSpeed no longer related to performance. May be reserved for other types of accelerators |
| Accelerator:Cores             | Number of cores of the accelerator | Not so useful as there are several types of cores now (CUDA, tensor). May be reserved for other types of accelerators                |

Adding metadata to flavours has no effects on site operations. End users can see
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
