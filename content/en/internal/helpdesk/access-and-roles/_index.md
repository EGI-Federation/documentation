---
title: "Access and roles"
type: docs
weight: 20
description: "Registration and roles management"
---

## Access the EGI Helpdesk service

Users can access the [EGI Helpdesk service GGUS](https://helpdesk.egi.eu/) 
with an existing institutional/social account through EGI Check-in.

When you access the service for the first time, you are automatically assigned
a role with minimal privileges by default: in such a situation you can only
create user tickets and can't access tickets created by other users.

In order to create your first ticket, please use the green "+" button in the
lower left part of your screen.

![Create ticket button](create-ticket.png)

### Access to the previous EGI Helpdesk

The [previous EGI Helpdesk](https://ggus.eu/) is still available in read-only
mode for historical reasons: users can access to the tickets that were closed
before the migration to the new helpdesk.
Either an X509 personal certificate or a federated identity are required for
the access.

## Roles management

Roles in GGUS define the permissions and capabilities each user has when
interacting with tickets. Proper role assignment ensures that users have
access to the appropriate tools and information they need for their specific
tasks.

**Note: Currently the roles are managed within GGUS; we are planning to move
the roles management to EGI Check-in.**

### How to check your roles

You can check your assigned role by following these steps (not available for
users with the default role):

1. Click on your User Logo in the lower left corner of the screen.
2. Navigate to Profile and select Roles.

![Check your roles](owned-roles.png)

## Role Hierarchy and Capabilities

### Standard Roles

- User
  - Default role assigned upon registration. 
  - Permissions:
    - Basic ticket submission interface (only group and site fields are
	available).
    - Ticket submission only to TPM and NGIs. 
    - Visibility of only your own tickets.
- GGUS User
  - Users who need read-only access to others' tickets, but with limited editing
  rights.
  - Permissions:
    - Enhanced ticket submission interface (category, ticket area, priority,
	affected vo, notified groups).
    - Ticket submission to TPM, NGIs, Second Level and Other Infrastructures. 
    - Read-only access to all tickets.
    - (in development) Limited access to personal information such as names and
	email addresses. 
- Common
  - Supporters who manage and update tickets throughout the system.
  - Permissions:
    - Full read and write access to all tickets.

### Roles with Specific Capabilities

These roles provide additional capabilities beyond the standard roles and are
assigned based on specific needs. The prerequisite for obtaining any of these
roles is having at least the Common role, which is usually sufficient for most
users. 

- GGUS Expert
  - Advanced supporters who can submit tickets to the Third Level and Product
  Teams.
- VO
  - Indicator of Membership in the Virtual Organization (VO).
  - Enables VO specific features such as overviews and ticket areas. 
- VO_team
  - Permissions:
    - Ability to submit **[Team tickets](../features/team-tickets/)**
    on behalf of a VO.
  - Use Case: Users representing teams and submitting team-related tickets.
- TPM ([Ticket Process Manager](https://confluence.egi.eu/x/F4a_Bw))
  - Permissions:
    - Additional section in the Overview showing tickets submitted to the TPM.
  - Use Case: Users who are involved in the First Level Support activity.
- Alarm
  - Permissions:
    - Ability to create **[Alarm tickets](../features/alarm-tickets/)**.
  - Use Case: Users who need to notify WLCG Tier-0 and Tier-1 administrators
  about serious problems of the site at any time, independent from usual office
  hours.
- Multisites
  - Permissions:
    - Ability to create tickets to many sites in one go.
  - Use Case: EGI and WLCG Operations to conduct middleware related campaigns.
- Mini-Admins
  - Permissions: 
    - Ability to grant particular roles .e.g VO role to other users 
  - Use Case: Management of VO users in the helpdesk

## Contact

If you have any issues with roles or general questions regarding the helpdesk,
please submit a ticket to the group "Second Level › Services › EGI Services and
Service Components › Helpdesk (GGUS)" (start typing "ggus" in the group field
for quick access).
