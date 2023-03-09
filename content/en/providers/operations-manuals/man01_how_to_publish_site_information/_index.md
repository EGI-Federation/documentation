---
title: "MAN01 How to publish site information"
weight: 10
type: "docs"
description: "How to publish site information"
---

## Document control

| Property            | Value                                                           |
| ------------------- | --------------------------------------------------------------- |
| Title               | How to publish Site Information                                 |
| Policy Group        | Operations Management Board (OMB)                               |
| Document status     | Approved                                                        |
| Procedure Statement | Publishing site information in the Information Discovery System |
| Owner               | SDIS team                                                       |

[EGI profile for the use of the GLUE 2.0 Information Schema](https://documents.egi.eu/public/ShowDocument?docid=1324)
specifies how the GLUE 2.0 information schema should be used in EGI. It gives
detailed guidance on what should be published, how the information should be
interpreted, what kinds of uses are likely, and how the information may be
validated to ensure accuracy.

## Configuring a site BDII

The site BDII needs to be configured to read from every node in the site which
publishes information (meaning that it runs a so-called resource BDII). In YAIM
this is defined with the `BDII_REGIONS` variable, which contains a list of node
names which in turn refer to variables called `BDII_<NODE>_URL` which specify
the LDAP URL of each resource BDII.

Some services may have DNS aliases for multiple hosts, but the `BDII_REGIONS`
must contain the real hostnames for each underlying node - the information in
the resource BDII is different for each node, so reading it via an alias would
produce inconsistent results. However, it will usually be desirable for the
published endpoint URLs to contain the alias rather than the real hostname; that
can often be defined with a YAIM variable for the service. For the site BDII
itself this variable is `SITE_BDII_HOST`. (If multiple site or top BDIIs are
configured identically their content will also be identical, so reading via an
alias does not produce any inconsistencies.)

Most services now publish themselves, so sites should check that all relevant
services are included. In particular, VOMS servers have only published
themselves comparatively recently so may be missing from the configuration. If
the glite-CLUSTER node type is used this must also be included. Publication has
been enabled for Argus in EMI 2, so this may also need to be added. Common
services which do not currently publish are APEL and Squid. See the table below
for more detailed information.

It is important to realise that the site BDII itself has a resource BDII, and
this must be explicitly included in the configuration, e.g. with something like

```shell
BDII_REGIONS="CE SE BDII"
(...)
BDII_BDII_URL="ldap://$SITE_BDII_HOST:2170/mds-vo-name=resource,o=grid"
```

In the past it was common for the site BDII to be colocated with the CE so it
did not need to be listed explicitly, but if installed on a dedicated node
(which is now the recommended deployment) it must be included.

To check that all expected services are published the following command can be
used:

```shell
$ ldapsearch -x -h $SITE_BDII_HOST -p 2170 -b mds-vo-name=$SITE_NAME,o=grid \
  objectclass=GlueService \
  | perl -p00e 's/\r?\n //g' | grep Endpoint:
```

(replacing `SITE_BDII_HOST`; and `SITE_NAME` with the values for your site),
which should list all the service URLs.

In addition, most services should now be published in GLUE 2 format. There is no
explicit configuration needed for GLUE 2, but one thing to be aware of is that
the site name (and the other parts like o=grid) in the GIIS URL field in the
GOCDB must have the correct case as GLUE 2 is case-sensitive.

To verify the GLUE 2 publication use the command:

```shell
$ ldapsearch -x -h $SITE_BDII_HOST -p 2170 -b GLUE2DomainID=$SITE_NAME,o=glue \
  objectclass=GLUE2Endpoint \
  | perl -p00e 's/\r?\n //g' | grep URL:
```

Some services, notably storage elements, may be missing or incomplete in GLUE 2
if they are older than the EMI 2 release. The following table shows the
publishing status for gLite and WLCG node types (ARC and Unicore have a
different structure).

| Node type | GLUE 1 | GLUE 2 | Notes                                                   |
| --------- | ------ | ------ | ------------------------------------------------------- |
| LCG-CE    | Yes    | No     | Obsolete                                                |
| CREAM     | Yes    | Yes    | Full publication only in EMI 2                          |
| CLUSTER   | Yes    | Yes    | Full publication only in EMI 2                          |
| WMS       | Yes    | Yes    |                                                         |
| LB        | Yes    | Yes    |                                                         |
| DPM       | Yes    | EMI 2  |                                                         |
| dCache    | Yes    | EMI 2  |                                                         |
| StoRM     | Yes    | EMI 2  |                                                         |
| LFC       | Yes    | EMI 2  |                                                         |
| FTS       | Yes    | EMI 2  | Channels not yet published in GLUE 2                    |
| Hydra     | EMI 2  | EMI 2  | Not yet released in EMI 2                               |
| AMGA      | Yes    | EMI 2  |                                                         |
| VOMS      | Yes    | Yes    |                                                         |
| MyProxy   | Yes    | Yes    |                                                         |
| Argus     | No     | EMI 2  | Internal service, publication for deployment monitoring |
| Site BDII | Yes    | Yes    |                                                         |
| Top BDII  | Yes    | Yes    |                                                         |
| R-GMA     | Yes    | No     | Obsolete                                                |
| VOBOX     | Yes    | Yes    |                                                         |
| Apel      | No     | No     | Internal service, publishing not yet requested          |
| Squid     | No     | No     | Configuration exists but not enabled                    |
| Nagios    | Yes    | Yes    |                                                         |

### Service-related documentation

#### Federated Cloud BDII configuration

For information about configuration of a Federated Cloud BDII, please look at
the [EGI Information System](../../cloud-compute/openstack/#egi-information-system).

## GlueSite Object

These are the existing well established attributes in the `GlueSite` object. All
of these MUST remain.

<!-- markdownlint-disable no-bare-urls -->

| Attribute                   | Example                       | Schema                          | Notes                                                                                                                                                                         |
| --------------------------- | ----------------------------- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GlueSiteName                | RAL-LCG2                      | Free text, no whitespace       | Same as GOCDB name if in GOCDB, your choice.                                                                                                                                  |
| GlueSiteUniqueID            | RAL-LCG2                      | Identical to your !GlueSiteName | Same as GlueSiteName                                                                                                                                                          |
| GlueSiteWeb                 | `https://cern.ch/it`          | Free Text                       | Valid URL about the site.                                                                                                                                                     |
| GlueSiteLatitude            | 52.42                         | NN.NN                           | Site Latitude.                                                                                                                                                                |
| GlueSiteLongitude           | 16.91                         | NN.NN                           | Longitude of Site.                                                                                                                                                            |
| GlueSiteDescription         | Rutherford Lab                | Free Text                       | A long name for the site.                                                                                                                                                     |
| GlueSiteLocation            | Dublin, Ireland               | Town, City, Country             | An decreasing resolution ending with Country, agree a country name within a country. i.e UK&nbsp;!= United Kingdom. Scotland and the Balkans should write a dynamic provider. |
| !GlueSiteUserSupportContact | `mailto:helpdesk@example.com` | Valid URL                       | URL for getting support. A ticket                                                                                                                                             |
| system if available.        |
| !GlueSiteSysAdminContact    | `xmpp://admins@jabber.org`    | Valid URL                       | How to contact the admins.                                                                                                                                                    |
| !GlueSiteSecurityContact    | `mailto:security@example.com` | Valid URL                       | How to contact for security related matters.                                                                                                                                  |

<!-- markdownlint-enable no-bare-urls -->

The `GlueSite` object in the 1.3 Glue Schema contains an attribute
`GlueSiteOtherInfo`. To quote.

> The attribute is to be used to publish data that does not fit any other
> attribute of the site entity. A `name=value` pair or an XML structure are
> example[s] of usage.

All this extra configuration will be with in the static information for the glue
site within the Grid Information Provider system.

### Guidelines for GlueSite Object

A format for publishing useful information about sites within the
`!GlueSiteOtherInfo` is needed, as shown in the following table.

<!-- markdownlint-disable no-bare-urls -->

| Key           | Example                                             | Type                                                  | Notes                                                                                                                                                                                                                                                                                          |
| ------------- | --------------------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GRID          | EGI                                                 | [#validgrid List of valid grid names]                 | Multiple ones can be defined.                                                                                                                                                                                                                                                                  |
| WLCG_TIER     | 1                                                   | Tier level of site in WLCG context.                   | Either 0, 1 , 2 , 3 , 4                                                                                                                                                                                                                                                                        |
| WLCG_PARENT   | UK-T1-RAL                                           | Name of the higher (administrative) tier site in WLCG | The WLCG_NAME of the site at a higher tier with WLCG                                                                                                                                                                                                                                           |
| WLCG_NAME     | IT-ATLAS-federation                                 | [#lcgnames Valid WLCG Names]                          | An official WLCG name.                                                                                                                                                                                                                                                                         |
| WLCG_NAMEICON | `https://example.com/tier2.png`                     | Valid URL                                             | URL to WLCGNAME icon, ideally 80x80 pixels.                                                                                                                                                                                                                                                    |
| EGEE_ROC      | Russia                                              | Valid federated Operations Centre name                | Only applicable if your site is still part of a federated Operations Centre ("ROC" according to the old EGEE terminology). Name MUST match the Operations Centre name declared in [GOCDB](https://goc.egi.eu/). Note. If the site is now part of a NGI, then EGI_NGI MUST be used (see below). |
| EGI_NGI       | NGI_CZ                                              | Valid NGI                                             | Must agree with the GOC DB                                                                                                                                                                                                                                                                     |
| EGEE_SERVICE  | prod                                                | prod, pps or cert                                     | Which EGEE grid your site is part of, multiple attributes is okay. Obsolete in EGI.                                                                                                                                                                                                            |
| OLDNAME       | Bristol                                             | text                                                  | If your !GlueSiteName changes at some point please record your old name here.                                                                                                                                                                                                                  |
| ICON          | `https://example.com/icon.png`                      | Valid URL                                             | Icon Image for your site, ideally 80x80 pixels                                                                                                                                                                                                                                                 |
| BLOG          | `https://scotgrid.blogspot.com/feeds/posts/default` | Valid RSS or Atom Feed                                | Your site blog if you have one                                                                                                                                                                                                                                                                 |
| CONFIG        | yaim                                                | yaim, puppet, quattor, ...                            | The configuration tool(s) used at the site                                                                                                                                                                                                                                                     |

<!-- markdownlint-enable no-bare-urls -->

Note. Keywords starting with one of the grid names are to some extent reserved
for that grid.

### Example

```shell
GlueSiteName: RAL-LCG2
GlueSiteOtherInfo: BLOG=https://example.com/blog/feed
GlueSiteOtherInfo: EGI_NGI=NGI_UK
GlueSiteOtherInfo: GRID=EGI
GlueSiteOtherInfo: GRID=GRIDPP
GlueSiteOtherInfo: GRID=WLCG
GlueSiteOtherInfo: ICON=https://example.com/images/tierOneSmall.png
GlueSiteOtherInfo: WLCG_PARENT=CERN-PROD
GlueSiteOtherInfo: WLCG_TIER=1
```

### Distributed Tier1s and Tier2s

Within an WLCG context for instance there are instances of distributed Tier2s
and Tier1s. If separate component sites want to exist as a single WLCG tier then
they might contain common values for their WLCGNAME.

```shell
GlueSiteName: CSCS-LCG2
GlueSiteOtherInfo: CONFIG=yaim
GlueSiteOtherInfo: EGI_NGI=NGI_CH
GlueSiteOtherInfo: GRID=EGI
GlueSiteOtherInfo: GRID=WLCG
GlueSiteOtherInfo: WLCG_NAME=CH-CHIPP-CSCS
GlueSiteOtherInfo: WLCG_PARENT=FZK-LCG2
GlueSiteOtherInfo: WLCG_TIER=2
```

Note that `WLCG_PARENT` is an accounting unit defined in the MOU document, as
shown in [WLCG CRIC](https://wlcg-cric-2.cern.ch).

### Established Grid Name

<!-- markdownlint-disable no-bare-urls -->
<!-- markdown-link-check-disable -->

| Short Name             | Long Name                                                                                     | URL                                               |
| ---------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| EGI                    | European Grid Initiative                                                                      | https://www.egi.eu                                |
| EELA                   | Europe and Latin America                                                                      | https://www.eu-eela.eu/                           |
| WLCG                   | World LHC Computing Grid                                                                      | https://cern.ch/lcg                               |
| GRIDPP                 | UK Particle Physics Grid                                                                      | https://www.gridpp.ac.uk                          |
| UKNGS                  | National UK Grid Service                                                                      | https://www.ngs.ac.uk                             |
| OSG                    | Open Science Grid (US)                                                                        | https://www.opensciencegrid.org/                  |
| NDGF                   | Nordic DataGrid Facility                                                                      | https://www.ndgf.org/                             |
| LondonGrid             | London Grid                                                                                   | https://www.gridpp.ac.uk/tier2/london/            |
| NORTHGRID              | Northern (UK) Grid                                                                            | https://www.gridpp.ac.uk/northgrid/               |
| SCOTGRID               | Scottish Grid                                                                                 | https://www.scotgrid.ac.uk/                       |
| SOUTHGRID              | Southern (UK) Grid                                                                            | https://www.gridpp.ac.uk/southgrid/               |
| Academic Grid Malaysia | Malaysian Grid                                                                                |
| UPM Campus Grid        | Universiti Putra Malaysia                                                                     | https://www.upm.edu.my/                           |
| AEGIS                  | Academic and Educational Grid Initiative of Serbia                                            | https://www.aegis.rs/                             |
| BIGGRID                | Dutch e-science Grid                                                                          | https://www.biggrid.nl/                           |
| Consorzio Cometa       | Consorzio Multi-Ente per la promozione e l'adozione di Tecnologie di calcolo Avanzato (Italy) | https://www.consorzio-cometa.it/en                |
| D-Grid                 | German Grid                                                                                   | https://www.d-grid-gmbh.de/index.php?id=1&amp;L=1 |
| EUMED                  | EU/Mediterranean Grid                                                                         | https://www.eumedgrid.eu/                         |
| GILDA                  | Grid INFN Laboratory for Dissemination Activities (Italy)                                     | https://gilda.ct.infn.it/                         |
| GISELA                 | Grid Initiative for e-Science virtual communities in Europe and Latin America                 | https://www.gisela-grid.eu/                       |
| GRISU                  | Griglia del Sud (Southern Italy Grid)                                                         | https://www.grisu-org.it/                         |
| NEUGRID                | Neuroscience Grid                                                                             | https://neugrid4you.eu/background                 |
| RDIG                   | Russian Data Intensive Grid                                                                   | https://grid-eng.jinr.ru/?page_id=43              |
| SEE-GRID               | South Eastern European GRid-enabled eInfrastructure Development                               | https://www.see-grid.org/                         |

<!-- markdown-link-check-enable -->
<!-- markdownlint-enable no-bare-urls -->

> Important: The EGEE Grid name was decommissioned on
> [[Agenda-14-02-2011|14-02-2011]]. All sites need to replace this grid name
> with EGI.

Being part of a grid is just a reference that your site is in some way
associated with a particular Resource Infrastructure Provider either technically
or as part of a collaboration. The list of Grids can be extended. Please contact
operations@egi.eu to request changes.

### Valid WLCG Names

The WLCG names are the site names that appear within the LCG MOU concerning
commitments to LHC computing.

| WLCG Name    | Current GlueSiteName |
| ------------ | -------------------- |
| CA-TRIUMF    | TRIUMF-LCG2          |
| CERN         | CERN-PROD            |
| DE-KIT       | FZK-LCG2             |
| ES-PIC       | pic                  |
| FR-CCIN2P3   | IN2P3-CC             |
| IT-INFN-CNAF | INFN-T1              |
| NDGF         | NDGF-T1              |
| NL-T1        | SARA-MATRIX          |
| TW-ASGC      | Taiwan-LCG2          |
| UK-T1-RAL    | RAL-LCG2             |
| US-FNAL-CMS  | USCMS-FNAL-W1        |
| US-T1-BNL    | BNL-LCG2             |

For the tier two names please consult [WLCG CRIC](https://wlcg-cric-2.cern.ch/).
The column marked `Accounting Name` are the WLCG Names which in the case of
Tier2s are the GOCDB names. Use your site GOCDB name as your WLCG_NAME.

Also some tier2s live under more than 1 tier1 perhaps for different for
different VOs. If your tier2 has more that one WLCG_PARENT then just add two
distinct records to show this. Also some tier2s do not have a WLCGNAME at all.

```shell
GlueSiteUniqueId: EENet
GlueSiteName: EENet
GlueSiteOtherInfo: GRID=WLCG
GlueSiteOtherInfo: GRID=EGI
GlueSiteOtherInfo: EGI_NGI=NGI_NL
GlueSiteOtherInfo: WLCG_TIER=2
GlueSiteOtherInfo: WLCG_PARENT=UK-T1-RAL
GlueSiteOtherInfo: WLCG_PARENT=NL-T1
```

### Valid EGI NGI Names

The valid names are those published on
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=NGIs).

## YAIM Instructions

YAIM will have to be updated for those sites using yaim. This will be done and
submitted to sites in the normal way.

<!-- markdownlint-disable no-bare-urls no-inline-html -->

| YAIM Variable and Value                 | Resulting Glue Attribute and Value                             |
| --------------------------------------- | -------------------------------------------------------------- |
| SITE_NAME=RAL_LCG2                      | GlueSiteName: RAL-LCG2                                         |
| SITE_DESC="Rutherford Lab"              | GlueSiteDescription: Rutherford Lab                            |
| SITE_EMAIL= steve@example.com           | GlueSiteSysAdminContact: mailto:steve@example.com              |
| SITE_SUPPORT_EMAIL= steve@example.com   | GlueSiteUserSupportContact: mailto:steve@example.com           |
| SITE_SECURITY_EMAIL= steve@example.com  | GlueSiteSecurityContact: mailto:steve@example.com              |
| SITE_LOC="Soho, London, United Kingdom" | GlueSiteLocation: Soho, London, United Kingdom                 |
| SITE_LONG=52.45                         | GlueSiteLongitude: 52.45                                       |
| SITE_LAT=-12.34                         | GlueSiteLatitude: -12.34                                       |
| SITE_WEB="https://example.com/"         | GlueSiteWeb: https://example.com/                              |
| SITE_OTHER_GRID="EGI\|WLCG"             | GlueSiteOtherInfo: GRID=EGI<br />GlueSiteOtherInfo: GRID=WLCG  |
| SITE_OTHER_EGEE_ROC="UK/I"              | GlueSiteOtherInfo: EGEE_ROC=UK/I                               |
| SITE_OTHER_EGI_NGI="NGI_CZ"             | GlueSiteOtherInfo: EGI_NGI=NGI_CZ                              |
| SITE_OTHER_EGEE_SERVICE="prod"          | GlueSiteOtherInfo: EGEE_SERVICE=prod                           |
| SITE_OTHER_WLCG_TIER=2                  | GlueSiteOtherInfo: WLCG_TIER=2                                 |
| SITE_OTHER\*<KEY>="<VALUE1>\|<VALUE2>"  | GlueSiteOtherInfo: KEY=<VALUE1>GlueSiteOtherInfo: KEY=<VALUE2> |

<!-- markdownlint-enable no-bare-urls no-inline-html -->

If multiple values for `GlueSiteOtherInfo` are needed, then just delimit your
values with a `|`. The character `|` must be avoided in values.

## Check your own GlueSite Object

The information published can be checked through an ldap search:

```shell
$ ldapsearch -x -H ldap://$SITE_BDII_HOST:2170 \
  -b 'Mds-Vo-Name=$SITE_NAME,o=Grid' \
  '(ObjectClass=GlueSite)'
```

In addition, [VAPOR](https://operations-portal.egi.eu/vapor/) is a tool which
provides a GUI for different views of published information, including a LDAP
view.

## Site information in GLUE 2

The GLUE 2 equivalent of the GlueSite object is the `GLUE2AdminDomain`. The same
information should be present although in a slightly different format, and there
are separate `GLUE2Contact` and `GLUE2Location` objects.
