---
title: Create a new environment with a different kernel
linkTitle: Create a new environment with a different kernel
type: docs
weight: 10
description: >
  Use a specific python version when creating a new environment in Conda
  Switcher.
---

First you need to create a new environment, you can do it by selecting
Conda-Switcher on left sidebar.

![Conda Switcher sidebar](notebooks-conda-switcher-sidebar.png)

Then you create a new environment by clicking on **Create Environment** option
and you select options you need:

![Create environment](notebooks-conda-switcher-create-env.png)

Here I selected I want to create an environment with Python 3.9 and IPykernel
Jupyter of same version

![Create environment with custom python](notebooks-conda-switcher-custom-python.png)

Once the environment is created, you can check it by looking on list of
available environments managed by Conda-Switcher

![New environment in the extension](notebooks-conda-switcher-env.png)

In the tab launcher you can now open a Jupyter kernel from 3.9 environment
version you just created

![New environment in the launcher](notebooks-conda-switcher-launcher.png)

Or if you have an existing Notebook, you open it in Jupyterlab Notebook editor
and then you select a kernel you desire, in this case we will select 3.9 Python
kernel from the created environment.

You can select the kernel by clicking on the top right corner and select the
kernel you wish.

![Define kernel in existing notebook](notebooks-conda-switcher-kernel.png)
![Select kernel in existing notebook](notebooks-conda-switcher-kernel-select.png)
