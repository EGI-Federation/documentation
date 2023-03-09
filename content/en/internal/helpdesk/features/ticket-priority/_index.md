---
title: "Ticket Priority"
type: docs
weight: 40
description: >
  Definition and computation of the ticket priority in relation to the QoS levels
---

## Priority definition

If you plan to adjust the ticket priority from the default value 'less urgent'
to 'urgent', 'very urgent' or 'top priority', please make sure you add a
justification for this change in the problem description field.

The following table will help you to find an appropriate priority value:

| Priority     | Comment                                                        |
| ------------ | -------------------------------------------------------------- |
| top priority | service interrupted; needs to be addressed as soon as possible |
| very urgent  | service degraded; no workaround available                      |
| urgent       | service degraded; workaround available                         |
| less urgent  | wishes and enhancements that are "nice to have"                |

In particular, be very economical when choosing 'top priority'. This value, when
reaching the supporters via another ticketing system interface, might become a
beep or phone alert even in the middle of the night. This level of support is
ONLY committed by WLCG Tier0 and Tier1s and ONLY for ALARM tickets.

Finally, please be aware that the supporter who will try to solve your problem
may change the value you have chosen to a more realistic one, putting their
justification in the ticket's public diary.

## Priority colours

### The purpose of the priority colours in GGUS

The priority colours in GGUS should help supporters getting an overview of the
most important tickets. The priority colours have no impact on the metrics
generated with the GGUS report generator or manually by the GGUS team.

### The colours used

Currently the following colours are used for open states:

- green
- yellow
- amber
- red

For terminal states GGUS uses:

- light blue for status “unsolved” and
- blue for status “solved” and “verified”.

### Fields affecting the priority colour algorithm

The priority colour algorithm is affected by the status value and the priority
of a ticket. The priority colour calculation for tickets in status "assigned" is
based on different values than for tickets in any other open status.

### Office hours and weekends

Office hours and weekends are taken into consideration when calculating the
priority colour. The system assumes usual office hours from 07:00 to 15:00
o’clock UTC from Monday to Friday for all support units. Different time zones
are considered as far as possible.

### Priority colour and status values

The priority colour calculation starts after a ticket gets assigned to any
support unit. The support units should change the ticket status to "in progress"
or any other open status after receiving the ticket. Thus the support unit has
responded to the ticket (response time). After such a status change the priority
is reset to "green" and the calculation of the priority colour starts again from
scratch.

### Algorithm for middleware related tickets

The priority colour for tickets dealing with middleware related problems is
calculated according to the Quality of Support the PTs voted for. The priority
colour changes after a dedicated amount of working hours as listed in the table
below. The priority colour calculation is processed every 15 minutes.

| QoS Level| Ticket priority | Colour          | Working hours | Colour        | Working hours | Colour        | Working hours |
| -------- | --------------- | --------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Base     | less urgent     | Yellow          | 20            | Amber         | 30            | Red           | 40            |
|          | urgent          |                 | 20            |               | 30            |               | 40            |
|          | very urgent     |                 | 20            |               | 30            |               | 40            |
|          | top priority    |                 | 20            |               | 30            |               | 40            |
| Medium   | less urgent     | Yellow          | 20            | Amber         | 30            | Red           | 40            |
|          | urgent          |                 | 20            |               | 30            |               | 40            |
|          | very urgent     |                 | 4             |               | 6             |               | 8             |
|          | top priority    |                 | 4             |               | 6             |               | 8             |
| Advanced | less urgent     | Yellow          | 20            | Amber         | 30            | Red           | 40            |
|          | urgent          |                 | 4             |               | 6             |               | 8             |
|          | very urgent     |                 | 4             |               | 6             |               | 8             |
|          | top priority    |                 | 2             |               | 3             |               | 4             |

### Algorithm for tickets other than middleware

The priority colour changes after a dedicated amount of working hours as listed
in the table below. The priority colour calculation is running every 15 minutes.

| Ticket priority | Colour | Working hours |
| --------------- | ------ | ------------- |
| less urgent     | Yellow | 20            |
|                 | Amber  | 30            |
|                 | Red    | 40            |
| urgent          | Yellow | 20            |
|                 | Amber  | 30            |
|                 | Red    | 40            |
| very urgent     | Yellow | 16            |
|                 | Amber  | 24            |
|                 | Red    | 32            |
| top priority    | Yellow | 12            |
|                 | Amber  | 18            |
|                 | Red    | 24            |
