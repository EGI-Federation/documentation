---
title: "Managing downtimes"
weight: 50
type: docs
description: >-
  Description on how to deal with scheduled and unscheduled interventions and
  downtimes.
---

## Downtimes

To properly manage downtimes it is important to highlight the differences
between the possible types of downtimes. Downtimes can't be added retroactively,
and the date is always defined in UTC. If the error messages received when
adding a downtime is cryptic, usually it's due to a parsing error on the
time/date.

### Downtimes classification

1. **scheduled**: e.g. for software/hardware upgrades, planned and agreed in
   advance. This needs to be announced at least 24h in advance.
2. **unscheduled**: e.g. power outages, unplanned, usually triggered by an
   unexpected failure.

### Downtimes severities

1. **WARNING**: Resource will probably be working as normal, but may experience
   problems.
2. **OUTAGE**: Resource will be completely unavailable.

**WARNING**, formerly known as **AT_RISK**, implies a type of severity that does
not have operational consequences. It is only an information for users that some
small temporary failures can appear. All failures during that time will be taken
into account in the reliability calculations. Examples include:

- Admins not present on site (conference, vacations).
- Reduced redundancy in network, power or cooling.
- Failed disk in RAID sets.

**OUTAGE** implies that the site/node is completely unavailable and no tickets
should be created. This does not affect site metrics.

More information about downtimes can be found in the
[Configuration Database user documentation](../../../internal/configuration-database/downtimes/).

## Sites in downtime

When a ticket has been raised against a site that subsequently enters in a
downtime, the expiry date on the ticket can be extended.

When a ticket is opened against a site that continues to add or increase the
downtime the ticket must be closed, and the NGI requested to take action either
by suspending or un-certifying the site until such time that the problem is
resolved. This usually happens when a middleware upgrade is due or a bug in the
middleware is causing a site to fail. Sites then may choose to wait for the next
middleware release rather than spend effort trying to resolve the issue locally.

Sites that are in downtime will still have monitoring switched on and therefore
may appear to be failing tests. ROD must take care that when opening tickets to
ensure that they don’t open tickets against sites in downtime.

> If a site is in downtime for more than a month, then it is advised that the
> site should go to the **uncertified** state.

### Nodes in downtime

When a node of a site is in downtime, alarms are generated but the
[Operations Portal](../../../internal/operations-portal) distinguishes these
alarms, and marks the downtime accordingly in the dashboard.

> ROD should not open tickets against nodes that are in downtime.

### Instructions for accounting monitoring failures

The [Accounting](../../../internal/accounting) monitoring tests are not run
against the site but query the central accounting repository.

1. If there is more than one failure for a given site, create a ticket for one
   of the alarms and mask all others by this one.
2. Edit the description of the ticket to state clearly that even though the
   failure is reported for a given CE, this is not a CE failure but a failure on
   the Accounting service for the whole site.
3. Proceed with all sites in the same way. Please beware: Accounting tests are
   not helped by scheduling downtime, the site admins need to get Accounting
   publishing working again.

## Nodes not in production

When a node of a production site is declared as non-production in the
Configuration Database or the node appears in BDII but is not declared in the
Configuration Database, then the ROD should do the following:

- Recommend to the sites to take these nodes out of their site BDII
- If this is not a possibility then the site should set those nodes in downtime
  in the
  [EGI Configuration Database](../../../internal/configuration-database/downtimes)
- If the node is a test node and is in BDII but not in the Configuration
  Database, then the sites should register it and turn monitoring off.
