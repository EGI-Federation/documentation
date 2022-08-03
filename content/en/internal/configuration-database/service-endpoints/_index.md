---
title: Service Endpoints
description: "Managing Service Endpoints entities"
weight: 30
type: "docs"
---

## Definition
A service endpoint is a single entity formed by a hostname, a hosted service and
a URL.

GOCDB stores the following information about service endpoints (non exhaustive
list):
- The fully qualified hostname of the machine
- The hosted service (see service types below)
- The URL to reach the endpoint
- The IP address of the machine
- The machine's host certificate DN
- A description of the node

As a machine can host many services, there can be many service endpoints per
machine.

*Example: the machine myhost.domain.org runs a CE, an UI and a UnicoreX service.
This will show up in GOCDB as 3 Service Endpoints:
- *myhost.domain.orgCE URL: http://myhost.domain.org/CE
- *myhost.domain.orgUI URL: http://myhost.domain.org/UI
- *myhost.domain.orgunicore6.UNICOREX URL: http://myhost.domain.org/UnicoreX*

Note that a single host can also specify multiple services of the same service
type.

## Manipulating service endpoints

### Viewing service endpoints

There are different pages in GOCDB where service endpoints are listed:
- **A full service endpoints listing page**, that shows a listing of all the
endpoints in the database, with controls to page through the listing. The table
headers can be clicked to set the ordering.
- **Site details page**, where all the service endpoints belonging to this site
are listed

Each endpoint also has its own listing page. By clicking the link to view a
service endpoint, you can see all associated information.
- Service Endpoints listing page is available from the side menu in GOCDB4 by
clicking on the *Browse Service Endpoints* link.

### Adding Service Endpoints

There are 2 ways to add new service endpoints to GOCDB, provided you have proper
permissions (check the permissions matrix in the Permissions_associated_to_roles
section):
- By clicking on the **Add a New Service** link in the sidebar. Simply select
parent site, fill the form and validate.
- By clicking on the **Add a New Service Endpoint** link from a given site's
details page (the link will only appear if you have proper permissions). This
will lead you to the same form as above.

### Editing service endpoint information

The editing process will show you the same form as the adding process. To edit a
service endpoint, simply click the "**edit**" link on top of the endpoint's
details page.

### Removing a service endpoint from a site

To deactivate a service endpoint you have permissions on, simply clic on the
"**delete**" link on top of the endpoint's details page. The interface asks for
confirmation before proceeding.

## Specific Service Endpoint fields and their impact

### "beta" flag (t/f)

This indicates whether the service is a beta service or not (part of the staged
rollout process).

### Host DN

This is the DN of the host certificate for the service. The format of the DN
follows that defined by the
[OGF Interoperable Certificate Profile](https://www.ogf.org/documents/GFD.225.pdf)
which restricts allowed chars to a PrintableString that does NOT contain
characters that cannot be expressed in printable 7-bit ASCII. For a list of
allowed chars.

To supply multiple or alternate DN(s) for a service, for example of the multiple
hosts supporting a single service entry,
see https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#HostDN

### "production" flag (t/f)

The services Production flag indicates if this service delivers a production
quality service to the infrastructure it belongs to (EGI).
- Non-production services can be either Monitored or Not Monitored, depending on
the Administrator's choice.
- Even if this flag is false, the service is still considered part of the EGI and
so shows up in the ROD dashboard.
- If true, then the Monitored flag must also be true: **All production resources
MUST be monitored** (except if the service type is a VOMS or emi.ARGUS)
- This flag is not to be confused with **PRODUCTION_STATUS**, which is a Site
level flag that shows if the site delivers to the production or Test
infrastructure.

### "monitoring" flag (t/f)

This flag is taken into account by monitoring tools.
- Can only be set to "N" (false) if Production flag is also false.
- If set to "N" the endpoint won't be tested.

### Usage of PRODUCTION and MONITORED flags for EGI Service Endpoints

All production services MUST be monitored (except for emi.ARGUS and VOMS service
types).

#### Production and Monitored

- Operations Dashboard: A failing test of production service endpoints generates
an alarm in the ROD Operations Dashboard.
- Availability calculation: The service endpoint test results are considered for
Availability computation (if and only if the service type associated to the
endpoint is one of those included in Availability computation)

#### Non-Production and Monitored: YES/NO

- Availability calculation: If Monitored is set to YES, ARGO will test the
service, but the test results are ignored by the Availability Computation Engine
(ACE).
- Availability calculation: Non-production service endpoints are not considered
for site availability calculations.
- Operations Dashboard: If Monitored is set NO, the service endpoint is ignored
by ARGO and no alarms are raised in the Operations Dashboard in case of CRITICAL
failure.
- Monitoring tests for non-production services generate alarms into the ROD
Operations Dashboard in case of CRITICAL failure of the test. These alarms are
visible in the Operations Dashboard and are tagged as "non production".
