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




<!-- markdownlint-disable line-length -->
```shell
$ export EGI_SITE=IN2P3-IRES
$ export EGI_VO=vo.access.egi.eu
$ fedcloud openstack volume list
Site: IN2P3-IRES, VO: vo.access.egi.eu, command: volume list
+--------------------------------------+--------+-----------+------+--------------------------------+
| ID                                   | Name   | Status    | Size | Attached to                    |
+--------------------------------------+--------+-----------+------+--------------------------------+
| 9a4000fb-0bcc-47e8-96fb-85a222295402 | Matlab | in-use    |   50 | Attached to Moodle on /dev/vdb |
| b0abcda6-1002-4493-996b-9f03bc677625 |        | available |   30 |                                |
+--------------------------------------+--------+-----------+------+--------------------------------+
```
<!-- markdownlint-enable line-length -->


<!-- If needed, mention other tools/CLIs/requirements, then remove this -->
<!-- markdownlint-enable inline-html -->

## FTS

### Step 1

## WebFTS

### Step 1
