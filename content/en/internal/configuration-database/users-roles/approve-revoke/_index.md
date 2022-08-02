---
title: Approving/revoking accounts, roles and other actions
description: "Approving/revoking accounts, roles and other actions"
weight: 30
type: "docs"
---

## Changing your certificate DN
Moved to Changing_your_accountID

## Approving role and change requests
When a registered user applies for a role, the request has to be validated by
someone who has the proper permissions to grant such a role. If you request a
role on a given entity, any user with a valid role on that entity or above will
be able to approve your request.

*Example* - If you request a "site administrator" role on site X, then the
following users can approve your request:
- site administrators and security officers of site X
- regional operations staff, managers and deputies of the
[Operations Centre](https://confluence.egi.eu/display/EGIG/Operations+Centre)
to which site X belongs
- GOCDB admins

Role requests you can approve are listed on the **Manage roles** page (accessible
by clicking the **Manage roles** link in the user status panel in the sidebar).

In order to approve or decline role requests, simply click on the **accept** or
**deny** links in front of each role request.

## Revoking roles
If a user within your scope has a role that needs to be revoked, you can do this
from the user's page, where user's details are listed along with his/her current
roles. To revoke a role, simply click on the role name then on the **revoke**
link at the top right of the role's details page.

**Note**: This works for other users within your scope but also for yourself.
However just note that if you revoke your own roles you may not have proper
permissions to recover them afterwards.
