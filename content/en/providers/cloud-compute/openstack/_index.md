---
title: "OpenStack"
weight: 20
type: "docs"
description: >
  Integration with OpenStack
---

This section provides information on how to set up a Resource Centre providing
cloud resources in the EGI infrastructure. Integration with FedCloud requires a
_working OpenStack installation_ as a pre-requirement. EGI supports any recent
[OpenStack version](https://releases.openstack.org) (tested from OpenStack
Mitaka).

The following OpenStack services are expected to be available and accessible
from outside the site:

- Keystone
- Nova
- Cinder
- Glance
- Neutron
- Swift (if providing Object Storage)

The integration is performed by a set of EGI components that interact with the
OpenStack services APIs:

- Authentication of EGI users into your system is performed by configuring the
  native OpenID Connect support of Keystone
- **cASO** collects accounting data from OpenStack and uses **SSM** to send the
  records to the central accounting database on the EGI Accounting service
  ([APEL](https://apel.github.io/)). cASO and SSM are operated by the site.
- EGI runs the cloud-info-provider and cloudkeeper instances to provide
  information discovery and VM image synchronisation

![image](openstacksite.png)

## Installation options

cASO and SSM releases can be be obtained from GitHub:

- [cASO](https://github.com/IFCA-Advanced-Computing/caso/releases). cASO
  containers are available in the
  [fedcloud-caso](https://github.com/EGI-Federation/fedcloud-catchall-operations/pkgs/container/fedcloud-caso)
  package from
  [fedcloud-catchall-operations](https://github.com/EGI-Federation/fedcloud-catchall-operations)
- [SSM](https://github.com/apel/ssm/releases).

## Open Ports

### Inbound

The following **services** must be accessible to allow access to an
OpenStack-based FedCloud site (default ports listed below, can be adjusted to
your installation).

<!-- markdownlint-disable line-length -->

| Port         | Application            | Note                              |
| ------------ | ---------------------- | --------------------------------- |
| **5000**/TCP | **OpenStack**/Keystone | Authentication to your OpenStack. |
| **8776**/TCP | **OpenStack**/cinder   | Block Storage management.         |
| **8774**/TCP | **OpenStack**/nova     | VM management.                    |
| **9696**/TCP | **OpenStack**/neutron  | Network management.               |
| **9292**/TCP | **OpenStack**/glance   | VM Image management.              |

<!-- markdownlint-enable line-length -->

### Outbound

The EGI Cloud components require the following outgoing connections open:

<!-- markdownlint-disable line-length -->

| Port         | Host                | Note                                                            |
| ------------ | ------------------- | --------------------------------------------------------------- |
| **443**/TCP  | `msg.argo.grnet.gr` | ARGO Messaging System (used to send accounting records by SSM). |
| **8443**/TCP | `msg.argo.grnet.gr` | AMS authentication (used to send accounting records by SSM).    |

<!-- markdownlint-enable line-length -->

## Accounts in OpenStack

User accounts will be managed by the
[Federated Identity](https://docs.openstack.org/keystone/latest/admin/federation/federated_identity.html)
features of OpenStack. cASO expects to be run with a user that is allowed to
access `identity:list_users` and `identity:list_projects` in Keystone.
