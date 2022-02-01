---
title: "Report generator"
type: docs
weight: 40
description: >
  Report generator
---

## Definitions and prerequisites

The GGUS Report Generator is available at https://ggus.eu/?mode=report_view.

The implementation of the report generator started in October 2011. Hence the
report generator does not provide data for tickets submitted before December
2011!

### Timestamps and metrics

- submit time stamp: time stamp when the ticket is submitted
- assign time stamp: time stamp when a ticket gets assigned to a support unit
- response time stamp: time stamp when the ticket status changes from "assigned"
to any other status value or the ticket gets re-assigned to another support unit
- expected response time stamp: time stamp when a ticket should have changed the
status to any other status value than "assigned" or be re-assigned to another
support unit at latest
- solution time stamp: time stamp when the status changes to either "solved" or
"unsolved"

#### Response time

The response time is a performance figure calculated from the support unit's
point of view. It describes how quick a support unit is reacting on tickets.
Response time is the time from
- either assigning a ticket to a support unit and the support unit is kept until
the first status changes to any other value than "assigned",
or
- assigning a ticket to a support unit and the status value "assigned" is kept
until the support unit changes to any other support unit (re-assign).

The response time is calculated as difference between the time stamp changing the
status or re-assigning the ticket and the assign time stamp. While assigning a
ticket to a support unit the expected response time stamp is calculated by adding
an amount of time to the assign time stamp. The amount of time added depends on
the ticket priority and the kind of support unit. For support units that have
declared a quality of service level the response times are defined by the
[QoS level (wiki)](https://wiki.egi.eu/wiki/FAQ_GGUS-QoS-Levels).
For all the other support units a medium QoS is assumed for calculating the expected
response time stamp. In case the actual response time stamp is greater than the
"expected response" time stamp for middleware support units the "violate" flag is set.

*Response times are based on office hours. Hence the results unit is working days.*

#### Solution time

The solution time is a performance figure also calculated from the support unit's
point of view. It describes how long it took the support unit for providing a solution.
Solution time is the time from assigning a ticket to a support unit until it provides
a solution for the problem described. "Providing a solution" means setting the ticket
status to "solved" or "unsolved". The solution time is calculated as the difference
between the solution time stamp and the assign time stamp.

*Solution times are based on office hours. Hence the results unit is working days.*

#### Waiting time

Waiting time is the sum of all time slots the ticket was set to "waiting for reply".
Calculating the waiting time has started in July 2012. For tickets submitted before
July 2012 no waiting time calculation was done. The waiting time for these tickets may
be zero. The waiting time can be excluded when calculation solution times by ticking the
check box "exclude waiting time".

#### Ticket lifetime

The ticket lifetime is calculated from the user's point of view. It describes how long
it takes to provide a meaningful solution for a problem reported by the user. Ticket
lifetime is the time from ticket submission to ticket solution (status "solved/unsolved").

*The ticket lifetime is based on calendar days.*

### Time zones

GGUS support units are spread over a wide range of time zones. Some of the support units
themselves are spread over several time zones. However most support units are located in
European time zones. Support units and their time zones are listed at
https://ggus.eu/?mode=resp_unit_info.
For middleware product teams GGUS assumes time zone "UTC +1" for all support units.
For all the other support units the system uses the relevant time zone for calculating
timestamps as far as possible.

### Office hours

The systems assumes usual office hours from 09:00 to 17:00 Monday to Friday for all
support units. National holidays are not taken into account. For middleware product
teams the timezone UTC+1 is used as default timezone.

### Ticket priorities

For the calculation of performance figures the original priority set during ticket
submission is used. This priority value is kept as long as the support unit is in charge
of the ticket. Updating the priority value during ticket lifetime doesn't affect the
calculation of performance figures.

### Unit abbreviations

- [wd] means working days
- [d] means calendar days

