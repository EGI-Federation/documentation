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

## Users

### Local Users

In order to get accounting information from your OpenStack, cASO needs to be run
with a user that is a member of the projects to extract accoutning information
from and it's allowed to access `identity:list_users` and
`identity:list_projects` in Keystone. Check
[cASO documentation](https://caso.readthedocs.io/en/stable/configuration.html#user-credentials-required)
for further information.

### Federated Users

Regular user accounts will be managed by the
[Federated Identity](https://docs.openstack.org/keystone/latest/admin/federation/federated_identity.html)
features of OpenStack. These users are created into a specific OpenStack domain
for every configured identity provider. All users within the `egi.eu` domain
will have a unique username. For users whose community identity is managed by
Check-in, this identifier is of the form `<uniqueID>@egi.eu`. The `<uniqueID>`
portion is an opaque identifier issued by Check-in, for example:

```shell
$ openstack domain list
+----------------------------------+----------------------------------+---------+---------------------------------------------------------------+
| ID                               | Name                             | Enabled | Description                                                   |
+----------------------------------+----------------------------------+---------+---------------------------------------------------------------+
| 0125ed0ebc8045a49ed8c34c2a78740d | 0125ed0ebc8045a49ed8c34c2a78740d | True    | Auto generated federated domain for Identity Provider: egi.eu |
| default                          | Default                          | True    | The default domain                                            |
+----------------------------------+----------------------------------+---------+---------------------------------------------------------------+

$ openstack user list --domain 0125ed0ebc8045a49ed8c34c2a78740d
+------------------------------------------------------------------+-------------------------------------------------------------------------+
| ID                                                               | Name                                                                    |
+------------------------------------------------------------------+-------------------------------------------------------------------------+
| 2c096b11a1410d44e3936fa40479ad26eaa649cfd6887f06b3c6669e5d6c03d0 | efb8534478028XXXXXXXXXXXXXXXfeed9766fafc@sram.surf.nl                   |
| 933c692b53192e4d893e5ed5c026aa444acb4d75f6ee6c304422861207ce1ea5 | e9c37aa0d1XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX2867bc43581b835c@egi.eu |
| d52112709a37975903576f80f37dde4604d1a227c53cb1fef43c45981673640c | 529a87e5ceXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXe714cb1309cc3907@egi.eu |
+------------------------------------------------------------------+-------------------------------------------------------------------------+
```

If you have set the email of the user in the mapping, you will be able to also
get this information:

```shell
$ openstack user show d52112709a37975903576f80f37dde4604d1a227c53cb1fef43c45981673640c
+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field               | Value                                                                                                                                                      |
+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| domain_id           | 0125ed0ebc8045a49ed8c34c2a78740d                                                                                                                           |
| email               | XXXX-redacted@example.com                                                                                                                                   |
| enabled             | True                                                                                                                                                       |
| federated           | [{'idp_id': 'egi.eu', 'protocols': [{'protocol_id': 'openid', 'unique_id': '529a87e5ceXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXe714cb1309cc3907%40egi.eu'}]}] |
| id                  | d52112709a37975903576f80f37dde4604d1a227c53cb1fef43c45981673640c                                                                                           |
| name                | 529a87e5ceXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXe714cb1309cc3907@egi.eu                                                                                    |
| options             | {}                                                                                                                                                         |
| password_expires_at | None                                                                                                                                                       |
+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

Every VO has a VO identity card available via the
[Operations Portal](https://operations-portal.egi.eu/vo/a/list), where you can
also get contact information for the VO managers.

VMs created by
[EGI's Infrastructure Manager](../../../users/compute/orchestration/im/) have
additional metadata properties that can help to identify the workload:

```shell
$ openstack server show 0f3e1420-4480-4bea-95f1-9920a70b324d -c properties -f yaml
properties:
  eu.egi.cloud.orchestrator: es.upv.grycap.im
  eu.egi.cloud.orchestrator.id: 0afdc7ba-bf5d-11ed-9e89-86ce117c3fcf
  eu.egi.cloud.orchestrator.url: https://appsgrycap.i3m.upv.es:31443/im
  eu.egi.cloud.orchestrator.user: __OPENID__XXXXXXredacted
```
