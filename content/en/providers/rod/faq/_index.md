---
title: "ROD FAQs"
weight: 1
type: docs
description: >-
     FAQs concerning the ROD activity.
---

## How to handle issues during weekends and public holidays?

Due to the fact that weekends and public holidays are not considered working
days it is noted that ROD teams do not have any responsibilities during these
days. RODs should ensure that in these days tickets do not expire and alarms
will not age above 72h.

## What to do with alarms when node is not in production and is part of production site?

It often happens that testing nodes on production sites are set as
non-production. In such case Nagios monitoring system will send information
about all nodes. As a result ROD will see on their dashboard alarms for
non-production node. If it necessary to monitor such testing node it is
recommended to put such non-production node in downtime.

## What to do when a sites have multiple alarms/ticket?

When opening a ticket against a site with existing tickets ROD should consider
that these problems may be linked or dependant on pending solutions. In such
case ROD should use grouping mechanism to gather and assign alarms to one
ticket rather than open a ticket for each alarm.

If the problem is different but maybe linked the expiry dates for each ticket
should be synchronized to the latest date.

## How to handle issues for site/node in downtime?

### Handling tickets for site/node in downtime

When a ticket has been raised against a site that subsequently enters in
downtime, the expiry date on the ticket can be extended.

Sites that are in downtime will still have monitoring switched on and therefore
may appear to be failing tests but no alarms on Operations Portal will be raised
against them. ROD must take care that when opening tickets to ensure that they
don't open tickets against sites in downtime.

### Handling alarms for site/node in downtime

It often happens that a failure occurred generating a lot of alarms and then
site manager decided to put site in Downtime. Getting these alarms OK may take
more than 72h when the issue is escalated to Operations.

ROD should not create a ticket for sites/nodes in Downtime and is not obligated
to deal with such alarms but it is recommended to close these alarms to avoid
being escalated to Operations. In such case as a reson of closing NON-OK alarm
ROD should put link to the downtime in GOC DB.

### Site in downtime for more than a month

If a site is in DOWNTIME for more than a month then it is advised that the site
should go to the suspended status.

## What to do in case of accounting issue?

In case of problems with accounting it is not recommended to suggest downtime at
the second step of the escalation process for this test. Accounting service is not
a functionality which is critical for users but it still need to be follow up.

## Watch out for flapping states

You may want to wait for a second test to be run before closing an alarm which is
in an OK status. This ensures that the OK result for that tests is stable. The
waiting period is, of course, dependent on how long the test takes and how
frequently it is checked.

## How to handle the eu.egi.lowAvailability alarm?

Go to procedure [PROC04 Quality verification of monthly availability and
reliability statistcs](https://confluence.egi.eu/x/xx4mBg).
