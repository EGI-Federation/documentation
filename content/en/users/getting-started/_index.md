---
title: "Getting Started"
linkTitle: "Getting Started"
type: docs
weight: 10
description: >
  Get access to EGI services
---

## EGI Account

You need to sign up for an account for accessing the EGI services. This process
is not about creating yet another (username/password) credential but to link
your existing existing credential (for example using an eduGAIN IdP) with EGI.

Follow the [sign up process](../check-in/signup/) to get started.

## Virtual Organisations (VOs)

Service access is based on **Virtual Organisations (VOs)**. A Virtual
Organisation is a group of users and the service providers from the federation
who allocate capacity for a specific user group. Users are not individually
enabled in the services but through VOs.

VOs are fully managed by communities allowing them to manage their users and
grant control access to the services and resources. Usually there is
one-to-one mapping between research communities and Virtual Organizations
(although this is not mandatory). Users can also belong to different VOs, e.g.
they work with different communities. Fine-grained authorisation mechanisms
can be enabled within a VOs, for example only a subset of the users of a given
VO may have access rights to manage software applications for that VO.

**You have to join a VO before you can interact with most of the EGI services**.
The [Operations portal](https://operations-portal.egi.eu/vo/) provides the
full list of available VOs.

### VOMS based VOs

Some services require the use of X.509 certificates for user authentication and
authorisation. These use [VOMS](https://italiangrid.github.io/voms/index.html)
for managing VO membership. Learn about how to get certificates and join a VOMS
based Virtual Organisation in the [Check-in documentation](../check-in/voms).
