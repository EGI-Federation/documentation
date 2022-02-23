---
title: "Automating Deployments"
type: docs
weight: 70
description: >
  Use Infrastrucure-as-Code in the EGI Cloud
---

The [OpenStack](../../../getting-started/openstack) sites in the EGI Cloud that
provide compute resources to run virtual machines (VMs) allow nearly everything
to be done via an Application Programming Interface (API) or a
[command-line interface](../../../getting-started/cli) (CLI).
This means that repetitive tasks or complex architectures can be turned into shell scripts.

But creating VMs happens so often in the EGI Cloud that tools were developed to
capture the provisioning of these VMs, and allow users to recreate them in a flash,
in a **deterministic** and **repeatable** way, using an Infrastructure-as-Code (IaC) approach.

Automating this activity will help researchers to:

- Not forget important configuration (e.g. the size and type of the hardware resources needed).
- Ensure the same steps are performed, in the same order (e.g. making sure the correct
  datasets are attached to each VM).
- Easily share scientific pipelines with collaborators.
- Make scientific applications cloud agnostic.

To automate VM deployment, you can use any of the [cloud orchestrators](../../orchestration)
available in the EGI Cloud.
