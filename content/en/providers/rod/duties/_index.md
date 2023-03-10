---
title: Duties
weight: 20
type: docs
description: "Description of duties of regional operators"
---

## Introduction

A ROD team's duties can be split into three main areas: handling alarms and
tickets, handling downtimes, and communicating urgent issues to the EGI
Operations and CSIRT teams.

## Handling alarms and tickets

The main responsibility of ROD is to deal with alarms and tickets issued for
sites in the region. This includes making sure that the tickets are created and
handled properly.

The ROD on duty is required to:

- check alarm notifications in the Dashboard at least twice a day;
- close alarms which are in the OK state;
- handle non-OK alarms less than 24 hours old (notify the site administrators
  according to your NGI's procedures);
- create tickets for alarms older then 24 hours that are not in an OK state;
- escalate tickets to NGI Management/EGI Operations if necessary (in the
  Dashboard);
- monitor and update any GGUS tickets up to the solved status (preferably via
  the Dashboard);
- handle the final state of GGUS tickets not opened from the Dashboard by
  changing their status to verified.

## Putting a site in downtime for urgent matters

ROD can place a site or a service endpoint (there can be multiple services
running on a single host) in downtime in the GOCDB if it is either requested by
the site, or if ROD sees an urgent need to do it.

> **Note**: This is actually optional; an NGI may decide on a different policy
> if the site admins are not happy with ROD setting downtimes for them. However,
> it should be considered mandatory in case of urgent security incidents.

ROD may also suspend a site, under exceptional circumstances, without going
through all the steps of the escalation procedure. For example, if a security
hazard occurs, ROD must suspend a site on the spot in the case of such an
emergency. It is important to know that EGI Operations can also suspend a site
in the case of an emergency, for example as a result of a security incident or
lack of response.

In both scenarios, it is important that ROD communicates their actions to all
involved parties.

## Notifying EGI Operations and EGI CSIRT about urgent matters

ROD should create tickets to EGI Operations in the case of urgent matters. For
security related issues, ROD should also notify the
[CSIRT](https://confluence.egi.eu/display/EGIBG/CSIRT) duty contact.

ROD is also responsible for propagating actions from EGI Operations down to
sites (this occurs rather infrequently, though).
