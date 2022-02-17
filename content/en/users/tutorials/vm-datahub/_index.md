---
title: "Access DataHub from a Virtual machine"
type: docs
weight: 40
description: >
  Use data in EGI DataHub from a virtual machine
---

## Overview

This tutorial describes the access to [EGI DataHub](../../datahub) spaces
from a virtual machine. In the following paragraphs you will learn how to
access data remotely stored in EGI DataHub like if they were local, using
traditional POSIX command-line commands, by:

- installing the `oneclient` component
- configuring access to an EGI DataHub Oneprovider via `oneclient`

## Prerequisites

In order to access the EGI DataHub data you need an
[EGI Check-in](../../check-in) account. If you don't have one yet
you can [Sign up for an EGI account](../../check-in/signup).

## Oneclient installation

The installation of `oneclient` package is currently supported for:

- Ubuntu 18.04 LTS (Bionic Beaver)
- Centos 7

Work to support more recent versions of Operating Systems is ongoing, and alternatively
a docker based installation is also provided.

### Oneclient installation via packages

Use the following command in order to install the `oneclient` package in a supported OS:

```shell
$ curl -sS http://get.onedata.org/oneclient.sh | bash
```

This will also install the needed dependencies.

### Oneclient installation via docker

In order to use the Dockerized version of oneclient (provided that you
have docker installed), you can run the following  command:

```shell
$ docker run -it --privileged -v $PWD:/mnt/src --entrypoint bash onedata/oneclient:20.02.15
```

This command will also expose the current folder to the container (as `/mnt/src`) to
ease the transfer of data.

## Getting the token to access data

In order to access data stored in EGI DataHub via oneclient,
you need to [get an API access token](../../datahub/api/#getting-an-api-access-token).

## Using oneclient

Once you have acquired a token valid for oneclient you can configure it
on the environment as follows:

```shell
$ export ONECLIENT_ACCESS_TOKEN=<ACCESS_TOKEN_FROM_ONEZONE>
```

You must also configure in the environment the provider you would like to
connect to. The EGI DataHub offers a `PLAYGROUND` space hosted by
the Oneprovider `plg-cyfronet-01.datahub.egi.eu` which is accessible
for testing by anyone with a valid EGI Check-in account.

Therefore the access to that particular space can be configured as
follows:

```shell
$ export ONECLIENT_PROVIDER_HOST=plg-cyfronet-01.datahub.egi.eu
```

Now in order to access data from a local folder you need to run
the following commands:

```shell
$ mkdir /tmp/space
$ oneclient /tmp/space
```

and then all usual file and folder operations (POSIX) will be available:

```shell
$ root@222d3ceb86df:/tmp/space# ls -l
total 0

drwxrwxr-x 1 root    root    0 Jan 28 16:56  PLAYGROUND
```

Creating a file into the folder will push it to the Oneprovider and
it will be accessible in the web interface and from other providers
supporting the space.

By using the default settings you can see all the spaces you have
access to, but it will also be possible to specify a specific space
to access using the option `--space <space>`.

Oneclient offers a lot of other options for configuration
(e.g. buffer size, direct I/O, etc) which are listed when you
type the `oneclient` command without any argument.
