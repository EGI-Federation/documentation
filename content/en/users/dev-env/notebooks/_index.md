---
title: Notebooks
linkTitle: Notebooks
type: docs
weight: 10
aliases:
  - /users/notebooks
description: Interactive data analysis with EGI Notebooks
---

The more you go in data analysis, the more you understand that the most suitable
tool for coding and visualizing is not pure code, or some integrated development
environment (IDE), nor data manipulation diagrams (such as workflows or
flowcharts). From some point on you just need a mix of all these -- that is what
_notebook_ platforms are, [Jupyter](https://jupyter.org/) being the most popular
of them.

## What is it?

[EGI Notebooks](https://www.egi.eu/service/notebooks/) is a service-like
environment based on the [Jupyter technology](https://jupyter.org/), offering a
**browser-based tool for interactive data analysis**.

The Notebooks environment provides users with _notebooks_ where they can combine
text, mathematics, computations and rich media output. EGI Notebooks is a
multi-user service that can scale on demand, being powered by the
[compute services](../../compute/) of EGI.

EGI Notebooks provides the well-known Jupyter interface for notebooks, with the
following added features:

- Integration with [EGI Check-in](../../aai/check-in/) allows you to login with
  any eduGAIN or social accounts (e.g. Google, Facebook)
- Persistent storage associated with each user is available in the notebooks
  environment
- Customisable with new notebook environments, expose any existing notebook to
  your users
- Can easily use EGI compute and storage services from your notebooks, as your
  notebooks run on EGI infrastructure

## Service Modes

We offer different service modes depending on your needs

### Notebooks for researchers

Individual users can use the centrally operated service from EGI. Users can log
in, write and play and re-play notebooks by:

1. [creating an EGI account](../../aai/check-in/signup)
2. Enrolling to the one of the supported VOs such as
   [vo.notebooks.egi.eu VO](https://aai.egi.eu/registry/co_petitions/start/coef:111)
3. [accessing https://notebooks.egi.eu/](https://notebooks.egi.eu/)

The central instance supports the following VOs:

- [vo.notebooks.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.notebooks.egi.eu),
  enroll [here](https://aai.egi.eu/registry/co_petitions/start/coef:111)
- [vo.access.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.access.egi.eu)
- [auger](https://operations-portal.egi.eu/vo/view/voname/auger)
- [biomed](https://operations-portal.egi.eu/vo/view/voname/biomed)
- [vo.reliance-project.eu](https://operations-portal.egi.eu/vo/view/voname/vo.reliance-project.eu)
- [eiscat.se](https://operations-portal.egi.eu/vo/view/voname/eiscat.se)
- [eval.c-scale.eu](https://operations-portal.egi.eu/vo/view/voname/eval.c-scale.eu)
- [vo.panosc.eu](https://operations-portal.egi.eu/vo/view/voname/vo.panosc.eu)
- [vo.environmental.egi.eu](https://operations-portal.egi.eu/vo/view/voname/vo.environmental.egi.eu)
- [vo.lethe-project.eu](https://operations-portal.egi.eu/vo/view/voname/vo.lethe-project.eu)
- [vo.cessda.eduteams.org](https://operations-portal.egi.eu/vo/view/voname/vo.cessda.eduteams.org)

### Notebooks for communities

User communities can have their customised EGI Notebooks service instance. EGI
offers consultancy, support, and can operate the setup as well. A community
specific setup allows the community to use the community\'s own Virtual
Organisation (i.e. federated compute and storage sites) for Jupyter, add custom
libraries into Jupyter (e.g. discipline-specific analysis libraries) or have
fine grained control on who can access the instance (based on the information
available to the EGI Check-in AAI service).

EGI currently operates community instances for:

- [D4Science](https://www.d4science.org/). These instances are accessed through
  specific Gateways: [SoBigData](https://sobigdata.d4science.org/),
  [Blue-Cloud](https://blue-cloud.d4science.org/),
  [D4Science Services](https://services.d4science.org/) and
  [EOSC-Pillar](https://eosc-pillar.d4science.org/). Check with
  [D4Science support](https://www.d4science.org/contact-us) for more
  information.

### Training instance

EGI can provide a custom and temporary instance of the Notebooks service for
training events, if you have a specific event where you would like to use EGI
Notebooks as platform for your training, [let us know](../../../support/).

{{% alert title="Note" color="warning" %}}This instance may not use the same
software version as in production and may not be always available, as it is
typically configured only for specific training events. {{% /alert %}}
