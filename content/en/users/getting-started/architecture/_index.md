---
title: "EGI Architecture"
linkTitle: "Architecture"
type: docs
weight: 10
description: >
  The architecture of the EGI Federation
---

The EGI Federated Cloud (FedCloud) is a multi-national cloud system that
integrates community, private and/or public clouds into a scalable computing
platform for research. The Federation pools resources from a heterogeneous set
of cloud providers using a single authentication and authorisation framework
that allows the portability of workloads across multiple providers, and enables
bringing computing to data. The current implementation is focused on
Infrastructure-as-a-Service (IaaS) services, but can be easily applied to
Platform-as-a-Service (PaaS) and Software-as-a-Servcice (SaaS) layers.

Each resource centre of the federated infrastructure operates a _Cloud
Management Framework (CMF)_ according to its own preferences and constraints and
joins the federation by integrating this CMF with components of the EGI service
portfolio. CMFs must at least be integrated with EGI Authentication and
Authorization Infrastructure (AAI) so users can access services with a single
identity, integration with other components and APIs to be provided are agreed
by the community the resource centre provides services to.

EGI follows a Service Integration and Management (SIAM) approach to manage the
federation with processes that cover the different aspects of the IT Service
Management. Providers in the federation keep complete control of their services
and resources. EGI creates Virtual Organizations (VOs) for each research
community, and EGI VO Operation Level Agreements (OLAs) establish a reliable,
trust-based communication channel between the community and the providers, by
agreeing on the services, their levels and the types of support.

{{% alert title="Note" color="info" %}} EGI VO OLAs are not legal contracts but,
as agreements, they outline the clear intentions to collaborate and support
research. {{% /alert %}}

## Federated IaaS

The EGI FedCloud IaaS resource centres deploy a Cloud Management Framework (CMF)
that provide users with an API-based service for management of Virtual Machines
and associated Block Storage to enable persistence and Networks to enable
connectivity of the Virtual Machines (VMs) among themselves and third party
resources.

The IaaS federation is a thin layer that brings the providers together with:

- [Federated authentication](#authentication-and-authorization)
- [Resource discovery](#information-discovery)
- [Central VM image catalogue](#virtual-machine-image-management)
- [Usage accounting](#accounting)
- [Monitoring](#monitoring)

The IaaS capabilities (VM, block storage, network management, etc.) must be
provided via community agreed APIs
([OpenStack](https://docs.openstack.org/wallaby/api/) is supported at the
moment) that allow integration with [EGI Check-in](../../aai/check-in) for
authentication and authorisation of users.

{{% alert title="Note" color="info" %}} Those providers that limit the
interaction to web dashboards and do not expose APIs to direct consumption for
users cannot be considered part of the EGI IaaS Cloud services. {{% /alert %}}

Users and Community platforms built on top of the EGI IaaS can interact with the
cloud providers at three different layers:

- Directly using the IaaS APIs or [CLIs](../cli) to manage individual resources.
  This option is recommended for preexisting use cases with requirements on
  specific APIs.
- Using federated access tools that allow managing the complexity of dealing
  with different providers in a uniform way. These tools include:
  - **Provisioning systems** allow users to define infrastructure as code, then
    manage and combine resources from different providers, thus enabling the
    portability of application deployments between them (e.g.
    [Infrastructure Manager](../../compute/orchestration/im) or
    [Terraform](https://www.terraform.io/)), and
  - **Cloud brokers** provide matchmaking for workloads to available providers
    (e.g. the
    [INDIGO-DataCloud Orchestrator](https://indigo-dc.gitbook.io/indigo-paas-orchestrator/)).
- Using the [VMOps dashboard](../../compute/cloud-compute/monitor).

EGI provides ready-to-use software components to enable the federation for
OpenStack. These components rely on public APIs of the IaaS system and use
[Check-in](../../aai/check-in) accounts for authenticating into the provider.

## Implementation

### Authentication and authorization

Federated identity ensures that users of the federation can use a single account
for accessing the resources.

#### OpenID Connect

Providers of the EGI Cloud support authentication with OAuth2 tokens provided by
Check-in OpenID Connect Identity provider. Support builds on the
[AAI guide for SPs](../../../providers/check-in/sp) with detailed configuration
provided at the
[EGI IaaS Service providers documentation](../../../providers/cloud-compute/openstack/#openid-connect-support).

The integration relies on the OpenStack Keystone
[OS-FEDERATION API](https://developer.openstack.org/api-ref/identity/v3-ext/index.html#os-federation-api).

### Information discovery

The [Configuration Database](#configuration-database) contains the list of
resource centres and their endpoints, while the [AppDB](https://appdb.egi.eu/)
Information System collects this information in a central service for discovery,
providing a real-time view of the actual capabilities of federation participants
(can be used by both human users and machine services).

#### Configuration Database

The EGI [Configuration Database](../../../internal/configuration-database) is
used to catalogue the static information of the production infrastructure
topology (e.g. the list of resource centres and their endpoints).

To allow resource providers to expose IaaS federation endpoints, the following
service types are available:

- `org.openstack.horizon`
- `org.openstack.nova`
- `org.openstack.swift`
- `eu.egi.cloud.accounting`
- `eu.egi.cloud.vm-metadata.marketplace`

All providers **must** enter cloud service endpoints into the Configuration
Database to enable integration with EGI.

The [Cloud Info Provider](https://github.com/EGI-Federation/cloud-info-provider)
extracts information from the resource centres using their native APIs and
formats it following Glue, an OGC recommended standard. This information is
pushed to the Argo Messaging System and consumed by
[AppDB](https://appdb.egi.eu/) to provide a central information discovery
service that aggregates several other sources of information about the
infrastructure.

### Virtual Machine Image management

In a distributed, federated IaaS service, users need solutions for efficiently
managing and distributing their VM images across multiple resource providers.
EGI provides a catalogue of VM images (VMIs) that allows any user to share their
VMI, and communities to select those VMIs relevant for distribution across
providers. These images are automatically replicated at the providers supporting
the community and converted as needed to ensure the correct instantiation when
used.

AppDB includes a
[Virtual Appliance Marketplace](https://appdb.egi.eu/browse/cloud) supporting
Virtual Appliances (VAs), which are clean and lean virtual machine images
designed to run on a virtualisation platform, that provide a software solution
out-of-the-box, ready to be used with minimal or no set-up.

AppDB allows representatives of research communities (VOs) to generate a VM
image list that resource centres subscribe to. The subscription enables the
periodic download, conversion and storage of those images to the image
repository of the indicated resource centres, using HEPiX image list format.
[cloudkeeper](https://github.com/the-cloudkeeper-project/cloudkeeper) provides
this automated synchronisation between AppDB and the cloud provider.

### Accounting

[Federated Accounting](../../../internal/accounting) provides an integrated view
about resource/service usage: it pulls together usage information from the
federated sites and services, integrates the data and presents them in such a
way that both individual users as well as whole communities can monitor their
own resource/service usage across the whole federation.

Usage of resources is gathered centrally using EGI Accounting repository and
available for visualisation at
[EGI Accounting portal](https://accounting.egi.eu).

#### Cloud Usage Record

The federated cloud task force has agreed on a Cloud Usage Record, which
inherits from the [OGF Usage Record](https://www.ogf.org/documents/GFD.98.pdf).
This record defines the data that resource providers must send to EGI's central
Accounting repository.

Version 0.4 of the Cloud Accounting Usage Record was agreed at the FedCloud Face
to Face in Amsterdam in January 2015. A summary table of the format is shown
below:

<!-- markdownlint-disable line-length -->

| Cloud Usage Record Property | Type            | Null | Definition                                                                                                                                                                                                                                                  |
| --------------------------- | --------------- | ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| VMUUID                      | `varchar(255)`  | No   | Virtual Machine\'s Universally Unique Identifier concatenation of CurrentTime, SiteName and MachineName                                                                                                                                                     |
| SiteName                    | `varchar(255)`  | No   | GOCDB SiteName - GOCDB now has cloud service types and a cloud-only site is allowed.                                                                                                                                                                        |
| CloudComputeService (NEW)   | `varchar(255)`  |      | Name identifying cloud resource within the site. Allows multiple cloud resources within a site, i.e. a level of granularity.                                                                                                                                |
| MachineName                 | `varchar(255)`  | No   | VM ID - the site name for the VM                                                                                                                                                                                                                            |
| LocalUserId                 | `varchar(255)`  |      | Local username                                                                                                                                                                                                                                              |
| LocalGroupId                | `varchar(255)`  |      | Local group name                                                                                                                                                                                                                                            |
| GlobalUserName              | `varchar(255)`  |      | Global identity of user (certificate DN)                                                                                                                                                                                                                    |
| FQAN                        | `varchar(255)`  |      | Use if VOs part of authorization mechanism                                                                                                                                                                                                                  |
| Status                      | `varchar(255)`  |      | Completion status - completed, started or suspended                                                                                                                                                                                                         |
| StartTime                   | `datetime`      |      | Must be set when Status = started                                                                                                                                                                                                                           |
| EndTime                     | `datetime`      |      | Set to NULL until Status = completed                                                                                                                                                                                                                        |
| SuspendDuration             | `datetime`      |      | Set when Status = suspended (Timestamp)                                                                                                                                                                                                                     |
| WallDuration                | `int`           |      | WallClock time - actual time used                                                                                                                                                                                                                           |
| CpuDuration                 | `int`           |      | CPU time consumed (Duration)                                                                                                                                                                                                                                |
| CpuCount                    | `int`           |      | Number of CPUs allocated                                                                                                                                                                                                                                    |
| NetworkType                 | `varchar(255)`  |      | Needs clarifying                                                                                                                                                                                                                                            |
| NetworkInbound              | `int`           |      | GB received                                                                                                                                                                                                                                                 |
| NetworkOutbound             | `int`           |      | GB sent                                                                                                                                                                                                                                                     |
| PublicIPCount (NEW)         | `int`           |      | Number of public IP addresses assigned to VM **Not used**.                                                                                                                                                                                                  |
| Memory                      | `int`           |      | Memory allocated to the VM                                                                                                                                                                                                                                  |
| Disk                        | `int`           |      | Size in GB allocated to the VM                                                                                                                                                                                                                              |
| BenchmarkType (NEW)         | `varchar(255)`  |      | Name of benchmark used for normalization of times (eg HEPSPEC06)                                                                                                                                                                                            |
| Benchmark (NEW)             | `Decimal`       |      | Value of benchmark of VM using ServiceLevelType benchmark’                                                                                                                                                                                                  |
| StorageRecordId             | `varchar(255)`  |      | Link to other associated storage record _Need to check feasibility_                                                                                                                                                                                         |
| ImageId                     | `varchar(255)`  |      | Every image has a unique ID associated with it. For images from the EGI FedCloud AppDB this should be `VMCATCHER_EVENT_AD_MPURI`; for images from other repositories it should be a vmcatcher equivalent; for local images - local identifier of the image. |
| CloudType                   | `varchar(255)`  |      | Type of cloud infrastructure: OpenNebula; OpenStack; Synnefo; etc.                                                                                                                                                                                          |

<!-- markdownlint-enable line-length -->

#### Public IP Usage Record

The fedcloud task force has agreed on an IP Usage Record. The format uses many
of the same fields as the Cloud Usage Record. The Usage Record should be a
\"snapshot\" of the number of IPs currently assigned to a user. A table defining
v0.2 of the format is shown below:

<!-- markdownlint-disable line-length -->

| Cloud Usage Record Property | Type           | Null | Definition                                                                   | Notes                                                                                                                                                                    |
| --------------------------- | -------------- | ---- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| MeasurementTime             | `datetime`     | No   | The time the usage was recorded.                                             | In the message format, must be a UNIX timestamp, i.e. the number of seconds that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970) |
| SiteName                    | `varchar(255)` | No   | The GOCDB site assigning the IP                                              |
| CloudComputeService         | `varchar(255)` | Yes  | See Cloud Usage Record                                                       |
| CloudType                   | `varchar(255)` | No   | See Cloud Usage Record                                                       |
| LocalUser                   | `varchar(255)` | No   | See Cloud Usage Record                                                       |
| LocalGroup                  | `varchar(255)` | No   | See Cloud Usage Record                                                       |
| GlobalUserName              | `varchar(255)` | No   | See Cloud Usage Record                                                       |
| FQAN                        | `varchar(255)` | No   | See Cloud Usage Record                                                       |
| IPVersion                   | `byte`         | No   | 4 or 6                                                                       |
| IPCount                     | `int(11)`      | No   | The number of IP addresses of IPVersion this user currently assigned to them |

<!-- markdownlint-enable line-length -->

A JSON schema defining a valid Public IP Usage message can be found at:
<https://github.com/apel/apel/blob/9476bd86424f6162c3b87b6daf6b4270ceb8fea6/apel/db/__init__.py>

#### GPU Usage Record

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

#### APEL and accounting portal

Once generated, records are delivered to the central accounting repository using
APEL SSM (Secure STOMP Messenger). SSM client packages can be obtained at
<https://apel.github.io>. A Cloud Accounting Summary Usage Record has also been
defined and summaries created on a daily basis from all the accounting records
received from the Resource Providers are sent to the EGI Accounting Portal. The
[Accounting portal](http://accounting.egi.eu/) also runs SSM to receive these
summaries and provides a web view of the accounting data received from the
Resource Providers.

[cASO](https://github.com/IFCA/caso) delivers an implementation of the extractor
probes for OpenStack.

### Monitoring

The endpoints published in the
[Configuration Database](../../../internal/configuration-database) are monitored
via [ARGO](https://argo.egi.eu/). Specific probes to check functionality and
availability of services must be provided by service developers.

The current set of probes used for monitoring IaaS resources consists of:

- Accounting probe (`eu.egi.cloud.APEL-Pub`): Checks if the cloud resource is
  publishing data to the Accounting repository
- TCP checks (`org.nagios.Broker-TCP`, `org.nagios.CDMI-TCP`, and
  `org.nagios.CloudBDII-Check`): Basic TCP checks for services.
- VM Marketplace probe (`eu.egi.cloud.AppDB-Update`): gets a predetermined image
  list from AppDB and checks its update interval.
- PERUN probe (`eu.egi.cloud.Perun-Check`): connects to the server and checks
  the status by using internal PERUN interface.

## Roadmap

The TCB-Cloud board defines the roadmap for the technical evolution of the EGI
Cloud. All the components are continuously maintained to:

- Improve their programmability, providing complete APIs specification in
  adequate format for facilitating the generation clients (e.g. following the
  OpenAPI initiative and Swagger).
- Lower the barriers to integrate and operate resource centres in the federation
  by a) minimizing the number of components used; b) contributing code to
  upstream distributions; and c) use only public APIs of the Cloud Management
  Frameworks.

Currently, the EGI FedCloud TaskForce is focused on moving to a central
operations model, where providers only need to integrate their system with EGI
Check-in but do not need to deploy and configure the different tools
(accounting, discovery, VMI management, etc.) locally but delegate this to a
central EGI team.
