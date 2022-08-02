---
title: Understanding and manipulating roles
description: "Understanding and manipulating roles"
weight: 30
type: "docs"
---
The GOCDB UI attempts to authenticate you in one of two ways (the REST style API
## Roles definition
Registered users with a user account will need at least one role in order to
perform any useful tasks.

### Role Types
- A role: Unregistered users
- B role: Registered users with no role
- C role: Users with a role at site level (site admin)
- C' role: Users with a management role at site level (site operations manager,
site security officer...)
- D role: Users with a role at regional level (regional staff support staff, ROD,
1st Line Support)
- D' role: Users with a management role at regional level (NGI manager or deputy,
security officer)
- E role: Users with a role at project level

The only difference between C and C' users is that:
- C can NOT approve/reject role requests.
- C' can only approve/reject role requests for their SITE.

The difference between D and D' users is that:
- D can NOT add/delete sites to/from their NGI.
- D can NOT update the certification status of member sites.
- D can NOT approve or reject role requests.

### Roles

**At Site level**
- Site Administrator - person responsible of maintaining a grid site and
associated information in GOCDB (C Level)
- Site Security officer - official security contact point at site level (C'
Level)
- Site Operations Deputy Manager - The deputy manager of operations at a site (C'
Level)
- Site Operations Manager - The manager of site operations (C' Level)

**At NGI/Regional level**
- Regional First Line Support - Staff providing first line support for an NGI (D
Level)
- Regional Staff (ROD) - staff involved in
[Operations Centre](https://confluence.egi.eu/display/EGIG/Operations+Centre)
activities such as user/operations support (D Level)
- NGI Security officer - official security contact point at regional level (D'
Level)
- NGI Operations Deputy Manager - Deputy manager of NGI operations (D' Level)
- NGI Operations Manager - Manager of NGI operations (D' Level)

**At Project level**
- COD staff - COD staff (E Level)
- COD administrator - People administrating Central COD roles (E Level)
- EGI CSIRT Officer - official security contact point at project level (E Level)
- Chief Operations Officer (COO) - The EGI Chief Operations Officer (E Level)

## Permissions associated to roles
GOCDB roles and permissions are based on whether the considered object is owned or
not. In the table below the following definitions apply:

- **Owned group**: a group on which the role applies (ROC, NGI, project)
- **Owned site**: a site on which the role applies, or belonging to an owned group
- **Owned service endpoint**: a service endpoint belonging to an owned site

Each role has a set of associated permissions which apply on the role's scope (site, region or project). Main permissions are summarised in the table below

(add the table...)

## Requesting roles for your account
There are 2 ways to request new roles.

- By clicking on the **manage role** link (sidebar, user status panel)
 - the first form allows you to choose the entity (site or group) on which you want
to request a role
 - the second form lets you choose the role you want to apply for
- By clicking on the **request role** link from site detail pages or group detail
pages.
 - displayed form lets you choose the role you want to apply for

Once made, role requests have to be validated before the role is granted to you.
This part of the process is described in the next section.
