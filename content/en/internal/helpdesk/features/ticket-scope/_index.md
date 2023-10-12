---
title: "Ticket Scope"
type: docs
weight: 40
description: Description of ticket scopes
---

## Priority definition

The GGUS ticket **scope** filter is available in GGUS ticket search. It offers
filtering for tickets in **EGI** or **WLCG** scope. The ticket scope field is
automatically set by the system based on the qualifications listed below.

**WLCG scope** tickets are either:

- of type `TEAM` or `ALARM` related to VOs `alice`, `atlas`, `cms`, `lhcb`,
  `belle`
- assigned to `VOSupport` related to VOs `alice`, `atlas`, `cms`, `lhcb`,
  `belle`
- assigned to `OSG Software Support`, `USCMS`, `USATLAS`, `USBELLE`, `CRIC`
- with issue type like `CMS_`, `ATLAS_`

> All other tickets are **EGI scope**.
