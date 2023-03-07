---
title: "'Notify Site' field and tickets to multiple sites"
type: docs
weight: 40
description: >
  Selecting a Resource Centre as recipient and submitting tickets to multiple RCs
---

## Notify Site field

- The list of sites included in the drop-down menu of the "Notify site" field is
  taken from GOCDB (EGI sites) and from OIM DB (OSG sites).
  - Sites registered in OIM are only visible if they have status "enabled".
  - Sites registered in GOC DB are only visible if they have status "certified".
  - Sites in other states (e.g. "suspended") are not visible in the "Notify
    sites" drop-down list.
- the sites information is synchronized once per night.
- In case a site's status changes, the site disappears from the "Notify sites"
  drop-down list. Existing GGUS tickets related to this site get the "Notify
  sites" field flushed. The NGI to which the site belongs inherits the ticket
  from the site and is in charge of further processing this ticket.

## Notify multiple sites option

- Notifying multiple sites is a feature for submitting tickets with the same
  topic against an unlimited number of sites in GGUS.
- This feature can be used only by users owning a dedicated privileges.
- There is a specific submit form linked from GGUS ticket submit area. In the
  "Notify SITE" drop-down menu sites can be checked for receiving a ticket.
- All sites registered in GGUS can be notified using this option.
