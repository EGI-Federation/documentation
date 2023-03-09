---
title: Service Entities
description: "Managing Service entities"
weight: 30
type: "docs"
---

## Definition

A Service entity is formed by a hostname, a hosted service and a URL.

The EGI Configuration Database stores the following information about Service
entities (non exhaustive list):

- The fully qualified hostname of the machine
- The hosted service (see `ServiceTypes` below)
- The URL to reach the entities
- The IP address of the machine
- The machine's host certificate DN
- A description of the node

As a machine can host many services, there can be many Service entities per
machine.

### Example

The machine `myhost.domain.org` runs a CE, an UI and a UnicoreX service. This
will show up in the EGI Configuration Database as 3 Service entities:

| fully qualified hostname | ServiceType      |
| ------------------------ | ---------------- |
| myhost.domain.org        | CE               |
| myhost.domain.org        | UI               |
| myhost.domain.org        | unicore6.Gateway |

Note that a single host can also specify multiple services of the same
`ServiceType`.

## Manipulating Service entities

### Viewing Service entities

There are different pages in GOCDB where Service entities are listed:

- A full Service entities
  [listing page](https://goc.egi.eu/portal/index.php?Page_Type=Services), that
  shows a listing of all the entities in the database, with controls to page
  through the listing. The table headers can be clicked to set the ordering.
- Site details page, see
  [GRIDOPS-GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=335) for
  an example, where all the Service entities belonging to this site are listed

Each Service entity also has its own listing page. By clicking the link to view
it, you can see all associated information.

### Adding Service entities

Provided you have proper permissions (check the permissions matrix in the
Permissions_associated_to_roles section), you can add a Service entity by:

- clicking on the **Add a New Service** link in the sidebar. Simply select
  parent site, fill the form and validate.
- By clicking on the **Add Service** link from a given site's details page (the
  link will only appear if you have proper permissions). This will lead you to
  the same form as above.

### Editing Service entities information

The editing process will show you the same form as the adding process. To edit
Service entities, simply click the "**edit**" link on top of the entities'
details page.

### Removing a Service entity from a site

To delete a Service entity you have permissions on, simply click on the
"**delete**" link on top of the entities' details page. The interface asks for
confirmation before proceeding.

## Service Endpoint entities

A Service entity may optionally define Service Endpoint entities which model
network locations for different service functionalities that can't be described
by the main `ServiceType` and `URL` alone.

For example: The Service entity
[goc.egi.eu](https://goc.egi.eu/portal/index.php?Page_Type=Service&id=4180) (of
ServiceType egi.GOCDB) defines the following Service Endpoint entities:

<!-- markdownlint-disable no-bare-urls -->

| Name                                                                                                    | URL                        | Interface Name   |
| ------------------------------------------------------------------------------------------------------- | -------------------------- | ---------------- |
| [ProductionPortalInstance](https://goc.egi.eu/portal/index.php?Page_Type=View_Service_Endpoint&id=6313) | https://goc.egi.eu/portal  | egi.GOCDB.Portal |
| [Production PI base URL](https://goc.egi.eu/portal/index.php?Page_Type=View_Service_Endpoint&id=6314)   | https://goc.egi.eu/gocdbpi | egi.GOCDB.PI     |

<!-- markdownlint-enable no-bare-urls -->

## Specific Service entities fields and their impact

### "beta" flag (t/f)

This indicates whether the Service entity is a beta service or not (part of the
staged rollout process).

### Host DN

This is the DN of the host certificate for the service. The format of the DN
follows that defined by the
[OGF Interoperable Certificate Profile](https://www.ogf.org/documents/GFD.225.pdf)
which restricts allowed chars to a `PrintableString` that does NOT contain
characters that cannot be expressed in printable 7-bit ASCII. For a list of
allowed chars.

To supply multiple or alternate DN(s) for a service, for example of the multiple
hosts supporting a single Service entity, see
[standard extension properties](../extension-properties/#standard-extension-properties).

### "production" flag (t/f)

The Service entities' Production flag indicates if this service delivers a
production quality service to the infrastructure it belongs to (EGI).

- Non-production Service entities can be either Monitored or Not Monitored,
  depending on the Administrator's choice.
- Even if this flag is false, the service is still considered part of the EGI
  and so shows up in the ROD dashboard.
- If true, then the Monitored flag must also be true: **All production resources
  MUST be monitored** (except if the `ServiceType` is a `VOMS` or `emi.ARGUS`)
- This flag is not to be confused with **PRODUCTION_STATUS**, which is a Site
  level flag that shows if the site delivers to the production or Test
  infrastructure.

### "monitoring" flag (t/f)

This flag is taken into account by monitoring tools.

- Can only be set to "N" (false) if Production flag is also false.
- If set to "N" the entities won't be tested.

### Usage of PRODUCTION and MONITORED flags for EGI Service entities

All production Service entities MUST be monitored (except for `emi.ARGUS` and
`VOMS` ServiceTypes).

#### Production and Monitored

- Operations Dashboard: A failing test of production Service entities generates
  an alarm in the ROD Operations Dashboard.
- Availability calculation: The Service entities test results are considered for
  Availability computation (if and only if the `ServiceType` associated to the
  entities is one of those included in Availability computation)

#### Non-Production and Monitored: YES/NO

- Availability calculation: If Monitored is set to `YES`, the
  [Monitoring Service](../../monitoring) will test the Service entity, but the
  test results are ignored by the Availability Computation Engine (ACE).
- Availability calculation: Non-production Service entities are not considered
  for site availability calculations.
- Operations Dashboard: If Monitored is set `NO`, the Service entities is
  ignored by the [Monitoring Service](../../monitoring), and no alarms are
  raised in the Operations Dashboard in case of `CRITICAL` failure.
- Monitoring tests for non-production Service entities generate alarms into the
  ROD Operations Dashboard in case of `CRITICAL` failure of the test. These
  alarms are visible in the Operations Dashboard and are tagged as "non
  production".
