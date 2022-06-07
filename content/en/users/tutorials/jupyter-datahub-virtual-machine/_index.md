---
title: "Create a Virtual Machine with Jupyter and DataHub"
type: docs
weight: 100
description: >
  Step by step guide to get a Virtual Machine for Jupyter and DataHub in your
  cloud provider
---

## Overview

This tutorial describes how to start a Virtual Machine in the EGI Federation
that runs a browser accessible jupyter server with DataHub spaces mounted. This
setup can be used in the EGI Federation or in any other provider which
synchronise images from AppDB but is not part of the federation.

## Step 0: Requirements

This tutorial assumes you have:

- A valid EGI account: learn to can create one in
  [Check-in](../../aai/check-in/signup).
- Access to a cloud provider where the
  [Jupyter DataHub VM is available](https://appdb.egi.eu/store/vappliance/jupyter.datahub.vm).
  Alternatively, this VM can be run on your computer using a virtualization tool
  like VirtualBox.

## Step 1: Start your VM

Start your VM on your cloud provider or virtualization tool. You can check
[the tutorial on how to start a VM](../create-your-first-virtual-machine) to
learn how to start a VM at EGI's Federated Cloud infrastructure.

This VM does not contain any default credentials, in order to access it you need
a ssh key. Check
[this FAQ entry](../../compute/cloud-compute/faq/#how-can-i-inject-my-public-ssh-key-into-the-machine)
for more information.

The VM image is ready to listen on port `22` for ssh access and port `80` for
accessing the notebooks interface. Make sure your have those ports open on your
security groups, otherwise you will not be able to reach the Jupyter notebooks.

Once your instance is ready,
[assign it a public IP](../../compute/cloud-compute/faq/#how-can-i-assign-a-public-ip-to-my-vm)
so you can reach it from your computer.

## Step 2: Setup DataHub

Log into [EGI's DataHub](https://datahub.egi.eu/) and
[create a token](../../data/management/datahub/clients/#generating-tokens-for-using-oneclient-or-apis)
for mounting your data in the VM.

You will also need the IP or address of your closest provider for the spaces you
are interested in accessing. This information is easily obtainable via
[DataHub's web interface](../../data/management/datahub/clients/#using-the-web-interface)

SSH to your VM as user `ubuntu`:

```shell
$ ssh ubuntu@<your VM's IP>
```

And edit the `mount.sh` script by adding the `ONECLIENT_ACCESS_TOKEN` and
`ONECLIENT_PROVIDER_HOST` to get access to DataHub:

```shell
#!/bin/bash

# Personal token obtained from https://datahub.eu
ONECLIENT_ACCESS_TOKEN="<your DataHub token>"
# Closest oneprovider supporting your spaces
ONECLIENT_PROVIDER_HOST="plg-cyfronet-01.datahub.egi.eu"

oneclient -H "$ONECLIENT_PROVIDER_HOST" -t "$ONECLIENT_ACCESS_TOKEN" /mnt/datahub
```

Now, mount your spaces by invoking the script:

```shell
$ mount.sh
Connecting to provider 'plg-cyfronet-01.datahub.egi.eu:443' using session ID: '4173323292216088977'...
Getting configuration...
Oneclient has been successfully mounted in '/mnt/datahub'.
```

## Step 3: Get your token for the jupyter server

Your VM will spawn a Jupyter notebooks server upon starting. This server runs as
an unprivileged user named `jovyan` with the software installed using
[micromamba](https://mamba.readthedocs.io/). The server uses a randomly
generated token for authentication that you can obtain by logging into the VM
and becoming `jovyan`:

```shell
$ ssh ubuntu@<your VM's IP>
# become jovyan user and activate the default environment
$ sudo su - jovyan
$ micromamba activate
$ jupyter server list --jsonlist | jq -r .[].token
<your token>
```

## Step 4: Start your notebooks

Now point your browser to `http://<your VM's IP>` and you will be able to enter
the token to get started with Jupyter. The `datahub` folder will contain all
your mounted DataHub spaces.

You can install additional packages with mamba from a terminal started from
jupyter or via ssh. For example for installing `tensorflow`:

```shell
$ micromamba activate
$ micromamba install -c conda-forge tensorflow
```
