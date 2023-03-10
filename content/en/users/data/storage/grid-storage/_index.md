---
title: Grid Storage
linkTitle: "Grid Storage"
type: docs
weight: 20
aliases:
  - /users/online-storage/grid-storage
description: >
  Grid Storage offered by EGI HTC providers
---

## What is it?

Grid storage enables **storage of files in a fault-tolerant and scalable
environment**, and sharing it with distributed teams. Your data can be accessed
through multiple protocols, and can be replicated across different providers to
increase fault-tolerance. Grid storage gives you complete control over what data
you share, and with whom you share the data.

The main features of grid storage:

- Access highly-scalable storage from anywhere
- Control the data you share
- Organise your data using a flexible, hierarchical structure

Grid storage file access is based on the
[gridFTP](https://en.wikipedia.org/wiki/GridFTP) and
[WebDav/HTTP](https://en.wikipedia.org/wiki/WebDAV) protocols, together with
[XRootD](https://xrootd.slac.stanford.edu/) and legacy
[SRM](https://www.gridpp.ac.uk/wiki/SRM) (under deprecation at some of the
endpoints).

Several grid storage implementations are available in the EGI Infrastructure,
the most common being:

- [dCache](https://www.dcache.org/)
- [DPM](https://twiki.cern.ch/twiki/bin/view/DPM/) (N.B. under decommissioning)
- [StoRM](https://italiangrid.github.io/storm/)
- [EOS](https://eos-web.web.cern.ch/eos-web/)

## Endpoint discovery

The grid storage endpoints that are available to a user's Virtual Organizations
are discoverable via the EGI Information System (BDII).

<!-- markdownlint-disable commands-show-output no-inline-html -->
<!-- TODO Add details about how to setup lcg-infosites CLI -->
<!-- markdownlint-enable no-inline-html -->

The `lcg-infosites` command can be used to obtain VO-specific information on
existing grid storages, using the following syntax:

```shell
$ lcg-infosites --vo voname -[v] -f [site name] [option(s)] [-h| --help] [--is BDII]
```

For example, to list the Storage Elements (SEs) available to the `biomed` VO, we
could issue the following command:

```shell
$ lcg-infosites --vo biomed  se

 Avail Space(kB)  Used Space(kB)  Type  SE
------------------------------------------
    280375465082             n.a  SRM   ccsrm.ihep.ac.cn
     10995116266              11  SRM   cirigridse01.univ-bpclermont.fr

```

## Access from the command-line

Access to grid storage via a command-line interface (CLI) requires users to
obtain a valid X.509 user VOMS proxy. Please refer to the
[Check-in](../../../aai/check-in/vos/voms) documentation for more information.

{{% alert title="Note" color="info" %}} Integration via
[OpenID Connect](https://openid.net/connect) to the
[EGI Check-in service](../../../aai/check-in) is under piloting at some of the
endpoints of the EGI Cloud infrastructure , but it has not yet reached the
production stage. {{% /alert %}}

The CLI widely used to access grid-storage is
[gfal2](https://dmc-docs.web.cern.ch/dmc-docs/gfal2/gfal2.html), which is
available for installation both on RHEL and Debian compatible systems.

In particular, `gfal2` provides an abstraction layer on top of several storage
protocols (XRootD, WebDAV, SRM, gsiftp, etc), offering a convenient API that can
be used over different protocols.

The `gfal2` CLI can be installed as follows (for RHEL compatible systems):

```shell
$ yum install gfal2-util gfal2-all
```

where `gfal2-all` will install all the plug-ins (to deal with all the available
protocols).

Below you can find examples of the usual commands needed to access storage via
`gfal2`. For a complete list of available commands, and the guide on how to use
them, please refer to the
[gfal2-util documentation](https://dmc-docs.web.cern.ch/dmc-docs/gfal2-util.html).

{{% alert title="Note" color="info" %}} In the examples below, the used `gsiftp`
protocol can be replaced by any other supported protocol. {{% /alert %}}

### List files on a given endpoint

```shell
$ gfal-ls gsiftp://dcache-door-doma01.desy.de/dteam
1G.header-1
domatest
gb
SSE-demo
test
tpctest
```

### Create a folder

```shell
$ gfal-mkdir gsiftp://dcache-door-doma01.desy.de/dteam/test
```

<!-- markdownlint-enable commands-show-output -->

### Copy a local file

```shell
$ gfal-copy test.json gsiftp://dcache-door-doma01.desy.de/dteam/test
Copying file:///root/Documents/test.json   [DONE]  after 0s
```

### Copy files between storages

```shell
$ gfal-copy gsiftp://prometheus.desy.de/VOs/dteam/public-file gsiftp://dcache-door-doma01.desy.de/dteam/test
Copying gsiftp://prometheus.desy.de/VOs/dteam/public-file   [DONE]  after 3s
```

### Download a file to a local folder

```shell
$ gfal-copy gsiftp://prometheus.desy.de/VOs/dteam/public-file /tmp
Copying gsiftp://prometheus.desy.de/VOs/dteam/public-file   [DONE]  after 0s
```

### Delete a file

```shell
$ gfal-rm gsiftp://dcache-door-doma01.desy.de/dteam/test/public-file
gsiftp://dcache-door-doma01.desy.de/dteam/test/public-file      DELETED
```

## Access via EGI Data Transfer

<!-- markdown-link-check-disable -->

The [EGI Data Transfer](../../../data/management/data-transfer) service provides
mechanisms to optimize the transfer of files between EGI Online Storage
endpoints. Both a
[graphical user interface](../../../data/management/data-transfer/webfts) (GUI)
and [command-line interfaces](../../../data/management/data-transfer/clients)
(CLI) are available to perform bulk movement of data. Please check out the
related documentation for more information.

<!-- markdown-link-check-enable -->

## Integration with Data Management frameworks

Grid storage access, most of the time, is hidden from users by the integration
with the Data Management Frameworks (DMFs) used by Collaborations and
Experiments.

For example,
[EGI Workload Manager](../../../compute/orchestration/workload-manager) provides
a way to efficiently access grid storage endpoints in order to read/store files,
and to catalogue the existing file and related metadata.

When running computation via the EGI Workload Manager, users do not actually
access the storage directly. However, users can retrieve the output of the
computation once it has been stored on the grid.
