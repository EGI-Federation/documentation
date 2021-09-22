---
title: Service registration requirements
description:
  "Information required for registering a service into the Configuration Database"
weight: 50
type: "docs"
---

Information to provide when registering a new service (the fields marked with an
asterisk are mandatory):

- Hosting Site \* (select the appropriate RC under which you are registering the
  service)
- Service Type \* (select the appropriate service type)
- Service URL (Alphanumeric and $-\_.+!\*'(),:)
- Host name \* (valid FQDN format)
- Host IP a.b.c.d
- Host IPv6 (0000:0000:0000:0000:0000:0000:0000:0000[/int]) (optional [/int]
  range)
- Host DN (/C=.../OU=.../...)
- Description \* (Alphanumeric and basic punctuation)
- Host Operating System (Alphanumeric and basic punctuation)
- Host Architecture (Alphanumeric and basic punctuation)
- Is it a beta service (formerly PPS service)? Y/N
- Is this service in production? Y/N
- Is this service monitored? Y/N
- Contact E-Mail \* (valid email format)

## Scope Tags

- ✓ Optional Tags (At least 1 optional tags must be selected): EGI Local
  FedCloud
- ✓ Reserved Tags Inheritable from Parent Site: none
- ✓ Reserved Tags Directly Assigned (WARNING - If deselected you will not be
  able to reselect the tag - it will be moved to the 'Protected Reserved Tags'
  list): none
- ✗ Protected Reserved Tags (Can only be assigned on request): alice atlas cms
  elixir lhcb tier1 tier2 wlcg
