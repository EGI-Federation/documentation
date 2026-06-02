---
title: Cloud Container Compute
linkTitle: Container Compute
type: docs
weight: 20
aliases:
  - /users/cloud-container-compute
description: >
  Run container-based applications on the EGI Cloud
---

The
[EGI Cloud Container Compute service](https://www.egi.eu/service/cloud-container-compute/)
allows you to run container-based applications on the EGI infrastructure. EGI
provides a managed Kubernetes platform based on [Rancher](https://www.rancher.com/)
at [containers.egi.eu](https://containers.egi.eu), offering an easy-to-use
interface for deploying and managing containerized applications.

## Managed Kubernetes Service

EGI offers a **managed Kubernetes service** that simplifies the deployment and
operation of container orchestration platforms. The service is accessible via
[containers.egi.eu](https://containers.egi.eu) and provides a centralized
Rancher-based management interface for your Kubernetes clusters.

See the [Rancher guide](./rancher/) for more information on getting started
with the managed Kubernetes service.

### Getting Started

Users have two options for using the managed Kubernetes service:

1. **Demo Cluster Resources**: Get started quickly with pre-provisioned cluster
   resources managed by EGI. This option is ideal for testing, development, and
   small-scale deployments where you want to focus on your applications without
   managing the underlying infrastructure.

1. **Bring Your Own Cluster**: Deploy your own Kubernetes cluster on
   [EGI Federated Cloud](../cloud-compute/) resources or on your own
   infrastructure, and register it with the Rancher management platform at
   containers.egi.eu. This option provides full control over your cluster
   configuration and scaling while still benefiting from the unified management
   interface.

### Features

The managed Kubernetes service at containers.egi.eu provides several advanced
features to streamline your container operations:

- **Application Catalog**: Deploy applications from a curated catalog of Helm
  charts with just a few clicks. Popular applications and services can be
  provisioned quickly without manual configuration.

- **Integrated Monitoring**: Built-in monitoring capabilities provide visibility
  into cluster health, resource utilization, and application performance through
  integrated dashboards.

- **Dynamic DNS**: Automatic DNS management for your deployed services, making
  it easy to expose applications with stable, configurable hostnames.

- **Centralized Management**: Manage multiple Kubernetes clusters from a single
  interface, regardless of where they are deployed (EGI Cloud, private cloud,
  or on-premises).

- **Role-Based Access Control (RBAC)**: Fine-grained access control for teams
  and projects, integrating with EGI Check-in for authentication.

- **Persistent Storage**: Integration with EGI Cloud block and object storage
  services for stateful applications.

### Documentation

For detailed technical documentation on using the managed Kubernetes service,
including cluster registration, application deployment, and advanced
configuration, please refer to the documentation at
[docs.cerit.io](https://docs.cerit.io).

## Alternative Container Execution Options

Besides the [managed Kubernetes service with Rancher](./rancher/), EGI Cloud
Container Compute also supports other approaches for running containers:

### Docker on Virtual Machines

For simpler applications that can easily fit on one node and are composed of a
small number of containers, you can use Docker (or a similar container runtime)
directly on a VM. This approach gives you direct control over the container
runtime and is well-suited for:

- Single-node applications
- Development and testing environments
- Simple multi-container applications using docker-compose

See the [Docker VM guide](./docker/) for more information on using pre-built
VM images with Docker pre-installed.

### Self-Managed Kubernetes with EC3

For more complex applications that span several nodes and require automated
orchestration, you can deploy your own Kubernetes cluster using
[EC3](../orchestration/im/ec3/) (Elastic Cloud Computing Cluster). This
approach provides:

- Automatic cluster deployment and configuration
- Elastic scaling of worker nodes
- Integration with EGI Cloud resources

See the [Kubernetes with EC3 guide](./k8s/) for detailed instructions on
deploying self-managed Kubernetes clusters.

## Webinars and Training

The EGI Cloud Container Compute service has been presented in the
[EGI Webinars](https://www.egi.eu/trainings-and-webinars/):

* January 2024: *Introduction to the new generation EGI container execution
  platform*. See
  [slides and recording](https://www.egi.eu/event/webinar-introduction-to-the-container-platform/).

* April 2021: *Managing Singularity, Docker and udocker containers, Kubernetes
  clusters in the EGI Cloud*. See
  [slides and recording](https://indico.egi.eu/event/5492/).

## Getting Support

For support with the managed Kubernetes service, please contact EGI support via
[EGI Helpdesk](https://helpdesk.egi.eu/).
