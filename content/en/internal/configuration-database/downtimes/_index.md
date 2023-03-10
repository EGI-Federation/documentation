---
title: Downtimes
description: "Managing and consulting downtimes"
weight: 30
type: "docs"
---

## Definition

A downtime is a period of time for which a service is declared to be inoperable.
Downtimes may be scheduled (e.g. for software/hardware upgrades), or unscheduled
(e.g. power outages). The Configuration Database stores the following
information about downtimes (non exhaustive list):

- The downtime classification (Scheduled or unscheduled)
- The severity of the downtime
- The date at which the downtime was added
- The start and end of the downtime period
- A description of the downtime
- The entities affected by the downtime

## Manipulating downtimes

### Viewing downtimes

There are different pages in the Configuration Database where downtimes are
listed:

- **Active & Imminent**, linked from the main menu, that allows users to see
  currently active downtimes and downtimes planned in the coming weeks.
- **Downtime Calendar**, linked from the main menu, that allows users to view
  and filter all downtimes.
- **Site details**, where all the downtimes associated to the site are listed
- **Service endpoint details**, where all the downtimes associated to the
  service endpoint are listed.
- **Service group details**, where all the downtimes associated to the service
  group are listed.

Each downtime has its own page providing details, accessible by clicking on the
`Downtime Id` link or similar in downtime listing pages.

### Subscribing to downtimes

The [EGI Operations Portal](https://operations-portal.egi.eu/) provides a
publicly-accessible page allowing to view and filter downtimes:
[Operations Portal](https://operations-portal.egi.eu/downtimes/a/timeline).

Authenticated users can
[subscribe to downtimes](https://operations-portal.egi.eu/downtimes/subscription)
affecting sites selected using a filter. The downtimes notifications can be sent
by email, RSS and iCal, allowing to easily integrate with your calendar.

### Adding downtimes

Provided you have proper permissions (check the
[permissions matrix](../users-roles/managing-roles/#permissions-associated-to-roles)
section), you can add a downtime by clicking on the `Add Downtime` link in the
sidebar.

This is done in 2 steps:

1. Enter downtime information
1. Specify the full list of impacted services in case there is more than one or
   select an site to select all the sites associated services.

#### Please note

- All dates have to be entered in UTC or using the Site Timezone.
- A downtime can be retrospectively added if its _start date_ is less than 48h
  in the past (giving a 2 day window to add).
- downtime classification (scheduled/unscheduled) is determined automatically
  (see [Scheduled or unscheduled](#scheduled-or-unscheduled) section)

### Editing downtime information

- To edit a downtime, simply click the `edit` link on top of the downtime's
  details page.
- A downtime can be retrospectively updated if its _start date_ is less than 48h
  in the past (giving a 2 day window to modify).
- Note there are limitations to downtime editing, especially if it has already
  started, or is due to start in the next 24hrs or is finished. See
  [downtime shortening and extension](#downtime-shortening-and-extension)
  section for more details.

### Removing downtimes

To delete a downtime, simply click the `delete` link on top of the downtime's
details page. For integrity reasons, it is only possible to remove downtimes
that have not started.

## Good practices and further understanding

### Scheduled or unscheduled

Depending on the planning of the intervention, downtimes can be:

- `Scheduled`: planned and agreed in advance
- `Unscheduled`: planned or unplanned, usually triggered by an unexpected
  failure or at a short term notice

EGI defines precise rules about what should be declared as scheduled or
unscheduled, based on _how long in advance_ the downtime is declared. These
rules are described in
[MAN02 Service intervention management](../../../providers/operations-manuals/man02_service_intervention_management)
and are enforced as follows:

- All downtimes declared less than 24h in advance will be automatically
  classified as `UNSCHEDULED`
- All other downtimes will be classified as `SCHEDULED`

#### Notes

- A downtime can be retrospectively declared and/or updated if its _start date_
  is less than 48h in the past (giving a 2 day window to add/modify).
- Although 24h in advance is enough for the downtime to be classified as
  `SCHEDULED`, it is good practice to declare it at least 5 working days before
  it starts.

### WARNING or OUTAGE?

When declaring a downtime, you will be presented the choice of a "severity",
which can be either `WARNING` or `OUTAGE`. Please consider the following
definitions:

- `WARNING` means the resource is considered available, but the quality of
  service might be degraded. Such downtimes generate notifications, but are not
  taken into account by monitoring and availability calculation tools. In case
  of a service failure during the `WARNING` period an `OUTAGE` downtime has to
  be declared, cancelling the rest of the `WARNING` downtime.

- `OUTAGE` means the resource is considered as unavailable. Such downtimes will
  be considered as `in maintenance` by monitoring and availability calculation
  tools.

### Downtime shortening and extension

Limitation rules to downtime extensions are enforced as follows:

- Scheduled downtimes due to start in 24 hours cannot be edited in any way, nor
  deleted.
- Other downtimes that have not yet started can be edit and deleted.
  - They can be shortened or moved, i.e. They can be edited such that:
    - Both start and end time are still in the future
    - The duration remains the same or is decreased
- Ongoing downtimes can not be deleted.
- A downtime cannot be edited once it has finished, nor can a new downtime be
  added more than 48 hours into the past.

If for any reason a downtime already declared needs to be extended, the
procedure is to add another adjacent downtime, before or after.
