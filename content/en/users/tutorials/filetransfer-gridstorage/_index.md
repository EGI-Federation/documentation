---
title: "File Transfer with grid storage"
linkTitle: "File Transfer with grid storage"
type: docs
weight: 80
draft: true
description: >
  Use EGI File Transfer to handle data in grid storage
---

<!-- Adjust page weight to insert this tutorial in the right place, then remove this -->

## Overview

This tutorial describes how to perform a transfer usin FTS transfers services
and WebFTS.

## Prerequisites

As first step please make sure that you have installed the FTS client as
described in [Data Transfer](../../data-transfer/), and in particular
[Clients](../../data-transfer/clients/) for the command line FTS and to have
yourcertificates installed in your browser to use WebFTS
[WebFTS](../../data-transfer/webfts/) browser based client.

To access services and resources in the
[EGI Federated Cloud](../../getting-started), you will need:

- An EGI ID (account), you can [sign up here](../../check-in/signup)
- Enrollment into a [Virtual Organisation](../../check-in/vos) (VO) that has
  access to the services and resources you need

## FTS

### Step 1 Configuration check

To verify that everything is configured properly you can check with the
following command pointing to the cerficates directly:

<!-- markdownlint-disable line-length -->
```shell
$ fts-rest-whoami --key .globus/userkey.pem --cert .globus/usercert.pem -s https://fts3-public.cern.ch:8446/
User DN: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
VO: AndreaCristoforiac@egi.eu@tcs.terena.org
VO id: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
Delegation id: XXXXXXXXXXXXXXXX
Base id: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
```
<!-- markdownlint-enable line-length -->

In general the commands can be used by specifying the user public and private
key like shown in the example or by creating a proxy certificate as

### Proxy creation

To avoid the need to specify at each command the private and public key if
everything is already configured and working properly it will be enough to
execute the following coomand:

<!-- markdownlint-disable line-length -->
```shell
$ voms-proxy-init
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
Creating proxy ........................................... Done

Your proxy is valid until Wed Aug 25 04:18:14 2021
```
<!-- markdownlint-enable line-length -->

As the output of the command shows a proxy certificate has been generated that
will be valid, by default, for 12 hours. This can be usually increased for
example to 48 hours with the following option:

<!-- markdownlint-disable line-length -->
```shell
$ voms-proxy-init -valid 48:00
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
Creating proxy ................................... Done

Your proxy is valid until Thu Aug 26 16:23:01 2021
```
<!-- markdownlint-enable line-length -->

To verify the timeleft for the validity of the proxy created use the following command:

<!-- markdownlint-disable line-length -->
```shell
$ voms-proxy-info
subject   : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu/CN=1451339003
issuer    : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
identity  : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
type      : RFC compliant proxy
strength  : 1024 bits
path      : /tmp/x509up_u1000
timeleft  : 19:59:57
```
<!-- markdownlint-enable line-length -->

When the timeleft reaches zero if the previous command used to check the identity will return the following message:

<!-- markdownlint-disable line-length -->
```shell
$ fts-rest-whoami -s https://fts3-public.cern.ch:8446/
Error: Proxy expired!
```
<!-- markdownlint-enable line-length -->



## WebFTS

### Step 1
