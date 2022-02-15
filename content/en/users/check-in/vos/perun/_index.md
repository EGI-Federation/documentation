---
title: "Perun"
linkTitle: "Perun"
type: docs
weight: 50
description: >
  VO management trough Identity and Access management system Perun
---

{{% alert title="How is this documentation organized" color="info" %}}
This documentation is specific for the EGI users and use-cases. Each section
briefly describe the concepts in Perun and available options. How-To guides
for related common actions are available at the end of each section.
{{% /alert %}}

## Overview

Perun is identity and access management system and within the EGI it
provides alternative solution for VO management. Perun provides more
advanced features and supports complex use-cases in comparison to COManage and
VOMS.

You should consider using Perun for VO management if you want or require
following features:

- Customizable registration forms, flows and notifications for both VOs and
  Groups
- Advanced group management with group hierarchies and relations
- VO/Group management roles delegation
- Membership expiration/renewals rules
- Membership sponsorships as exceptions to membership rules
- Service accounts which can be associated to owners and used for API usage
  or provisioned to the EGI services
- Push mechanism for services provisioning
- Fine-grained access management for service owners
- User/group synchronizations with external systems and services

## VO management

Administrative GUI for VO managers is available at [https://perun.egi.eu](https://perun.egi.eu)

It is assumed that VO managers and members have already registered their EGI
Check-in account (A step-by-step guide is provided in this [link](../../signup)
).

Due to historical reasons (wide adoption of VOMS) users might have their
user entry in Perun already directly associated with their personal
certificate. For such cases direct authentication using the certificates is
available. Please consult Perun support trough GGUS if you wish to merge
your accounts and start using EGI Check-In as identity linking needs to be
done on Perun side and not trough Check-In.

### Registering your VO

Standard EGI procedure for registering VO takes place. See related Check-In
documentation about [Registering your VO](../#registering-your-vo).

Steps which are specific to Perun basically are:

1. You will provide us with necessary information through GGUS ticket (as
   described in the procedure).
2. We will prepare empty VO for you using basic template or pre-configure it
   as mutually agreed in the GGUS.
3. You will register to your own VO using provided link and we will set you as
   the VO manager.

Any further VO management and configuration is responsibility of VO manager.

### Managing members

All basic features regarding members management are available in the
administrative GUI under the *VO manager* section. All features are
described in the following sections in more detail.

#### HOW-TO

- Add/Remove VO members
- Search and list VO members
- Member detail (status, groups, settings,...)

#### Accepting new members

Users can register in your VO using same registration link you were provided
during the VO registration. It has the following format:

`https://perun.egi.eu/egi/registrar/?vo=[voName]` where `[voName]` is to be
replaced with your actual VO name (as displayed on VO ID card in
OperationsPortal).

Alternatively you can configure invitation notification template and
send registration link to the users directly from Perun.

Once user submits the registration it is up to you to review and approve or
reject it. Perun can be configured to automatically approve
valid registrations or reject them in case of user inactivity (for example
when email is not verified by the user in timely manner).

There is a possibility to use custom registration modules which are
programmable and can perform any specific and complex actions with the
users and the VO. Please consult perun user support using GGUS in case you
need this feature.

##### HOW-TO

- Configure registration form and notifications
- Approve/reject submitted registration
- Configure and send invitation notification

#### Membership lifecycle, expiration rules and renewal

{{% alert color="info" %}}
Almost identical features are available for each Group within the VO. See
same section under the [Groups management](#group-membership-lifecycle-expiration-rules-and-renewal) for the differences.
{{% /alert %}}

By default, Perun expects that membership lifecycle is managed by the VO
manager directly - manually. This can be done by switching each members'
status between `VALID`, `EXPIRED` and `DISABLED` states or by removing the
member from VO.

Members' status affects which VO/group membership information is released to
the service, hence affects users ability to access the service or state of
users' account in the service.

| Member&nbsp;status | Meaning                                                                                                                                                                                                               |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `VALID`            | User is active member of VO. VO/group membership information is provisioned to services (e.g. through Check-In proxy).                                                                                                |
| `EXPIRED`          | User is inactive member of VO, but allowed to renew membership. VO/group membership information is not provisioned to services through Check-In proxy but can be provisioned to services directly connected to Perun. |
| `DISABLED`         | User is inactive member of VO and can't renew membership by himself. VO/group membership information is not provisioned outside of Perun.                                                                             |

Switching between the states can be automated based on membership expiration
rules of VO or simply by setting membership expiration date manually to the
member.

Notifications can be set to notify members about upcoming membership
expiration. They can then ask for membership renewal using the same
registration link. Modified version of the form is displayed to them in such
case.

Membership expiration rules can be set either to a fixed date within the
year (in such case member is expected to renew membership every year before
that date) or be dynamically calculated based on the date of registration. In
the second case renewal period can be shorter or longer than one year (e.
g. `+2y`, `+6m`, meaning 2 years or 6 months respectively).
In both cases you also need to define timespan, how long before the
membership expiration are members allowed to ask for the renewal (e.g. `1m`,
meaning one month).

##### HOW-TO

- Change VO member status and expiration
- Set VO membership expiration rules
- Configure registration form and notifications

### Managing groups

Groups are used to further categorize VO members within the VO and to assign
them roles or access rights for the services. They can be also used to
delegate members management to others as you can assign a group manager
which is then responsible for that particular group and its child groups.

All VOs have one system group named *members*, which automatically holds
all VO members and can be used in groups relations.

Groups can be organized in a *flat* or *hierarchical* structure, or you can
combine them as you need. Groups' names must be unique on each level of
hierarchy and group full name consist of all groups names on the path
from the root divided by colon `:`, e.g. `projectX:students`.

Top-level groups can be created only by the VO managers.

#### HOW-TO

- Search and display groups
- Create/delete groups and subgroups
- Create/remove relations between the groups
- Rename group

#### Group memberships

Perun recognize two kinds of group memberships, *direct* and *indirect*. If
you use only flat group structure, all users are direct members of the
groups. Once you start using hierarchical group structures or group
relations, you will get also indirect members in some groups.

Both types of memberships are equal regarding the VO/group membership
information released for the services (e.g. Check-In proxy).

Membership in the hierarchical group structures is inherited from the most
bottom groups to the root and user can be both direct and indirect member of
the group at the same time.

Indirect members can't be removed from the group and are displayed in the
GUI using italic font in the group members list. In order to remove them
from the group you have to remove them from the sourcing subgroup first or
remove relation between the groups.

##### HOW-TO

- [Search and display group members](https://perunaai.atlassian.net/wiki/spaces/PERUN/pages/14417974/Search+and+display+group+members)
- Add/remove group members

#### Accepting new group members

Group members can be added to the group directly by the VO/group manager
chosen from the available VO members as described in the above How-To.

They can also register themselves using similar link like for VO
registrations: `https://perun.egi.eu/egi/registrar/?vo=[voName]&group=
[groupName]` where `[voName]` is to be replaced with your actual VO name (as
displayed on VO ID card in OperationsPortal) and `[groupName]` is to be
replaced with the groups full name (including hierarchy), e.g.:
`projectX:students`.

All settings related to the group registration are basically the same as for
the VO registrations, they are just located under the *Group manager*
section in the GUI.

There is just one big difference regarding registration workflow for the
groups. Users must become VO members before the group registration can be
accepted by group manager (or automatically).
In case user is not a member of VO, registration application offers VO
registration first and once submitted user can register for the group.
VO registration must be then approved first.

##### HOW-TO

- Configure registration form and notifications
- Approve/reject submitted registration
- Configure and send invitation notification

#### Group membership lifecycle, expiration rules and renewal

Members' lifecycle within the group is roughly the same as within the VO,
but there are some differences.

- Both VO and Group member status affect, what vo/group membership
  information is provided to the services about the user.
- Group membership statuses are only `VALID` and `EXPIRED`.
- In hierarchical group structures, resulting members' status in a parent
  group is dependent on his/hers status in all child groups and `VALID`
  status takes preference.

##### HOW-TO

- Change group member status and expiration
- Set group membership expiration rules
- Configure registration form and notifications

## Access management

While Perun generally uses concept of *Resources* to represent the access
rights and roles (as service provider is giving them to the VO) and *Groups*
are assigned to it (by the VO managers), it is not usually used like this
within the EGI infrastructure.

Having *Groups* and *Resources* separated allows you to represent your
community or organization structure without the conflict with the roles and
access rights for each service. You can then more easily use one single
group and give its members access to the various services with specific
roles/settings. Any change to the group membership can be then reflected to
all associated services, which is useful especially for the de-provisioning.

### EGI Check-In proxy

For the primary and most basic use-case, when services are behind the EGI
Check-In proxy, access rights are based solely on VO and group membership
information.

Such information is then released by the EGI Check-In proxy as
*eduPersonEntitlement* attribute conforming
[AARC-G002](https://aarc-community.org/guidelines/aarc-g002/) specification.

Both VOs' short name and groups' full name are used to construct the
entitlement value, so using correct naming for the group is required.

Association of specific VO/group membership value with the role or access
rights within the service are responsibility of the service provider.

#### Example

Let's assume, that user is a member of `myvo.egi.eu` VO and the top-level group
`vm_operator` in it. Resulting *eduPersonEntitlement* will look like this:

`urn:mace:egi.eu:group:myvo.egi.eu:vm_operator:role=member#aai.egi.eu`

Perun doesn't support other *roles* within the groups than `member`.

### VOMS

{{% alert title="Note" color="info" %}}
Please note, that because of the nature of the VOMS, users must have
personal certificate associated with their user entry in Perun in order to
be provisioned to the VOMS at all.
{{% /alert %}}

Perun supports direct provisioning of the VOMS. In this use-case users and VOs
are primarily managed within the Perun.
The user data, including group memberships and roles, is then provisioned to
the VOMS, which is used solely as a backend for the services requiring it.

From the VO manager perspective you are given a *Resource* by the service
provider (VOMS operator). It represents your association with the VOMS in
Perun. You can have multiple resources and they can represent either different
set of *VOMS roles* within the same VOMS or represent different VOMS servers.

You can assign any of your groups to it and all users from all the
assigned groups will be provisioned to the VOMS as members of your VO.

On the *Service settings* page of the *Resource* you can set *VOMS roles*, which
will be given to all users associated with it through all the groups.
Similarly, you can set *VOMS roles* on the Group-Resource level. Once you
assign the group to the Resource, you can check *Group settings* page of the
*Resource*, select proper Group and set *VOMS roles* from there. Same group
can have different roles for different VOMS servers like this. Also you can
associate group from Perun with the group in VOMS by settings *Voms group
name* on the same settings page.

## FAQ

### I need all VO members to get "vm_operator" role in OpenStack

You must create top-level group within the VO and name it `vm_operator`. All
members of this group will get this role and Check-In proxy will release
this information as an entitlement for the OpenStack like this:

`urn:mace:egi.eu:group:[VO_NAME]:vm_operator:role=member#aai.egi.eu`

You can make sure all VO members are in this group by creating
relation between this group and the system group *members* (basically you
include *members* as a subgroup through this relation).
