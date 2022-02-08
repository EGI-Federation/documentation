---
title: "Virtual machine with DataHub access"
linkTitle: "VM with DataHub acceess"
type: docs
weight: 30
draft: true
description: >
  Use data in EGI DataHub from a virtual machine
---

## Overview

This tutorial describes the access to EGI DataHub spaces from a virtual 
machine. aIn the following paragraphs you will learn how to:

- install the oneclient component
- mount an EGI DataHub space via oneclient

in order to access data remotely stored in EGI DataHub

## Prerequisites

In order to access the EGI DataHub data you need first of all to have an
[EGI Check-in](../../check-in) account, if you don't have an EGI Checkin 
account you can sign up [here](../../check-in/signup)

## Oneclient installation

The installaiton of oneclient package is currntly supported for:

- Ubuntu Bionic
- Centos 7

Support for more rencent OSs version is ongoing and  a docker based 
installation is also provided.

### Oneclient installation via packages

In order to install the oneclient package in a supported OS, just use 
the  following command:

```shell
curl -sS http://get.onedata.org/oneclient.sh | bash
```

which will also install the needed dependencies.

### Oneclient installation via docker

In order to use the Dockerized version of omeclient 
```shell
export ONECLIENT_ACCESS_TOKEN=<ACCESS_TOKEN_FROM_ONEZONE>
export ONECLIENT_PROVIDER_HOST=plg-cyfronet-01.datahub.egi.eu
mkdir /tmp/space
oneclient /tmp/space
```

## Getting the token

In order to use oneclient, a pat





