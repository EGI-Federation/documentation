---
title: "Storage accounting"
weight: 35
type: "docs"
description: "Enable Storage Accounting Record (StAR) in your storage element"
---

## Introduction

Storage space usage accounting in APEL is based on the StAR (Storage Accounting
Record) developed during the EMI project in conjunction with the OGF Usage
Record Work Group (UR-WG). The format is documented
[here](http://cds.cern.ch/record/1452920/files/GFD.201.pdf).

EMI delivered StAR solutions for dCache and DPM in EMI-3. In both cases the
storage service queries its database at a site and extracts data to populate
StAR usage records. The site then uses SSM as a transport method to send the
StAR records via the EGI Messaging Service to APEL's central Accounting
Repository.

## Deployment instructions

### Accounting script for dCache

The configuration follows the same configuration system that is common to all
dCache components. In keeping with other dCache components, the default values
are exposed and well documented.

In general, a site should review the `star.properties` file (in the standard
location for configuration defaults) and update their site-specific
configuration, if necessary.

Information on how to set the `star.properties` file can be found
[here](https://github.com/dCache/dcache/blob/master/skel/share/defaults/star.properties)

Map `local groupid` to the VO names as appropriate, for example:

```ini
star.gid-mapping = 12345=/atlas,12346=/cms,12347=/lhcb (EXAMPLE)
```

Running the dcache-star command will generate records according to that site's
configuration.

Edit SSM's `sender.cfg` to have `path:/var/spool/dcache/star` so that it can
find and publish the records dcache generated.

### Accounting script for DPM

{{% alert title="Important" color="warning" %}} DPM/DMLite is supported until June
2023.
All of the RCs providing DPM have been invited to move to a different storage
solution.
A decommission and migration campaign was started at this purpose.
{{% /alert %}}

You need to install DPM-DMLITE 1.8.7 or higher.
The [Storage Accounting](https://twiki.cern.ch/twiki/bin/view/DPM/DpmSetupPuppetInstallation#DPM_Accounting)
is implemented as a puppet module that adds cron configuration to execute the
script daily.

Please be sure to have installed the
[star-accounting.py script](https://gitlab.cern.ch/lcgdm/dmlite/-/blob/master/scripts/StAR-accounting/star-accounting.py)
v1.0.4 at least.

### Accounting script for EOS

jgfkhfkhg
