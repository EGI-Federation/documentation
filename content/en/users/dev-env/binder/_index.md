---
title: Binder
type: docs
weight: 20
aliases:
  - /users/notebooks/kernels/binder
description: >
  Custom reproducible computing environments for notebooks
---

## What is it?

Binder allows the re-creation of a custom computing environment for reproducible
execution of notebooks (and potentially many other types of applications) that
can be easily shared with other users with just a link. Users that create their
own notebooks in the EGI Notebooks to analyze data available in EGI’s
infrastructure can easily create a shareable entry in Zenodo from a Github
repository that anyone can then reproduce in the Binder service.

Binder starts from a code repository that contains the code or notebook you’d
like to run and a set of configuration files that specify what’s the exact
computational environment your code needs to run. Binder builds docker
containers on-the-fly following the configuration files, which support
specifying conda environments; installing Python, R and Julia environments;
installing additional OS packages; and even complete custom Dockerfiles to bring
any application to the system. The code repository can be hosted on popular git
hosting platforms like GitHub and GitLab and can also be referenced with a DOI
from Zenodo, FigShare or Dataverse. EGI’s binder offers a similar setup to the
publicly accessible mybinder.org service but integrated with the EGI
infrastructure and these features: Users have a personal access token that can
be used to access other EGI services Selected spaces of EGI DataHub are directly
available under the /datahub folder simplifying the access to shared data
Environments are guaranteed 2GB of RAM and can reach 4GB as maximum and there
are no hard limits on the session time per user, although sessions will be shut
down automatically after 1 hour of inactivity. The public mybinder.org service
has a 2GB memory limit and six hours of session time with automatic shut down
after 10 minutes of inactivity. User communities can have their customized
Binder service instance with extra features. EGI offers consultancy and support,
as well as can operate the setup.

Repeatable, custom computing environments for notebooks


EGI offers a Binder instance within the Notebooks service. Binder allows to
build a custom and shareable computing environment that you can interact with.

It builds on [BinderHub](https://github.com/jupyterhub/binderhub), an Open
Source tool that allows to build docker images from a Git repository and then
make it available from JupyterHub.

EGI's Binder offers similar features to the publicly available
[mybinder.org](https://mybinder.org/) with larger capacity available for each
user.

## Access

[EGI's Binder](https://binder.notebooks.egi.eu/) has the same access conditions
as the [centrally operated Notebooks service from EGI](../../#service-modes).
Before using the service, you need to have a valid EGI account and be a member
of [one of the supported VOs](../../#notebooks-for-researchers).

## Linking to EGI's binder

You can create a link to share your notebooks easily from the Binder interface,
just copy the URL shown when the building is in progress

![Binder link](binder-link.png)
