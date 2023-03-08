---
title: "Team tickets"
type: docs
weight: 40
description: >
  Definition and usage of the Team tickets
---

## Introduction: purpose and conditions

- The purpose of TEAM tickets is to allow all team members to modify all tickets
  of their team ,although they may not have support access, and they do not have
  submitted the ticket themselves.
- Only members of a few VOs are allowed to submit team tickets:
  - Alice
  - Atlas
  - CMS
  - LHCb
  - Biomed
  - Belle
- The VO members need to have the appropriate permissions in GGUS user database
- Other VOs can request this functionality by opening a GGUS ticket
- Team tickets are routed to the NGI/ROC the site belongs to automatically. They
  do not need a routing by the TPM. The NGI/ROC is notified about the ticket in
  the usual way. In parallel, the site receives a notification email.

### Becoming a Team-ticket member

People who want to become a team member have to:

- register in GGUS first
- be added to the appropriate group in a VOMS server.

GGUS system synchronizes its user database once per night with the VOMS servers.
The synchronization is based on the DN string. Please make sure the DN of your
GGUS account is the same to the one registered in VOMS.

## Technical description

This section describes the workflows of team tickets from a technical point of
view.

### Team ticket submission

Team tickets can either be submitted using the GGUS web portal. On top of the
ticket submit form in GGUS web portal there is a link to the submit form for
team tickets.

![link to submit form for team tickets](Submit_Team.png)

As team ticket submitters are expected to be experts who will hopefully provide
all necessary information, the number of fields on the team ticket submit form
is reduced to a minimum, compared to the number of fields on the user ticket
submit form

![Submit form for team tickets](Submit_Form_Team.png)

Three fields on this form are mandatory:

- Subject
- MoU Area
- Notified Site

All of the other fields are optional.

### Team ticket processing

The processing of a team ticket consists of two main parts, the notification of
the notified site and the routing of the ticket to the NGI/ROC the site belongs
to.

#### Site notification

In parallel to the creation of a team ticket the GGUS system sends an email
notification directly to the site specified in field “Notify Site”. This email
is sent to a specific site contact mail address.

#### Ticket routing

Team tickets are bypassing the TPMs and routed to the appropriate NGI/ROCs
automatically as long as field "Routing type" is not changed. The decision to
which NGI/ROC a ticket has to be routed is done automatically, based on the
value of the “Notify Site” field.

#### Working on team tickets

For working on team tickets and resolving please use the GGUS portal. A
reference link to the team ticket is given in the team notification mail. Team
tickets can be upgraded to alarm tickets clicking on the button “Click to
convert to ALARM”.

![Team to Alarm](Team_to_alarm.png)

## Team tickets process schema

See the
[schema of the Team Tickets process](GGUS_Graph_TEAM_Ticket_Process.pdf).
