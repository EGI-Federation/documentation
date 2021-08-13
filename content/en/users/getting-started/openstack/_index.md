---
title: "Using OpenStack Providers"
linkTitle: "OpenStack Providers"
type: docs
weight: 20
draft: true
description: >
  How to interact with OpenStack providers in the EGI FedCloud
---

[OpenStack](https://openstack.org) providers in the EGI Federated Cloud
(FedCloud) offer services and features via OpenStack APIs, and the
[command line interface](../cli) (CLI), both integrated with
[EGI Check-in](../../check-in) accounts.

The extensive [OpenStack user documentation](https://docs.openstack.org/user/)
includes details on every OpenStack project, but most providers offer:

- [Keystone](https://docs.openstack.org/keystone/latest/), for identity
- [Nova](https://docs.openstack.org/nova/latest/), for VM management
- [Glance](https://docs.openstack.org/glance/latest/), for VM image
  management
- [Cinder](https://docs.openstack.org/cinder/latest/), for block storage
- [Swift](https://docs.openstack.org/swift/latest/), for object storage
- [Neutron](https://docs.openstack.org/neutron/latest/), for network
  management
- [Horizon](https://docs.openstack.org/horizon/latest/), as a web
  dashboard

The web-dashboard of the individual providers can be used to manage and use
services. It can be accessed using EGI Check-in credentials directly:
select _OpenID Connect_ or _EGI Check-in_ in the **Authenticate using**
drop-down menu of the login screen.
