---
title: HOWTO03 Site Certification GIIS Check
weight: 120
type: "docs"
description: "How to test a Resource Centre during certification"
---

Be sure that Resource Centre GIIS URL is contained in the BDII you use for
certification.

## Check the consistency of the published information

These are the main branches of the LDAP tree:

- `GlueSiteUniqueID`
- `GlueSubClusterUniqueID`
- `GlueCEUniqueID`
- `GlueCESEBind`
- `GlueSEUniqueID`
- `GlueServiceUniqueID`

It is recommended to use the
[Apache Studio LDAP browser](http://directory.apache.org/studio/), although in
this page `ldapsearch` queries are shown.

### Contact information

Under the branch `GlueSiteUniqueID` check the values of the following fields:

- `GlueSiteName`
- `GlueSiteUserSupportContact`
- `GlueSiteSysAdminContact`
- `GlueSiteSecurityContact`
- `GlueSiteOtherInfo`

**Example:**

```shell
$ ldapsearch -x -LLL -H ldap://sibilla.cnaf.infn.it:2170 \
    -b mds-vo-name=INFN-CNAF,o=grid 'objectClass=GlueSite' \
    GlueSiteName GlueSiteUserSupportContact GlueSiteSysAdminContact \
    GlueSiteSecurityContact GlueSiteOtherInfo

dn: GlueSiteUniqueID=INFN-CNAF,Mds-Vo-name=INFN-CNAF,o=grid
GlueSiteSecurityContact: mailto:grid-sec@cnaf.infn.it
GlueSiteSysAdminContact: mailto:grid-operations@lists.cnaf.infn.it
GlueSiteName: INFN-CNAF
GlueSiteOtherInfo: CONFIG=yaim
GlueSiteOtherInfo: EGEE_SERVICE=prod
GlueSiteOtherInfo: EGI_NGI=NGI_IT
GlueSiteOtherInfo: GRID=WLCG
GlueSiteOtherInfo: GRID=EGI
GlueSiteOtherInfo: WLCG_TIER=3
GlueSiteUserSupportContact: mailto:grid-operations@lists.cnaf.infn.it
```

### Information related to software environment

Under the branch `GlueSubClusterUniqueID` check the values of the following
fields:

- Check that the `GlueHostApplicationSoftwareRunTimeEnvironment` contains a list
  of software tags supported by the site.
  - The list can include VO-specific software tags.
  - In order to ensure backwards compatibility it should include the entry
    'LCG-2', the current middleware version and the list of previous middleware
    tags (i.e. LCG-2 LCG-2_1_0 LCG-2_1_1 LCG-2_2_0 LCG-2_3_0 LCG-2_3_1 LCG-2_4_0
    LCG-2_5_0 LCG-2_6_0 LCG-2_7_0 GLITE-3_0_0 GLITE-3_1_0 GLITE-3_2_0 R-GMA).
- `GlueHostProcessorOtherDescription` (see [FAQ HEP SPEC06](../faq-hepspec06))
- `GlueHostOperatingSystemName`, `GlueHostOperatingSystemVersion` and
  `GlueHostOperatingSystemRelease` (see
  [publishing the OS name](#publishing-the-os-name)).

**Example:**

```shell
$ ldapsearch -x -LLL -H `<ldap://virgo-ce.roma1.infn.it:2170>` \
    -b mds-vo-name=resource,o=grid 'objectClass=GlueSubCluster' \
    GlueHostProcessorOtherDescription

dn: GlueSubClusterUniqueID=virgo-ce.roma1.infn.it,GlueClusterUniqueID=virgo-ce.roma1.infn.it,Mds-Vo-name=resource,o=grid
GlueHostProcessorOtherDescription: Cores=4, Benchmark=7.83-HEP-SPEC06
```

#### Publishing the OS name

It has been decided that the 3 fields

- `GlueHostOperatingSystemName`
- `GlueHostOperatingSystemRelease`
- `GlueHostOperatingSystemVersion`

should be parsed from the output of `/usr/bin/lsb_release`, like this:

- `GlueHostOperatingSystemName`: `lsb_release -i | cut -f2`
- `GlueHostOperatingSystemRelease`: `lsb_release -r | cut -f2`
- `GlueHostOperatingSystemVersion`: `lsb_release -c | cut -f2`

yielding values like

- `GlueHostOperatingSystemName`: CentOS
- `GlueHostOperatingSystemRelease`: 7.9.2009
- `GlueHostOperatingSystemVersion`: Core

This has been tested on various Linux flavours and should work on every serious
GNU/Linux distribution.

### Information about the batch system

Under the branch `GlueCEUniqueID` check the values of the following fields:

- `GlueCEInfoTotalCPUs`: Check that the value is higher than 0.
- `GlueCEStateWaitingJobs`: If there is a “44444”, the information providers are
  not working properly.
- `GlueCEInfoLRMSType`: any supported batch system (sge, pbs, lsf...)
- `GlueCEStateStatus`: Production, Draining, Queuing or Closed are accepted
  values.
- `GlueCEAccessControlBaseRule`: VOs enabled on the queue
- `GlueCECapability`

**Example:**

```shell
$ ldapsearch -x -LLL -H ldap://virgo-ce.roma1.infn.it:2170 \
    -b mds-vo-name=INFN-ROMA1-VIRGO,o=grid 'objectClass=GlueCE' \
    GlueCEInfoTotalCPUs GlueCEInfoJobManager GlueCEImplementationName

dn: GlueCEUniqueID=virgo-ce.roma1.infn.it:2119/jobmanager-lcgpbs-theophys,Mds-Vo-name=INFN-ROMA1-VIRGO,o=grid
GlueCEImplementationName: LCG-CE
GlueCEInfoJobManager: lcgpbs
GlueCEInfoTotalCPUs: 8

dn: GlueCEUniqueID=virgo-ce.roma1.infn.it:2119/jobmanager-lcgpbs-cert,Mds-Vo-name=INFN-ROMA1-VIRGO,o=grid
GlueCEImplementationName: LCG-CE
GlueCEInfoJobManager: lcgpbs
GlueCEInfoTotalCPUs: 8

dn: GlueCEUniqueID=virgo-ce.roma1.infn.it:2119/jobmanager-lcgpbs-virgoglong,Mds-Vo-name=INFN-ROMA1-VIRGO,o=grid
GlueCEImplementationName: LCG-CE
GlueCEInfoJobManager: lcgpbs
GlueCEInfoTotalCPUs: 8

dn: GlueCEUniqueID=virgo-ce.roma1.infn.it:2119/jobmanager-lcgpbs-argo,Mds-Vo-name=INFN-ROMA1-VIRGO,o=grid
GlueCEImplementationName: LCG-CE
GlueCEInfoJobManager: lcgpbs
GlueCEInfoTotalCPUs: 8

dn: GlueCEUniqueID=virgo-ce.roma1.infn.it:2119/jobmanager-lcgpbs-virgogshort,Mds-Vo-name=INFN-ROMA1-VIRGO,o=grid
GlueCEImplementationName: LCG-CE
GlueCEInfoJobManager: lcgpbs
GlueCEInfoTotalCPUs: 8
```

```shell
$ ldapsearch -x -LLL -H ldap://cmsrm-bdii.roma1.infn.it:2170 \
    -b mds-vo-name=INFN-ROMA1-CMS,o=grid 'objectclass=GlueCE' GlueCECapability

dn: GlueCEUniqueID=cmsrm-ce01.roma1.infn.it:2119/jobmanager-lcglsf-cmsgcert,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100

dn: GlueCEUniqueID=cmsrm-ce01.roma1.infn.it:2119/jobmanager-lcglsf-cmsglong,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100

dn: GlueCEUniqueID=cmsrm-ce01.roma1.infn.it:2119/jobmanager-lcglsf-cmsgshort,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100

dn: GlueCEUniqueID=cmsrm-ce02.roma1.infn.it:2119/jobmanager-lcglsf-cmsglong,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100

dn: GlueCEUniqueID=cmsrm-ce02.roma1.infn.it:2119/jobmanager-lcglsf-cmsgcert,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100

dn: GlueCEUniqueID=cmsrm-ce02.roma1.infn.it:2119/jobmanager-lcglsf-cmsgshort,Mds-Vo-name=INFN-ROMA1-CMS,o=grid
GlueCECapability: CPUScalingReferenceSI00=1515
GlueCECapability: Share=cms:100
```

### Information on Computing Element about Storage Elements

For each SE, on the CEs the following values must be present:

- `GueCESEBindSEUniqueID`.
  - `GlueCESEBindCEAccesspoint` and `GlueCESEBindMountInfo`.

**Example:**

```shell
$ ldapsearch -x -LLL -H ldap://cremino.cnaf.infn.it:2170 \
    -b mds-vo-name=resource,o=grid 'objectClass=GlueCESEBind' \
    GlueCESEBindSEUniqueID GlueCESEBindCEUniqueID GlueCESEBindMountInfo

dn: GlueCESEBindSEUniqueID=sunstorm.cnaf.infn.it,GlueCESEBindGroupCEUniqueID=cremino.cnaf.infn.it:8443/cream-pbs-cert,Mds-Vo-name=resource,o=grid
GlueCESEBindSEUniqueID: sunstorm.cnaf.infn.it
GlueCESEBindMountInfo: n.a
GlueCESEBindCEUniqueID: cremino.cnaf.infn.it:8443/cream-pbs-cert

dn: GlueCESEBindSEUniqueID=sunstorm.cnaf.infn.it,GlueCESEBindGroupCEUniqueID=cremino.cnaf.infn.it:8443/cream-pbs-prod,Mds-Vo-name=resource,o=grid
GlueCESEBindSEUniqueID: sunstorm.cnaf.infn.it
GlueCESEBindMountInfo: n.a
GlueCESEBindCEUniqueID: cremino.cnaf.infn.it:8443/cream-pbs-prod
```

### Information on Storage Elements

Under the branch `GlueSEUniqueID` check the values of the following fields:

- `GlueSALocalID`: VO information
- `GlueSEAccessProtocolLocalID` : rfio, srm_v2, gsiftp, gsidcap
- `GlueSEImplementationName` (deprecated)
- `GlueSEArchitecture`
- `GlueSAStateUsedSpace`
- `GlueSAStateAvailableSpace`
- `GlueSACapability`

**Example:**

```shell
$ ldapsearch -x -LLL -H ldap://grid-se.pv.infn.it:2170 \
    -b mds-vo-name=resource,o=grid 'objectclass=GlueSE'

dn: GlueSEUniqueID=grid-se.pv.infn.it,Mds-Vo-name=resource,o=grid
GlueSEImplementationVersion: 1.7.4
GlueSETotalOnlineSize: 8795
GlueSEStatus: Production
objectClass: GlueTop
objectClass: GlueSE
objectClass: GlueKey
objectClass: GlueSchemaVersion
GlueSETotalNearlineSize: 0
GlueSEArchitecture: multidisk
GlueSESizeTotal: 8795
GlueSESizeFree: 5458
GlueSEName: INFN-PAVIA DPM server
GlueSchemaVersionMinor: 3
GlueSEUsedNearlineSize: 0
GlueForeignKey: GlueSiteUniqueID=INFN-PAVIA
GlueSEUsedOnlineSize: 3336
GlueSchemaVersionMajor: 1
GlueSEImplementationName: DPM
GlueSEUniqueID: grid-se.pv.infn.it
```

```shell
$ ldapsearch -x -LLL -H ldap://grid-se.pv.infn.it:2170 \
    -b mds-vo-name=resource,o=grid 'objectclass=GlueSA' \
    GlueSAAccessControlBaseRule GlueSACapability

dn: GlueSALocalID=storage:replica:online,GlueSEUniqueID=grid-se.pv.infn.it,Mds-Vo-name=resource,o=grid
GlueSAAccessControlBaseRule: VO:atlas
GlueSAAccessControlBaseRule: VO:dteam
GlueSAAccessControlBaseRule: VO:infngrid
GlueSAAccessControlBaseRule: VO:ops
GlueSACapability: InstalledOnlineCapacity=8258
GlueSACapability: InstalledNearlineCapacity=0

dn: GlueSALocalID=ATLASHOTDISK:SR:replica:online,GlueSEUniqueID=grid-se.pv.infn.it,Mds-Vo-name=resource,o=grid
GlueSAAccessControlBaseRule: VOMS:/atlas/Role=production
GlueSACapability: InstalledOnlineCapacity=536
GlueSACapability: InstalledNearlineCapacity=0
```

```shell
$ ldapsearch -x -LLL -H ldap://grid-se.pv.infn.it:2170 \
    -b mds-vo-name=resource,o=grid
    '(&(objectclass=GlueSA)(GlueSALocalID=storage:replica:online))' \
    GlueSAReservedNearlineSize GlueSAFreeNearlineSize \
    GlueSATotalNearlineSize GlueSAUsedNearlineSize GlueSACapability \
    GlueSATotalOnlineSize GlueSAFreeOnlineSize \
    GlueSAReservedOnlineSize GlueSAStateAvailableSpace \
    GlueSAUsedOnlineSize GlueSAStateUsedSpace

dn: GlueSALocalID=storage:replica:online,GlueSEUniqueID=grid-se.pv.infn.it,Mds-Vo-name=resource,o=grid
GlueSATotalNearlineSize: 0 GlueSAFreeOnlineSize: 4921
GlueSAUsedNearlineSize: 0 GlueSAFreeNearlineSize: 0
GlueSAReservedNearlineSize: 0 GlueSAStateAvailableSpace: 4921376492
GlueSAReservedOnlineSize: 0 GlueSAUsedOnlineSize: 3336
GlueSAStateUsedSpace: 3336991982 GlueSATotalOnlineSize: 8258
GlueSACapability: InstalledOnlineCapacity=8258
GlueSACapability: InstalledNearlineCapacity=0
```

### Information about other services

There is a branch `GlueServiceUniqueID` for each service published by the site
(WMS, LFC, DPM, GRIDICE, LB, MYPROXY, BDII, etc): what discriminates the
services are the values of `GlueServiceType`, example:

- `lcg-file-catalog`
- `org.glite.wms.WMProxy`
- `org.glite.lb.Server`
- `srm_v1, SRM`

**Example:**

```shell
$ ldapsearch -x -LLL -H ldap://sibilla.cnaf.infn.it:2170 \
    -b mds-vo-name=INFN-CNAF,o=grid 'objectClass=GlueService' \
    GlueServiceType GlueServiceEndpoint GlueServiceName

dn: GlueServiceUniqueID=lfcserver.cnaf.infn.it,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: lfcserver.cnaf.infn.it
GlueServiceName: INFN-CNAF-lfc
GlueServiceType: lcg-file-catalog

dn: GlueServiceUniqueID=local-lfcserver.cnaf.infn.it,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: lfcserver.cnaf.infn.it
GlueServiceName: INFN-CNAF-lfc
GlueServiceType: lcg-local-file-catalog

dn: GlueServiceUniqueID=<http://lfcserver.cnaf.infn.it:8085/,Mds-Vo-name=INFN-CNAF,o=grid>
GlueServiceEndpoint: <http://lfcserver.cnaf.infn.it:8085/>
GlueServiceName: INFN-CNAF-lfc-dli
GlueServiceType: data-location-interface

dn: GlueServiceUniqueID=myproxy.cnaf.infn.it_MyProxy_4027652676,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: myproxy://myproxy.cnaf.infn.it:7512/
GlueServiceName: INFN-CNAF-MyProxy
GlueServiceType: MyProxy

dn: GlueServiceUniqueID=sibilla.cnaf.infn.it_bdii_site_3877936872,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <ldap://sibilla.cnaf.infn.it:2170/mds-vo-name=INFN-CNAF,o=grid>
GlueServiceName: INFN-CNAF-bdii_site
GlueServiceType: bdii_site

dn: GlueServiceUniqueID=local-http://lfcserver.cnaf.infn.it:8085/,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <http://lfcserver.cnaf.infn.it:8085/>
GlueServiceName: INFN-CNAF-lfc-dli
GlueServiceType: local-data-location-interface

dn: GlueServiceUniqueID=mon-it.cnaf.infn.it_Regional-NAGIOS_2937827985,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <https://mon-it.cnaf.infn.it:443/nagios>
GlueServiceName: INFN-CNAF-Regional-NAGIOS
GlueServiceType: Regional-NAGIOS

dn: GlueServiceUniqueID=httpg://sunstorm.cnaf.infn.it:8444/srm/managerv2,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: httpg://sunstorm.cnaf.infn.it:8444/srm/managerv2
GlueServiceName: INFN-CNAF-SRM
GlueServiceType: SRM

dn: GlueServiceUniqueID=albalonga.cnaf.infn.it_org.glite.lb.server_889826742,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <https://albalonga.cnaf.infn.it:9003/>
GlueServiceName: INFN-CNAF-server
GlueServiceType: org.glite.lb.server

dn: GlueServiceUniqueID=gridit-ce-001.cnaf.infn.it_org.edg.gatekeeper_715226072,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: gram://gridit-ce-001.cnaf.infn.it:2119/
GlueServiceName: INFN-CNAF-gatekeeper
GlueServiceType: org.edg.gatekeeper

dn: GlueServiceUniqueID=egee-wms-01.cnaf.infn.it_org.glite.wms.WMProxy_2200630265,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <https://egee-wms-01.cnaf.infn.it:7443/glite_wms_wmproxy_server>
GlueServiceName: INFN-CNAF-WMProxy
GlueServiceType: org.glite.wms.WMProxy

dn: GlueServiceUniqueID=cremino.cnaf.infn.it_org.glite.ce.CREAM_860197007,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <https://cremino.cnaf.infn.it:8443/ce-cream/services>
GlueServiceName: INFN-CNAF-CREAM
GlueServiceType: org.glite.ce.CREAM

dn: GlueServiceUniqueID=cremino.cnaf.infn.it_org.glite.ce.Monitor_2670664997,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <https://cremino.cnaf.infn.it:8443/ce-monitor/services/CEMonitor>
GlueServiceName: INFN-CNAF-Monitor
GlueServiceType: org.glite.ce.Monitor

dn: GlueServiceUniqueID=top-bdii01.cnaf.infn.it_bdii_top_1813027130,Mds-Vo-name=INFN-CNAF,o=grid
GlueServiceEndpoint: <ldap://egee-bdii.cnaf.infn.it:2170/mds-vo-name=local,o=grid>
GlueServiceName: INFN-CNAF-bdii_top
GlueServiceType: bdii_top

[...]
```

See the Site Certification Manual tests
[HOWTO04](../howto04_site_certification_manual_tests)

See to Resource Centre registration and certification procedure
[PROC09](https://confluence.egi.eu/display/EGIPP/PROC09+Resource+Centre+Registration+and+Certification).
