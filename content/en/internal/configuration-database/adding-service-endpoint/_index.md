---
title: Adding service endpoints
description: "Adding service endpoints information into Configuration Database"
weight: 30
type: "docs"
---

For monitoring purposes, each service endpoints registered into the
Configuration Database, and having the flags _production_ and _monitored_ should
include the endpoint URL information in order to be contacted by the
corresponding service-specific nagios probe.

The information needed for service type are:

- **SRM**: the value of the attribute `GlueServiceEndpoint` published in the
  Configuration Database or BDII (e.g. `httpg://se.egi.eu:8444/srm/managerv2`)
- Cloud:
  - **org.openstack.nova**: The `endpoint URL` must contain the Keystone v3 URL:
    `https://hostname:port/url/v3`
  - **org.openstack.swift**:The `endpoint URL` must contain the Keystone v3 URL:
    `https://hostname:port/url/v3`
  - **eu.egi.cloud.accounting**: for the host sending the records to the
    accounting repository
- Other service types: the value of the attribute `GlueServiceEndpoint`
  published in the BDII

It is also possible to register additional endpoints for every services, they
will also be monitored if the "Monitored" flag is set.

For having more information about managing the Service endpoints in the
Configuration Database, please consult the
[service endpoints documentation](../service-entities).

## Retrieving the information

For retrieving the queue URL from the BDII, you can use the command
`lcg-infosites`, to be executed from a UI. Be sure to query a production Top
BDII: you can either use the one provided by your Operations Centre or choose
one from
[the Configuration Database](https://goc.egi.eu/portal/index.php?Page_Type=Service_Group&id=1205)

For example:

```shell
$ export LCG_GFAL_INFOSYS=egee-bdii.cnaf.infn.it:2170

$ lcg-infosites --vo ops ce | grep nikhef
  5680      15          0            0       0 dissel.nikhef.nl:2119/jobmanager-pbs-infra
  5680      17          1            1       0 gazon.nikhef.nl:8443/cream-pbs-infra
  5680      15          0            0       0 juk.nikhef.nl:8443/cream-pbs-infra
  5680      15          0            0       0 klomp.nikhef.nl:8443/cream-pbs-infra
  5680      16          0            0       0 stremsel.nikhef.nl:8443/cream-pbs-infra
```

In order to find the `GlueServiceEndpoint` URL of your SRM service, you can
launch a LDAP query to your Site BDII (or directly to the SRM service):

```shell
$ ldapsearch -x -LLL -H ldap://sbdii01.ncg.ingrid.pt:2170 \
  -b "mds-vo-name=NCG-INGRID-PT,o=grid" \
  '(&(objectClass=GlueService)(GlueServiceType=SRM))' \
  GlueServiceEndpoint

dn: GlueServiceUniqueID=httpg://srm01.ncg.ingrid.pt:8444/srm/managerv2,Mds-Vo-name=NCG-INGRID-PT,o=grid
GlueServiceEndpoint: httpg://srm01.ncg.ingrid.pt:8444/srm/managerv2
```

In a similar way, by just changing the value of `GlueServiceType`, you can
retrieve the endpoint URLs of other services.

An alternative way for retrieving the `GlueServiceEndpoint` URL is using the
GLUE2 information browser provided by
[VAPOR](https://operations-portal.egi.eu/vapor/resources/GL2ResNGISites): select
your NGI, then your site and hence the Storage service; click on the _endpoint
details_ button for finding the URL associated to the SRM interface.

## Filling the information in

### URLs information are completely missing

#### Editing the services information

- Site overview

This is the home page regarding your site. You need to fill in the URL
information.

> Click on a service for displaying its page (e.g. the CREAM-CE).

![Site overview](site-overview.png)

- Editing a service

> Click on the EDIT button in the top right corner

![Service overview](service-overview.png)

- Adding a Service URL

> fill in the _Service URL_ field with the queue URL

![Service Edition](service-edition.png)

- Reviewing the site

Now the CREAM-CE service endpoint contains the required queue information.

> Proceed in a similar way for the other services.

![Completed service overview](completed-service-overview.png)

### Additional endpoints information

In case you need to register an additional endpoint for a service, go on the
service summary page and add the proper information. In the example below it is
shown the case of a computing element.

- Service summary page

This is the service summary page.

> You need to click on the _Add endpoint_ button for registering additional
> endpoint URLs.

![Service summary page](service-summary-page.png)

- Adding an endpoint

> Fill in the proper information and don't forget to select the "Monitored" flag
> for making Nagios to detect the new endpoint.

![Adding and endpoint](add-endpoint.png)

- Reviewing the endpoint description

The summary page of the endpoint just added should look like this one.

![Service endpoint page](service-endpoint-page.png)

- Reviewing the service description

And this is the summary page of the service reporting the information about all
its endpoints registered: the first one in the _Grid Information_ section and
the additional ones in the _Service Endpoints_ section.

![Service summary page](service-description-review.png)

## Examples

### webdav

In order to properly monitor your webdav endpoint:

- you should register a new service endpoint with the webdav service type,
  separated from the SRM one;
- the endpoint URL information used for monitoring purposes should be set in the
  [extension properties](../extension-properties) section. Create the following:
  - Name: ARGO_WEBDAV_OPS_URL
  - Value: webdav URL containing also the VO ops folder, for example:
    `https://darkstorm.cnaf.infn.it:8443/webdav/ops` or
    `https://hepgrid11.ph.liv.ac.uk/dpm/ph.liv.ac.uk/home/ops/`
    - it corresponds to the value of GLUE2 attribute `GLUE2EndpointURL`
      (containing the used port and without the VO folder);
- verify that the webdav URL (for example:
  `https://darkstorm.cnaf.infn.it:8443/webdav`) is properly accessible.

### EOS and XrootD service endpoints

The EOS service endpoints expose an XrootD interface, so in order to properly
monitor them, even in case you provide a plain XrootD endpoint, please do the
following:

- you should register a new service endpoint with the XrootD service type;
- the endpoint URL information used for monitoring purposes should be set in the
  [extension properties](../extension-properties) section. Create the following:
  - Name: ARGO_XROOTD_OPS_URL
  - Value: XRootD base SURL to test (the path where ops VO has write access),
    for example: `root://eosatlas.cern.ch//eos/atlas/opstest/egi/`,
    `root://recas-se-01.cs.infn.it:1094/dpm/cs.infn.it/home/ops/`,
    `root://dcache-atlas-xrootd-ops.desy.de:2811/pnfs/desy.de/ops` or similar).
    Pay attention to the port configured for the interface.

### GridFTP

In order to properly monitor your gridftp endpoint for ops VO

- register a new service endpoint, associating the storage element hostname to
  the service type `globus-GRIDFTP`, with the "production" flag disabled;
- in the “[Extension Properties](../extension-properties)” section of the
  service endpoint page, fill in the following fields:
  - Name: SE_PATH
  - Value: `/dpm/ui.savba.sk/home/ops` (this is an example, set the proper path)
- check if the tests are OK (it might take some hours for detecting the new
  service endpoint) and then switch the production flag to "yes"

### SURL value for SRM

The SURL value needed by the SRM monitoring probes is the following structure:

`srm://<hostname>:<port>/srm/managerv2?SFN=<GlueSAPath or GlueVOInfoPath>`

For example:

`srm://ccsrm.in2p3.fr:8443/srm/managerv2?SFN=/pnfs/in2p3.fr/data/dteam/`

- As explained in previous sections, you can retrieve the port number from the
  `GlueServiceEndpoint` URL information.
- If your SE provides `GlueSAPath` information, use that. To retrieve it:

```shell
$ ldapsearch -x -LLL -H <ldap://sbdii01.ncg.ingrid.pt:2170> \
  -b "mds-vo-name=NCG-INGRID-PT,o=grid" \
  '(&(objectClass=GlueSA)(GlueSAAccessControlBaseRule=VO:ops))' \
  GlueSAPath GlueChunkKey

dn: GlueSALocalID=opsdisk:replica:online,GlueSEUniqueID=srm01.ncg.ingrid.pt,Mds-Vo-name=NCG-INGRID-PT,o=grid
GlueChunkKey: GlueSEUniqueID=srm01.ncg.ingrid.pt
GlueSAPath: /gstore/t2others/ops
```

- if your SE doesn't provide `GlueSAPath` information, use instead the
  `GlueVOInfoPath` one:

```shell
$ ldapsearch -x -LLL -H <ldap://ntugrid5.phys.ntu.edu.tw:2170> \
  -b "Mds-Vo-name=TW-NTU-HEP,o=grid" \
  (&(objectClass=GlueVOInfo)(GlueVOInfoAccessControlBaseRule=VO:ops)) \
  GlueVOInfoLocalID GlueChunkKey

dn: GlueVOInfoLocalID=ops:SRR,GlueSALocalID=SRR:SR:replica:*****,GlueSEUniqueID=ntugrid6.phys.ntu.edu.tw,Mds-Vo-name=TW-NTU-HEP,o=grid
GlueVOInfoPath: /dpm/phys.ntu.edu.tw/home/ops
GlueChunkKey: GlueSALocalID=SRR:SR:replica:*****
GlueChunkKey: GlueSEUniqueID=ntugrid6.phys.ntu.edu.tw
GlueVOInfoLocalID: ops:SRR

dn: GlueVOInfoLocalID=ops:data01,GlueSALocalID=data01:replica:online,GlueSEUniqueID=ntugrid6.phys.ntu.edu.tw,Mds-Vo-name=TW-NTU-HEP,o=grid
GlueVOInfoPath: /dpm/phys.ntu.edu.tw/home/ops
GlueChunkKey: GlueSALocalID=data01:replica:online
GlueChunkKey: GlueSEUniqueID=ntugrid6.phys.ntu.edu.tw
GlueVOInfoLocalID: ops:data01
```

- Pay attention to use the storage path for the ops VO
- On GOCDB, in the “[Extension Properties](../extension-properties)” section of
  the SRM service endpoint page, fill in the following fields:
  - Name: SURL
  - Value: the actual SURL value, for example:
    `srm://srm01.ncg.ingrid.pt:8444/srm/managerv2?SFN=/gstore/t2others/ops`
