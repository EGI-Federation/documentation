---
title: Sites
description: "Managing Sites entities"
weight: 30
type: "docs"
---

## Definition

A site (also known as a [Resource Centre](https://confluence.egi.eu/x/Z4IkBQ))
is a grouping of grid resources collating multiple Service Endpoints (SEs).
Downtimes are recorded on selected SEs of a site. GOCDB stores the following
information about sites (non exhaustive list). Note, when editing values in the
portal, mandatory fields are marked with '*':

- A unique (short) name - case sensitive (GOCDB and GoCDB are considered
different)
- An official (long) name
- A domain name for the Site/Resource Centre
- The home web URL of the Site/Resource Centre
- A contact email address and telephone number
  - Emergency email for a fast response time in case of urgent problem
  - Alarm email is WLCG Tier1 site specific (used as part of a WLCG workflow for
    dealing with specific monitoring alarms)
- A security contact email address and telephone number
- The site timezone
- The site's GIIS URL (Case Sensitive - Please ensure you enter your Site name
which is usually encoded in the URL in the correct case!).
  - e.g. ldap://bdii-rc.some-site.uk:2170/mds-vo-name=SITE-NAME,o=grid (if your
    GOCDB site name site name is upper case)
- A mandatory human readable description of the site
- The site's latitude, longitude and location
- Production Infrastructure: The site's intended target infrastructure. This
specifies the infrastructure that the site's services deliver to. This has one
of the following values:
  - Production (with this target infrastructure, the EGI site certification
    transition rules apply)
  - Test (in future, if the site delivers to this infrastructure, then its
    Certification status will be fixed to 'Candidate').
- ROC [GROUP] - The NGI or Region of the site
- Country
- IP address range within which the Site/Resource Centre's services run
  - IP/netmask (x.x.x.x/x.x.x.x). To specify multiple IP/netmask values, use a
    comma or semi-colon separated list with no spaces, e.g.
    1.2.3.4/255.255.255.0, 1.2.3.5/255.255.255.0

## Manipulating sites

### Viewing sites

A site listing page shows a listing of all the sites in the database, with
controls to page through the listing. The table headers can be clicked to set
the ordering (ascending or descending).

Each site also has its own listing page. By clicking the link to view a site,
you can see all of the site's information

- Site listing page is available from the sidebar by clicking on the Browse
Sites link.
- sites belonging to a given Operations Centre are also listed from the group
details pages (see below)

### Adding a site

Provided you have proper permissions (check the permissions matrix in the
[related section](../users-roles/managing-roles/_index.md#permissions-associated-to-roles)
, you can add a site by clicking on the Add a New Site link in the sidebar.
Simply fill the form and validate.

**Note**: If you just registered as site admin and want your new site to be
registered in GOCDB, please contact your NGI representative.

### Editing site information

The editing process will show you the same form as the adding process. To edit a
site, simply click the "**edit**" link on top of the site's details page.

### Renaming a site

Provided you have permissions, you can change the Short Name, Official Name and
GIIS URL to the new Resource Center details. For more information regarding the
site renaming procedure please see [PROC15](https://confluence.egi.eu/x/3SAmBg)

### Removing a site

Site deletion is not allowed in GOCDB. If a site stops operation, its
certification status should be set to "closed" (see the next section for more
information).

### Changing Site Certification Status

For each site that delivers to the 'Production' Target Infrastructure, GOCDB
stores and shows information about its certification status. This reflects the
different steps of the official SA1 site certification procedure which typically
follows:

Candidate -> Uncertified -> Certified.

The different possible certification statuses are:

- **Candidate**: the Resource Centre is in under registration according to the
registration process described in the
[RC registration certification procedure](https://confluence.egi.eu/x/FSAmBg).
A site will have CANDIDATE status only during certification.
- **Uncertified**: site information has been validated by the Operations Centre
and is ready to be moved to certified status (again). The certification status of
a site can only be changed by a user with a higher level 'Regional' (or EGI
'Project') level role. This usually means that only regional managers/deputies/staff
can update the status of a site that belongs to that region, see the permissions
associated to the roles in the
[related section](../users-roles/managing-roles/_index.md#permissions-associated-to-roles).
- **Certified**: the Operations Centre has verified that the site has all middleware
installed, passes the tests and appears stable.
- **Suspended**: Site does temporarily not conform to production requirements (e.g.
minimum service targets - see the
[Resource Centre OLA](https://documents.egi.eu/document/31), security matters) and
requires Operations Centre attention. A site can be suspended for a maximum of 4
months after which it must be re-certified or closed.
- **Closed**: Site is definitely no longer operated by EGI and is only shown for
historic reasons.

**Clarifications**:

- The uncertified status would generally be an information that a site is ready to
start certification procedure (again). "uncertified" can also be used as a timewise
unlimited state for sites having to keep an old version of the middleware for the
absolute needs of an important international VO or to flag a site coping with
[Operations Centre](https://confluence.egi.eu/x/NoIkBQ) requirements but not with EGI
availability/reliability thresholds.
- Suspended is always having a temporary meaning. It is used to flag a site temporarily
not coping with EGI availability/reliability thresholds or security requirements,
and which should be closed or uncertified by its
[Operations Centre](https://confluence.egi.eu/x/NoIkBQ) within 4 months. When being
suspended, sites can express that they want to pass certification again. The suspended
status is useful to EGI and to the Operations Centre themselves to flag the sites that
require attention by the [Operations Centre](https://confluence.egi.eu/x/NoIkBQ).
- The closed status should be the terminal one. Suspended is not a terminal state.

**The following site state transitions are allowed**:

- candidate -> uncertified
- candidate -> closed
- uncertified -> certified
- certified -> suspended
- certified -> closed (on site request)
- suspended -> uncertified
- suspended -> closed

**The following transitions are explicitly forbidden**:

- suspended -> certified
- candidate -> something else but uncertified and closed
- closed -> anything else

Going with the definition of the suspended status,
[Operations Centre](https://confluence.egi.eu/x/NoIkBQ) managers have to regularly give
their attention to all their suspended sites, so that they are processed within the
given maximum time of four months. Sites being in suspended should either be set to
closed or brought back in production via the uncertified status.

More information about site certification statuses can be found in the
[EGI Federation Procedures](https://confluence.egi.eu/x/FwfSB):

- [PROC09 RC Registration and Certification Procedure](https://confluence.egi.eu/x/FSAmBg)
- [PROC11 Resource Centre Decommissioning Procedure](https://confluence.egi.eu/x/myAmBg)
- [PROC12 Production Service Decommissioning Procedure](https://confluence.egi.eu/x/jSAmBg)

**Note**: Site certification status cannot be changed by site administrators, and
requires intervention of Operations Centre staff.
