---
title: "Notebooks"
linkTitle: "Notebooks"
type: docs
description: "Documentation related to EGI Notebooks"
weight: 110
---

The more you go in data analysis, the more you understand that the most
suitable tool for coding and visualizing is not a pure code, or SQL IDE,
or even simplified data manipulation diagrams (aka workflows or jobs).
From some point you realize that you need a mix of these all -- that's
what "notebook" platforms are, with Jupyter being the most popular
notebook software out there.

Notebooks is an \'as a Service\' environment based on the [Jupyter
technology](http://jupyter.org/), offering a browser-based, scalable
tool for interactive data analysis. The Notebooks environment provides
users with notebooks where they can combine text, mathematics,
computations and rich media output. EGI Notebooks is a multi-user
service and can scale to multiple servers based on the [EGI Cloud
service](https://www.egi.eu/services/cloud-compute/).

## EGI Notebooks Unique Features

EGI Notebooks provides the well-known Jupyter interface for notebooks
with the following added features:

*   Integration with EGI Check-in for authentication, login with any
    EduGAIN or social accounts (e.g. Google, Facebook)
*   Persistent storage associated to each user, available in the
    notebooks environment.
*   Customisable with new notebook environments, expose any existing
    notebook to your users.
*   Runs on EGI e-Infrastructure so can easily use EGI compute and
    storage from your notebooks.

## Service Modes

We offer different service modes depending on your needs:

*   Individual users can use the centrally operated service from EGI.
    Users can login, write and play and re-play notebooks just by
    [creating an EGI account](../check-in/signup). This instance has
    limits on the amount of resources available for each user (1 CPU core,
    1 GB RAM and 10 GB of storage). It will also kill inactive sessions after
    1 hour.

*   User communities can have their customised EGI Notebooks service
    instance. EGI offers consultancy and support, as well as can operate
    the setup. Contact `support _at_ egi.eu` to make an arrangement. A
    community specific setup allows the community to use the
    community\'s own Virtual Organisation (i.e. federated compute and
    storage sites) for Jupyter, add custom libraries into Jupyter (e.g.
    discipline-specific analysis libraries) or have fine grained control
    on who can access the instance (based on the information available
    to the EGI Check-in AAI service).
