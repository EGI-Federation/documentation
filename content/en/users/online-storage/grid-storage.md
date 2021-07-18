---
title: "Grid Storage"
linkTitle: "Grid Storage"
type: docs
weight: 55
description: >
  Grid Storage offered by EGI HTC providers
---

## Grid Storage

Grid Storage allows you to store data in a reliable and high-quality environment
and share it across distributed teams. Your data can be accessed through
different protocols and can be replicated across different providers to increase
fault-tolerance. Grid Storage gives you complete control over the data you share
and with whom. Main features:

- Access highly-scalable storage from anywhere
- Control the data you share
- Organise your data using a flexible hierarchical structure

Grid Storage file access is based on
[gridFTP](https://en.wikipedia.org/wiki/GridFTP) and
[WebDav/HTTP](https://en.wikipedia.org/wiki/WebDAV) protocols together with
[XRootD](https://xrootd.slac.stanford.edu/) and legacy
[SRM](https://www.gridpp.ac.uk/wiki/SRM) (under deprecation at some of the
endpoints).

Several Grid storage implementation are available on the infrastructure, the
most common are the following:

- [dCache](https://www.dcache.org/)
- [DPM](https://twiki.cern.ch/twiki/bin/view/DPM/)
- [StoRM](https://italiangrid.github.io/storm/)

## Endpoint Discovery

The Storage endpoints that are available to user's Virtual Organizations are
discoverable via the EGI Information System (BDII).

The lcg-infosites command can be used to obtain VO-specific information on
existing grid storages

The syntax is the following:

```shell
lcg-infosites --vo voname -[v] -f [site name] [option(s)] [-h| --help]
  [--is BDII]
```

For example, to list the Storage Elements (SEs) available to the biomed VO one
could issue the following command:

```shell
lcg-infosites --vo biomed  se

lcg-infosites --vo biomed  se
 Avail Space(kB)  Used Space(kB)  Type  SE
------------------------------------------
    280375465082             n.a  SRM   ccsrm.ihep.ac.cn
     10995116266              11  SRM   cirigridse01.univ-bpclermont.fr

```

## Client access

The access via client requires the user to obtain a valid X.509 user VOMS proxy.
Please refer to the [Check-in doc](../../check-in/vos/voms) for more
information. Integration with OpenID Connect and the EGI Check-in service is
under piloting at some of the endpoints on the infrastructure , but it has not
yet reached the production stage.

The client widely used to access grid-storage is
[gfal2](https://dmc-docs.web.cern.ch/dmc-docs/gfal2/gfal2.html) which is
available for installation both on RHEL and Debian compatible systems.

In particular, gfal2 provides and abstraction layer on top of several storage
protocols (XRootD, WebDAV, SRM, gsiftp, etc) and therefore is quite convenient
as the same API can be used to access different protocols.

The gfal2 CLI can be installed as follows (for RHEL compatible systems):

```shell
yum install gfal2-util gfal2-all

```

where _gfal2-all_ will install all the plug-ins to deal with all the available
protocols.

In the following example the command to access storages via gfal2 are
documented. Please note that the access via gsiftp protocol in the following
example can be replaced by any other supported protocols

List files on a given endpoint:

```shell
gfal-ls gsiftp://dcache-door-doma01.desy.de/dteam
1G.header-1
domatest
gb
SSE-demo
test
tpctest
```

Create a folder:

```shell
gfal-mkdir gsiftp://dcache-door-doma01.desy.de/dteam/test
```

Copy a local file:

```shell
gfal-copy test.json gsiftp://dcache-door-doma01.desy.de/dteam/test
Copying file:///root/Documents/test.json   [DONE]  after 0s
```

Copy files between storages:

```shell
gfal-copy gsiftp://prometheus.desy.de/VOs/dteam/public-file gsiftp://dcache-door-doma01.desy.de/dteam/test
Copying gsiftp://prometheus.desy.de/VOs/dteam/public-file   [DONE]  after 3s
```

Download a file to a local folder:

```shell
gfal-copy gsiftp://prometheus.desy.de/VOs/dteam/public-file /tmp
Copying gsiftp://prometheus.desy.de/VOs/dteam/public-file   [DONE]  after 0s
```

Delete a file:

```shell
gfal-rm gsiftp://dcache-door-doma01.desy.de/dteam/test/public-file
gsiftp://dcache-door-doma01.desy.de/dteam/test/public-file      DELETED
```

More commands are available, please refer to the
[gfal2-util documentation](https://dmc-docs.web.cern.ch/dmc-docs/gfal2-util.html)

## Access via the EGI Data Transfer service

The [EGI Data Transfer](../../data-transfer/) service provides mechanism to
optimize the transfer of files between EGI Online storage endpoints. Both a
graphical interface and CLI are available to perform bulk movement of data.
Please check the related documentation for more information.

## Integration with Data Management frameworks

Grid Storage access most of the time is hidden to users by the integration
performed within the Data Management framework used by Collaborations and
Experiments.

In EGI for instance, the EGI Workload Management System
[EGI Workload Manager](../../workload-manager/), provides a way to efficiently
access grid storage endpoints in order to read and store files on the
infrastructures and to catalogue the existing file and related location.

The users when running computation via DIRAC does not actually access the
storage directly, but they can of course retrieve the output of the computation
which has been stored by the system on the grid.
