---
title: "Report generator"
type: docs
weight: 40
description: >
  Report generator
---

## Definitions and prerequisites

The [GGUS Report Generator](https://ggus.eu/?mode=report_view) is available
[from the support section](https://ggus.eu/?mode=support).

The implementation of the report generator started in October 2011. Hence the
report generator does not provide data for tickets submitted before December
2011!

### Timestamps and metrics

- submit timestamp: timestamp when the ticket is submitted
- assign timestamp: timestamp when a ticket gets assigned to a support unit
- response timestamp: timestamp when the ticket status changes from "assigned"
  to any other status value or the ticket gets re-assigned to another support
  unit
- expected response timestamp: timestamp when a ticket should have changed the
  status to any other status value than "assigned" or be re-assigned to another
  support unit at latest
- solution timestamp: timestamp when the status changes to either "solved" or
  "unsolved"

#### Response time

The response time is a performance figure calculated from the support unit's
point of view. It describes how quick a support unit is reacting on tickets.
Response time is the time from

- either assigning a ticket to a support unit and the support unit is kept until
  the first status changes to any other value than "assigned", or
- assigning a ticket to a support unit and the status value "assigned" is kept
  until the support unit changes to any other support unit (re-assign).

The response time is calculated as difference between the timestamp changing the
status or re-assigning the ticket and the assign timestamp. While assigning a
ticket to a support unit the expected response timestamp is calculated by adding
an amount of time to the assign timestamp. The amount of time added depends on
the ticket priority and the kind of support unit. For support units that have
declared a quality of service level the response times are defined by the
[QoS level (wiki)](https://wiki.egi.eu/wiki/FAQ_GGUS-QoS-Levels). For all the
other support units a medium QoS is assumed for calculating the expected
response timestamp. In case the actual response timestamp is greater than the
"expected response" timestamp for middleware support units the "violate" flag is
set.

_Response times are based on office hours. Hence the results unit is working
days._

#### Solution time

The solution time is a performance figure also calculated from the support
unit's point of view. It describes how long it took the support unit for
providing a solution. Solution time is the time from assigning a ticket to a
support unit until it provides a solution for the problem described. "Providing
a solution" means setting the ticket status to "solved" or "unsolved". The
solution time is calculated as the difference between the solution timestamp and
the assign timestamp.

_Solution times are based on office hours. Hence the results unit is working
days._

#### Waiting time

Waiting time is the sum of all time slots the ticket was set to "waiting for
reply". Calculating the waiting time has started in July 2012. For tickets
submitted before July 2012 no waiting time calculation was done. The waiting
time for these tickets may be zero. The waiting time can be excluded when
calculation solution times by ticking the checkbox "exclude waiting time".

#### Ticket lifetime

The ticket lifetime is calculated from the user's point of view. It describes
how long it takes to provide a meaningful solution for a problem reported by the
user. Ticket lifetime is the time from ticket submission to ticket solution
(status "solved/unsolved").

_The ticket lifetime is based on calendar days._

### Time zones

GGUS support units are spread over a wide range of time zones. Some of the
support units themselves are spread over several time zones. However most
support units are located in European time zones. Support units and their time
zones are listed on [a dedicated page](https://ggus.eu/?mode=resp_unit_info).
For middleware product teams GGUS assumes time zone "UTC +1" for all support
units. For all the other support units the system uses the relevant time zone
for calculating timestamps as far as possible.

### Office hours

The systems assumes usual office hours from 09:00 to 17:00 Monday to Friday for
all support units. National holidays are not taken into account. For middleware
product teams the timezone UTC+1 is used as default timezone.

### Ticket priorities

For the calculation of performance figures the original priority set during
ticket submission is used. This priority value is kept as long as the support
unit is in charge of the ticket. Updating the priority value during ticket
lifetime doesn't affect the calculation of performance figures.

### Unit abbreviations

- [wd] means working days
- [d] means calendar days

## Reports description

_Although some of the drop-down lists request the selection of values a query
can be started anyway. In this case the query is equivalent to a query over all
tickets!_

The "Reset" button resets all fields to their default settings besides the time
frame.

### Tickets submitted

This metric gives the number of tickets submitted within the specified time
frame. Major criteria is the submit timestamp. The result lists shows the
**current** status of the tickets.

### Open tickets time

The open tickets time report calculates the time from ticket submission until
now in calendar days. The **submit timestamp** must match the specified time
frame for the report.

### Tickets closed

This metric is focused on the **ticket life time**. It gives the number of
tickets that reached the status "solved" or "unsolved" within the specified time
frame. Major criteria is the **solution timestamp** which is the timestamp
setting a ticket to "solved" or "unsolved". Tickets in other terminal status
like "verified" or "closed" appear in the result list as long as they have been
set to "solved/unsolved" in the given time frame. Besides date, status and the
number of closed tickets the results list displays the average ticket lifetime
and the median ticket lifetime. The result lists shows the current status of the
tickets.

### Response time

This metric focuses on the responsiveness of support units. Major criteria for
this report is the **submit timestamp** which must match the selected time
frame. The result list shows:

- the number of tickets responded
- the number of responses
- average response time and
- median response time

for the specified time frame. The result list shows all support units that have
ever been in charge of a ticket. Hence the same ticket ID may appear several
times. The number of responses may be greater than the number of tickets.

_Response times are based on office hours. Hence an average response time of 1d
3h 23min means 13 hours and 23 minutes in total._

### Violated response time

Specific privileges are required for this report. Only people belonging to a
dedicated technology provider (TP) are able doing reports for this TP. Major
criteria for this report are the **expected response time** defined in SLAs and
the TP.

### Solution time

Major criteria for this report is the **solution timestamp**. The result list
shows:

- the number of solutions
- average response time and
- median response time

for the specified time frame. The result lists shows the current status of the
tickets. _Solution times are based on office hours. Hence an average solution
time of 12d 3h 5min means 99 hours and 5 minutes in total._ The waiting time can
be excluded by ticking the checkbox "exclude waiting time". In case a ticket
gets re-opened the metrics calculation starts again from scratch. Hence the same
ticket can appear several times in the solution times calculation.

## Input parameters and results

### Input parameters

The input parameters vary depending on the report type chosen. Possible input
parameters are:

- Time frame
- Responsible Unit
- Status
- Priority
- Concerned VO
- Ticket type
- Ticket category
- Ticket Scope
- Notified site
- Technology provider
- Date aggregation

#### Time frame

The time frame defines begin and end date of the report. The begin date starts
at 00:00:00. The end date ends at 00:00:00. As the implementation of the report
generator started in October 2011 the report generator does not provide data for
tickets submitted before December 2011!

#### Responsible Units

The drop-down list offers all responsible units integrated in GGUS system. They
can be filtered by keywords. Responsible Units can be either selected all, one
by one or by checking the boxes in front of the responsible unit groups. In case
no responsible units are selected all responsible units are considered in the
reports.

#### Status

The drop-down list offers all status values available in GGUS system. Multiple
selections are possible.

#### Priority

The drop-down list offers all priority values available in GGUS system. Multiple
selections are possible.

#### Concerned VO

"Concerned VO" provides a drop-down list of all VOs supported by GGUS. Multiple
selections are possible.

#### Ticket type

This drop-down list lists all ticket types in GGUS. Multiple selections are
possible.

#### Ticket category

Selectable categories are "Incident", "Change request", "Documentation", "Test".
Multiple selections are possible. The category "Test" should not be considered
for all reports and therefore, if necessary, be excluded from the selection.

#### Ticket scope

To distinguish between tickets under the responsibility of EGI or WLCG.

#### Notified site

"Notified site" lists all sites integrated in GGUS. They are derived from GOC DB
and OIM DB. In case of reporting exclusively on tickets without any site value
specified please ticket the "blank" value in the drop-down list.

#### Technology Provider

This input parameter is only visible if choosing the "violated response time"
report. For accessing this report specific privileges are required. The
drop-down list offers all technology providers currently integrated in GGUS and
the "DMSU". Multiple selections are possible. In case no technology provider is
selected the reports will be done for tickets without any technology provider
specified.

#### Date aggregation

The results aggregation level can be chosen from the drop down list "Choose date
aggregation".

#### Group by

Results can be grouped by one or more of the input parameters.

### Results

The results are displayed below the input parameter area. They can be sorted in
different ways by clicking on the column labels. A drill-down is possible by
clicking on any row of the results list. The detail results open in a new
window. They can be sorted by clicking the column labels too. Clicking on the
ticket ID opens the ticket in GGUS system. At the bottom of the result panel
there are various icons offering features like:

- Search
- Refresh
- Export
- Export what you see

Doing a simple _"Export"_ saves the data in a csv file stripping all column
headers. For exporting the data including the column headers please use _"Export
what you see"_. The _"Search"_ feature allows searching in the result list.
Possible search parameters are the columns of the result list.
