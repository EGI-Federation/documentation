---
title: "Virtual machine with DataHub access"
linkTitle: "VM with DataHub access"
type: docs
weight: 30
draft: false
description: >
  Use data in EGI DataHub from a virtual machine
---

## Overview

This tutorial describes the access to EGI DataHub spaces from a virtual
machine. In the following paragraphs you will learn how to:

- install the oneclient component
- configure access to an EGI DataHub Oneprovider via oneclient

in order to access data remotely stored in EGI DataHub via POSIX

## Prerequisites

In order to access the EGI DataHub data you need, first of all, to have
an [EGI Check-in](../../check-in) account, if you don't have an EGI
Checkin account you can sign up [here](../../check-in/signup)

## Oneclient installation

The installation of oneclient package is currently supported for:

- Ubuntu Bionic
- Centos 7

Work to support more recent OSs version is ongoing, and alternatively
a docker based installation is also provided. 

### Oneclient installation via packages

In order to install the oneclient package in a supported OS, just use
the  following command:

```shell
curl -sS http://get.onedata.org/oneclient.sh | bash
```

which will also install the needed dependencies.

### Oneclient installation via docker

In order to use the Dockerized version of oneclient (provided that you
have docker installed), you can run the following  command:

```shell
docker run -it --privileged -v $PWD:/mnt/src --entrypoint bash onedata/oneclient:20.02.15
```

This command will also expose a local folder to the container so to
ease the transfer of data

## Getting the token to access data

In order to access data stored in EGI DataHub via oneclient,
you need to acquire a token for authorization. You can check 
[here](../../datahub/api/#getting-an-api-access-token) our
specific documentation.

## Using oneclient 

Once you have acquired a token valid for oneclient you can configure it
on the environment as follows:

```shell
export ONECLIENT_ACCESS_TOKEN=<ACCESS_TOKEN_FROM_ONEZONE>
```

and configure in the environment also the provider you would like to
connect to. The EGI DataHub offers a `PLAYGROUND` space hosted by
the Oneprovider `plg-cyfronet-01.datahub.egi.eu` which is accessible
for testing by anyone with a valid EGI Check-in account.

Therefore the access to that particular space can be configured as
follows:

```shell
export ONECLIENT_PROVIDER_HOST=plg-cyfronet-01.datahub.egi.eu
```

Now in order to access data from a local folder you just need to run
the following command:

```shell
mkdir /tmp/space
oneclient /tmp/space
```

and then all POSIX operations will be available:

```shell
root@222d3ceb86df:/tmp/space# ls -l
total 0

drwxrwxr-x 1 root    root    0 Jan 28 16:56  PLAYGROUND
```

Creating a file into the folder will push it to the Oneprovider and
it will be accessible in the web interface and from other providers
supporting the space.

By using the default settings you can see all the spaces you have
access to, but it will be possible also to specify a specific space
to access using the option _--space `space`_.

Oneclient offers a lot of other options for configuration
(e.g. Buffer size, direct I/O, etc) which are listed when you
type the **_oneclient_** command.