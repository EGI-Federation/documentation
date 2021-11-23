---
title: "Notebooks"
type: docs
description:
  "Documentation related to [EGI
  Notebooks](https://www.egi.eu/services/notebooks/)"
weight: 90
---

The more you go in data analysis, the more you understand that the most suitable
tool for coding and visualizing is not a pure code, or SQL IDE, or even
simplified data manipulation diagrams (aka workflows or jobs). From some point
you realize that you need a mix of these all -- that's what "notebook" platforms
are, with Jupyter being the most popular notebook software out there.

Notebooks is an \'as a Service\' environment based on the
[Jupyter technology](http://jupyter.org/), offering a browser-based, scalable
tool for interactive data analysis. The Notebooks environment provides users
with notebooks where they can combine text, mathematics, computations and rich
media output. EGI Notebooks is a multi-user service and can scale to multiple
servers based on the
[EGI Cloud service](https://www.egi.eu/services/cloud-compute/).

## EGI Notebooks Unique Features

EGI Notebooks provides the well-known Jupyter interface for notebooks with the
following added features:

- Integration with EGI Check-in for authentication, login with any EduGAIN or
  social accounts (e.g. Google, Facebook)
- Persistent storage associated with each user, available in the notebooks
  environment.
- Customisable with new notebook environments, expose any existing notebook to
  your users.
- Runs on EGI e-Infrastructure so can easily use EGI compute and storage from
  your notebooks.

## Service Modes

We offer different service modes depending on your needs

### Notebooks for researchers

Individual users can use the centrally operated service from EGI. Users can
login, write and play and re-play notebooks by:

1. [creating an EGI account](../check-in/signup)
2. Enrolling to the one of the supported VOs such as
   [vo.notebooks.egi.eu VO](https://aai.egi.eu/registry/co_petitions/start/coef:111)
3. [accessing https://notebooks.egi.eu/](https://notebooks.egi.eu/)

This instance has limits on the amount of resources available for each user (2
CPU core, 4 GB RAM and 20 GB of storage). It will also kill inactive sessions
after 1 hour.

The central instance supports the following VOs:

- [vo.notebooks.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.notebooks.egi.eu),
  enroll [here](https://aai.egi.eu/registry/co_petitions/start/coef:111)
- [vo.access.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.access.egi.eu)
- [auger](https://operations-portal.egi.eu/vo/view/voname/auger)
- [biomed](https://operations-portal.egi.eu/vo/view/voname/biomed)
- [vo.reliance-project.eu](https://operations-portal.egi.eu/vo/view/voname/vo.reliance-project.eu)

### Notebooks for communities

User communities can have their customised EGI Notebooks service instance. EGI
offers consultancy, support, and can operate the setup as well. A community
specific setup allows the community to use the community\'s own Virtual
Organisation (i.e. federated compute and storage sites) for Jupyter, add custom
libraries into Jupyter (e.g. discipline-specific analysis libraries) or have
fine grained control on who can access the instance (based on the information
available to the EGI Check-in AAI service).
