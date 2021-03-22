---
title: "Notebooks Kernels"
type: docs
description: >
  Available Kernels in EGI Notebooks
weight: 5
---

Jupyter is an extensible environment that supports different programming
languages. Each language is available as a different
[kernel](https://jupyter.readthedocs.io/en/latest/projects/kernels.html).

For the EGI service we have enabled a set of kernels that are automatically
built from the
[EGI-Federation/egi-notebooks-images](https://github.com/EGI-Federation/egi-notebooks-images)
GitHub repository.

## Python

Default Python 3 kernel, it includes commonly used data analysis and machine
learning libraries. Created from the
[jupyter/scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook)
stack.

## DIRAC / Python 2

A python 2 kernel that includes a DIRAC installation for interacting with the
[EGI Workload Manager](../../workload-manager) service.

## Julia

The Julia programming language with the libraries described in
[jupyter/datascience-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-datascience-notebook).

## R

The R programming language with several packages from the R ecosystem as
provided by
[jupyter/r-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-r-notebook)
and some extra libraries.

## Octave

The [Octave](https://www.gnu.org/software/octave/) programming language
installed on its own conda environment (named `octave`).

## Your own kernel

If you want to add a new kernel, just let us know and we will discuss the best
way to support your request.
