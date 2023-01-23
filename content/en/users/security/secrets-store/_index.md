---
title: EGI Secrets Store
linkTitle: Secrets Store
type: docs
weight: 60
description: >
  Managing secrets in the EGI infrastructure
---

## What is it?

Your applications and services may need different secrets (credentials, tokens,
passwords, etc.) during deployment and operation. These secrets are often
stored as clear texts in code repositories or configuration files, which
poses security risks. Furthermore, the secrets stored in files are static and
difficult to change (rotate).

The EGI Secrets Store helps you to
**securely store, retrieve, and rotate credentials for your services**.

The main features of EGI Secrets Store:

- Simplifies, standardizes and secures the way users store secrets,
- Secure storage of secrets, as they are encrypted both in transit and at rest.
- Makes it easy to rotate secrets, while administrators can track usage and
  manage access.
- Integration with [EGI Check-in](../../aai/check-in/) allows access with
  community credentials, no additional registration needed.
- High-availability ensures this critical service is always accessible to
  users, applications and other services built on top of it.
- Service is easy to maintain, upgrade, and extend, as it is based on
  well-known open-source software, with many client tools and libraries that
  have strong community support.

## Concepts

**Secret objects** (or secrets, for short) in EGI Secrets Store are identified
by their paths, like files on disk. Each user has a private **secret space**
for storing his secret objects and cannot see secret objects of other users.
Each secret object may contain several **secret values**, and each value is
identified by its **key** (name).

{{% alert title="Example" color="info" %}} A secret object for your service
may contain several different passwords for different components: database,
message queue, cache, storage system, etc. Each of these passwords will be a
distinct secret value in your secret object.{{% /alert %}}

Secret objects in Secret management service are created, retrieved, updated,
and deleted as a whole, users cannot edit individual secret values of an
existing secret.
