---
title: Rancher
linkTitle: Rancher
type: docs
weight: 10
aliases:
  - /users/cloud-container-compute/rancher
description: >
  Managed Kubernetes with Rancher on the EGI Cloud
---

EGI provides a **managed Kubernetes service** based on
[Rancher](https://www.rancher.com/) that simplifies the deployment and operation
of container orchestration platforms. The service is accessible via
[containers.egi.eu](https://containers.egi.eu) and offers a centralised,
easy-to-use web interface for managing Kubernetes clusters and deploying
containerised applications.

## Getting Started

Users have two options for using the managed Kubernetes service:

1. **Demo Cluster Resources**: Get started quickly with pre-provisioned cluster
   resources managed by EGI. This option is ideal for testing, development, and
   small-scale deployments where you want to focus on your applications without
   managing the underlying infrastructure.

1. **Bring Your Own Cluster**: Deploy your own Kubernetes cluster on
   [EGI Federated Cloud](../../cloud-compute/) resources or on your own
   infrastructure, and register it with the Rancher management platform at
   containers.egi.eu. This option provides full control over your cluster
   configuration and scaling while still benefiting from the unified management
   interface. See [Adding Your Own Cluster](#adding-your-own-cluster) below.

## Adding Your Own Cluster

To register your own Kubernetes cluster with the EGI Rancher platform, you need
to contact us and initiate the registration process. Send an email to the support
with the following information:

- **Cluster Name**: A unique name for your cluster (e.g., `my-research-cluster`)
- **Description**: A short description of the cluster's purpose and the research
  community it serves
- **User Access Entitlement**: The VO (Virtual Organisation) or other EGI
  Check-in entitlement that should be granted **user** access to the cluster
  (e.g., `vo.access.egi.eu`)
- **Admin Access Entitlement**: The VO (Virtual Organisation) or other EGI
  Check-in entitlement that should be granted **admin** access to the cluster
  (e.g., `vo.access.egi.eu`)

### Email Template

```text
Subject: Rancher cluster registration request

Dear EGI Container Compute Support,

I would like to register my Kubernetes cluster with the EGI Rancher management
platform (containers.egi.eu).

Please find the required information below:

Cluster Name: <my-cluster-name>
Description: <purpose of the cluster and research community>
User Access Entitlement (VO): <vo for user access>
Admin Access Entitlement (VO): <vo for admin access>

Best regards,
<Your Name>
```

Once the request is processed, you will receive the cluster registration command
or manifest to add your cluster to the Rancher platform.

## Features

The managed Kubernetes service at containers.egi.eu provides several advanced
features to streamline your container operations:

- **Application Catalog**: Deploy applications from a curated catalog of Helm
  charts with just a few clicks. Popular applications and services can be
  provisioned quickly without manual configuration.

- **Integrated Monitoring**: Built-in monitoring capabilities provide visibility
  into cluster health, resource utilisation, and application performance through
  integrated dashboards.

- **Dynamic DNS**: Automatic DNS management for your deployed services, making
  it easy to expose applications with stable, configurable hostnames.

- **Centralised Management**: Manage multiple Kubernetes clusters from a single
  interface, regardless of where they are deployed (EGI Cloud, private cloud,
  or on-premises).

- **Role-Based Access Control (RBAC)**: Fine-grained access control for teams
  and projects, integrating with [EGI Check-in](https://www.egi.eu/service/check-in/)
  for authentication.

- **Persistent Storage**: Integration with EGI Cloud block and object storage
  services for stateful applications.

## Documentation

For detailed technical documentation on using the managed Kubernetes service,
including cluster registration, application deployment, and advanced
configuration, please refer to the documentation at
[docs.cerit.io](https://docs.cerit.io).

## Getting Support

For support with the managed Kubernetes service, please contact EGI support via
[EGI Helpdesk](https://helpdesk.egi.eu/).
