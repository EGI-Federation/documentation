---
title: "Storage accounting"
weight: 20
type: "docs"
description: "Using Storage Accounting Record (StAR)"
---

## Introduction

Storage space usage accounting is based on the StAR (Storage Accounting Record)
developed during the EMI project in conjunction with the OGF Usage Record Work
Group (UR-WG). The format is documented
[in GFD-I.201](http://cds.cern.ch/record/1452920/files/GFD.201.pdf).

EMI delivered StAR solutions for dCache and DPM in EMI-3. In both cases the
storage service queries its database at a site and extracts data to populate
StAR usage records. The site then uses SSM as a transport method to send the
StAR records via the EGI Messaging Service to
[EGI Accounting](../../../internal/accounting) repository.

## Deployment instructions

### Accounting script for dCache

{{% alert title="Note" color="info" %}} Find dCache documentation on the
[dCache site](https://www.dcache.org/documentation/).
{{% /alert %}}

The configuration follows the same configuration system that is common to all
dCache components. As with other dCache components, the default values are
exposed and documented.

In general, a site should review the `star.properties` file (in the standard
location for configuration defaults) and update their site-specific
configuration, if necessary.

Information on how to set the `star.properties` file can be found
[in the dCache repository](https://github.com/dCache/dcache/blob/master/skel/share/defaults/star.properties).

Map `local groupid` to the VO names as appropriate, for example:

```ini
star.gid-mapping = 12345=/atlas,12346=/cms,12347=/lhcb (EXAMPLE)
```

Running the `dcache-star` command generates records according to that site's
configuration.

Edit SSM's `sender.cfg` to have `path:/var/spool/dcache/star` so that it can
find and publish the records dCache generated.

### Accounting script for DPM

{{% alert title="Important" color="warning" %}} DPM/DMLite is supported until
June 2023. All the RCs providing DPM have been invited to move to a different
storage solution. A decommissioning and migration campaign was started for this
purpose. {{% /alert %}}

You need to install DPM-DMLITE 1.8.7 or higher. The
[Storage Accounting](https://twiki.cern.ch/twiki/bin/view/DPM/DpmSetupPuppetInstallation#DPM_Accounting)
is implemented as a puppet module that adds cron configuration to execute the
script daily.

Please be sure to have installed the
[star-accounting.py script](https://gitlab.cern.ch/lcgdm/dmlite/-/blob/master/scripts/StAR-accounting/star-accounting.py)
v1.0.4 at least.

### Accounting script for EOS

The script generating the required space accounting information is available in
the `eos-server` package starting with release 5.0.15.

Please have a look at the
[EOS documentation](https://eos-docs.web.cern.ch/configuration/egi.html#storage-accounting)
for more information.

### Install the APEL SSM software

The [APEL SSM](https://github.com/apel/ssm) software can be installed from the
[UMD-4 repository](https://repository.egi.eu/).

### Add the information to EGI Configuration Database

You need to add a new service endpoint for that host to
[EGI Configuration Database](https://goc.egi.eu/) with the service type
`eu.egi.storage.accounting` and the correct host certificate DN. The Accounting
Repository takes up to an hour to update its ACL from the configuration Database
and the [EGI Messaging Service](../../../internal/messaging/) take up to 4
hours. If you get warnings in your SSM log about invalid username or password
you can retry again after a delay. If this persists for over 4 hours, then do
open a [Helpdesk ticket](https://ggus.eu/).

### Configure SSM

Set the configuration files as explained in the
[general documentation](https://github.com/apel/ssm#sender-sending-via-the-argo-messaging-service-ams)
and in the
[migration instructions](https://github.com/apel/ssm/blob/dev/migrating_to_ams.md#sender).

## Running the Accounting Software

Create a cron job to run your accounting script followed by calling the SSM
sender. We recommend that you send storage accounting data once per day. There
will be a delay of up to 24 hours before you see the data you have sent
reflected in the Accounting Portal.

- Example:

```shell
$ cat /etc/cron.daily/dmlite-StAR-accounting
#!/bin/sh
set -e
mkdir -p /var/spool/apel/outgoing/`date +%Y%m%d`
/usr/share/dmlite/StAR-accounting/star-accounting.py --reportgroups \
  --dbhost=[hostname] \
  --dbuser=[username] \
  --dbpwd=[password] \
  --nsdbname=cns_db \
  --dpmdbname=dpm_db \
  --site=[site name] > /var/spool/apel/outgoing/`date +%Y%m%d`/`date +%Y%m%d%H%M%S`
ssmsend
```

> You can confirm if the [Accounting Repository](../../../internal/accounting/)
> receives your data by looking at the
> [sites publishing storage accounting records](http://goc-accounting.grid-support.ac.uk/storagetest/storagesitesystems.html)

The page is updated on a daily basis.

## Storage Accounting Data at the EGI Accounting Portal

The storage accounting view is currently available on the
[development instance](http://accounting-devel.egi.eu/storage.php) of the
Accounting Portal.
