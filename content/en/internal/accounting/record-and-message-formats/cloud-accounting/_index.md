---
title: "Cloud Accounting"
linkTitle: "Cloud"
weight: 30
type: "docs"
description: "EGI Cloud Accounting record and message formats"
---

## Individual VM Records and Messages

### Header

`APEL-cloud-message: v0.4`

The header only appears once at the top of each message (that is once at the
top of each file). It defines the type of record and the schema version.

### Record Fields

The federated cloud task force has agreed on a Cloud Usage Record, which
inherits from the [OGF Usage Record (GFD.204)](https://ogf.org/documents/GFD.204.pdf).
This record defines the data that resource providers must send to EGI's central
Accounting repository.

Version 0.4 of the Cloud Accounting Usage Record was agreed at the FedCloud Face
to Face in Amsterdam in January 2015. A summary table of the format is shown
below:

<!-- markdownlint-disable line-length -->

| Cloud Usage Record Property | Type            | Null | Definition                                                                                                                                                                                                                                                  |
| --------------------------- | --------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| VMUUID                      | `varchar(255)`  | No   | Virtual Machine\'s Universally Unique Identifier concatenation of CurrentTime, SiteName and MachineName                                                                                                                                            |
| SiteName                    | `varchar(255)`  | No   | GOCDB SiteName - GOCDB now has cloud service types and a cloud-only site is allowed.                                                                                                                                                               |
| CloudComputeService (NEW)   | `varchar(255)`  |      | Name identifying cloud resource within the site. Allows multiple cloud resources within a site, i.e. a level of granularity.                                                                                                                       |
| MachineName                 | `varchar(255)`  | No   | VM ID - the site name for the VM                                                                                                                                                                                                                   |
| LocalUserId                 | `varchar(255)`  |      | Local username                                                                                                                                                                                                                                     |
| LocalGroupId                | `varchar(255)`  |      | Local group name                                                                                                                                                                                                                                   |
| GlobalUserName              | `varchar(255)`  |      | Global identity of user (certificate DN)                                                                                                                                                                                                           |
| FQAN                        | `varchar(255)`  |      | Use if VOs part of authorization mechanism                                                                                                                                                                                                         |
| Status                      | `varchar(255)`  |      | Completion status - completed, started or suspended                                                                                                                                                                                                |
| StartTime                   | `datetime`      |      | Must be set when Status = started                                                                                                                                                                                                                  |
| EndTime                     | `datetime`      |      | Set to NULL until Status = completed                                                                                                                                                                                                               |
| SuspendDuration             | `datetime`      |      | Set when Status = suspended (Timestamp)                                                                                                                                                                                                            |
| WallDuration                | `int`           |      | WallClock time - actual time used                                                                                                                                                                                                                  |
| CpuDuration                 | `int`           |      | CPU time consumed (Duration)                                                                                                                                                                                                                       |
| CpuCount                    | `int`           |      | Number of CPUs allocated                                                                                                                                                                                                                           |
| NetworkType                 | `varchar(255)`  |      | Needs clarifying                                                                                                                                                                                                                                   |
| NetworkInbound              | `int`           |      | GB received                                                                                                                                                                                                                                        |
| NetworkOutbound             | `int`           |      | GB sent                                                                                                                                                                                                                                            |
| PublicIPCount (NEW)         | `int`           |      | Number of public IP addresses assigned to VM **Not used**.                                                                                                                                                                                         |
| Memory                      | `int`           |      | Memory allocated to the VM                                                                                                                                                                                                                         |
| Disk                        | `int`           |      | Size in GB allocated to the VM                                                                                                                                                                                                                     |
| BenchmarkType (NEW)         | `varchar(255)`  |      | Name of benchmark used for normalization of times (eg HEPSPEC06)                                                                                                                                                                                   |
| Benchmark (NEW)             | `Decimal`       |      | Value of benchmark of VM using ServiceLevelType benchmark’                                                                                                                                                                                         |
| StorageRecordId             | `varchar(255)`  |      | Link to other associated storage record _Need to check feasibility_                                                                                                                                                                                |
| ImageId                     | `varchar(255)`  |      | Every image has a unique ID associated with it. For images from the Artecfact Registry this should be `VMCATCHER_EVENT_AD_MPURI`; for images from other repositories it should be an equivalent; for local images - local identifier of the image. |
| CloudType                   | `varchar(255)`  |      | Type of cloud infrastructure: OpenNebula; OpenStack; Synnefo; etc.                                                                                                                                                                                 |

<!-- markdownlint-enable line-length -->

### Message

#### End of record

```
%%
```

#### Example Message

```text
APEL-cloud-message: v0.4
SiteName: SAMPLE-SITE
CloudComputeService: host.example.com
CloudType: caso/5.2.1 (OpenStack)
CpuCount: 2
CpuDuration: 31359976
Disk: 80
EndTime: 0
FQAN: vo.sample.org
LocalGroupId: foo-bar
LocalUserId: baz
MachineName: vm-name
Memory: 4096
PublicIPCount: 1
StartTime: 1764592012
Status: started
VMUUID: 12345678-1234-5678-9012-123456789012
WallDuration: 15679988
%%
...another VM record...
%%
...
%%
```

## IP Records

The fedcloud task force has agreed on a Public IP Usage Record. The format uses many
of the same fields as the Cloud Usage Record. The Usage Record should be a
snapshot of the number of IPs currently assigned to a user. A table defining
v0.2 of the format is shown below:

<!-- markdownlint-disable line-length -->

| Cloud Usage Record Property | Type           | Null | Definition                                                                   | Notes                                                                                                                                                                    |
| --------------------------- | -------------- | ---- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| MeasurementTime             | `datetime`     | No   | The time the usage was recorded.                                             | In the message format, must be a UNIX timestamp, i.e. the number of seconds that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970) |
| SiteName                    | `varchar(255)` | No   | The GOCDB site assigning the IP                                              |                |
| CloudComputeService         | `varchar(255)` | Yes  | See Cloud Usage Record                                                       |                |
| CloudType                   | `varchar(255)` | No   | See Cloud Usage Record                                                       |                |
| LocalUser                   | `varchar(255)` | No   | See Cloud Usage Record                                                       |                |
| LocalGroup                  | `varchar(255)` | No   | See Cloud Usage Record                                                       |                |
| GlobalUserName              | `varchar(255)` | No   | See Cloud Usage Record                                                       |                |
| FQAN                        | `varchar(255)` | No   | See Cloud Usage Record                                                       |                |
| IPVersion                   | `byte`         | No   | 4 or 6                                                                       |                |
| IPCount                     | `int(11)`      | No   | The number of IP addresses of IPVersion this user currently assigned to them |                |

<!-- markdownlint-enable line-length -->

A JSON schema defining a valid Public IP Usage message can be found at:
<https://github.com/apel/apel/blob/9476bd86424f6162c3b87b6daf6b4270ceb8fea6/apel/db/__init__.py>

## GPU Records

The fedcloud task force has agreed on an GPU Usage Record. The format uses many
of the same fields as the Cloud Usage Record. A table defining _Draft 4 –
24/02/2021_ is shown below:

<!-- markdownlint-disable line-length -->

| GPU Usage Record Property | Type           | Null | Definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------- | -------------- | ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| MeasurementMonth          | `int`          | No   | The month/year the reported usage should be assigned to. If the month/year is the current month/year, the usage should be up to the point of reporting.                                                                                                                                                                                                                                                                                                                                                                     |
| MeasurementYear           | `int`          | No   |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |     |
| AssociatedRecordType      | `varchar(255)` | No   | The context in which the reported usage was used. I.e. “cloud” for an accelerator attached to a VM.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| AssociatedRecord          | `varchar(255)` | No   | VMUUID if AssociatedRecordType is “cloud”                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| GlobalUserName            | `varchar(255)` | Yes  | See the definition of your AssociatedRecordType                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| FQAN                      | `varchar(255)` | No   | See the definition of your AssociatedRecordType                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| SiteName                  | `varchar(255)` | No   | See the definition of your AssociatedRecordType                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Count                     | `decimal`      | No   | A count of the Accelerators attached to the VM. At the moment Accelerators are not shared among VMs but it will change when Accelerator virtualization is applied, so we should have the field at decimal type instead of integer (e.g. Count = 0.5 when it is shared between two VMs).                                                                                                                                                                                                                                     |
| Cores                     | `int(11)`      | Yes  | Total number of cores. i.e. So if an Accelerator has 64 cores and a VM has 2 like that attached then we would report: Count=2 and Processors=128                                                                                                                                                                                                                                                                                                                                                                            |
| ActiveDuration            | `int(11)`      | Yes  | Actual usage duration of the Accelerator in seconds for the given month/year (in case some systems could report actual usage). At the moment, ActiveDuration will be the same as the AvailableDuration due to the limitation of currently used technologies (impossible to get ACCELERATOR utilization from outside of the VM, no ACCELERATOR hot-plug into running VM) but it may change in near future so it is good to have the fields separately. Set to AvailableDuration if ActiveDuration is omitted from the record |
| AvailableDuration         | `int(11)`      | No   | Time accelerator was available in seconds for the given month/year (Wall)Time that a GPU was attached to a VM.                                                                                                                                                                                                                                                                                                                                                                                                              |
| BenchmarkType             | `varchar(255)` | Yes  | Name of benchmark used for normalization of times                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Benchmark                 | `decimal`      | Yes  | Value of benchmark of Accelerator                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Type                      | `varchar(255)` | No   | High level description of accelerator, i.e. GPU, FPGA, Other                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Model                     | `varchar(255)` | Yes  | model number, spec, some other concept that 2 ACCELERATORs with the same number of cores might be different etc                                                                                                                                                                                                                                                                                                                                                                                                             |

<!-- markdownlint-enable line-length -->

### Sample message

Records are sent as a json payload as shown in the following sample:

```json
{
  "Type": "APEL-accelerator-message",
  "Version": "0.1",
  "UsageRecords": [
    {
      "SiteName": "SAMPLE-SITE",
      "CloudType": "caso/5.2.1 (OpenStack)",
      "CloudComputeService": "host.example.com",
      "AssociatedRecord": "12345678-1234-5678-9012-123456789012",
      "FQAN": "vo.sample.org",
      "Count": 4,
      "AvailableDuration": 2592000,
      "MeasurementMonth": 4,
      "MeasurementYear": 2026,
      "AssociatedRecordType": "cloud",
      "Type": "GPU",
      "Model": "NVIDIA Tesla V100",
      "ActiveDuration": 2592000
    },
    { ... another GPU record ... }
  ]
}
```
