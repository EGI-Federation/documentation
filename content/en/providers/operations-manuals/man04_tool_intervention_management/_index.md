---
title: MAN04 Tool Intervention Management
weight: 30
type: "docs"
description: "How to manage central operational tool unscheduled downtimes"
---

| Property            | Value                                                        |
| ------------------- | ------------------------------------------------------------ |
| Title               | Tool Intervention Management                                 |
| Policy Group        | Operations Management Board (OMB)                            |
| Document status     | Approved                                                     |
| Procedure Statement | How to manage central operational tool unscheduled downtimes |
| Owner               | SDIS team                                                    |

The purpose of this document is to describe the intervention in case of
unscheduled failure of central operational tool.

## Scope

This manual only applies to unscheduled downtimes of central operational tools.
The list of central operational tool is available
[here](https://wiki.egi.eu/wiki/Tools).

Note: Scheduled downtimes are management according to existing procedures
([MAN02](../man02_service_intervention_management)).

## Announcements

All announcements should be sent with the Operations Portal Broadcast tool.

When using Operations Portal Broadcast tool the following groups should be
included:

- LCG Rollout Mailing List
- Operators Mailing lists
- OSG Mailing list
- Tool Admins Mailing List
- WLCG Tier 1 contacts
- NGI managers
- VO managers
- VO users
- Site administrators
- Operation tools

**Notice:** Individual notification templates together with targets are
predefined in Operations Portal Broadcast tool. Administrators are advised to
use such predefined templates.

## Procedure

In the following sections several relevant scenarios are covered.

### Case 1: short "undetected" downtime

**Description:** Service fails and recovers before administrator manages to
react (e.g. short power or network outage).

**Action:** Administrator announces the failure by using the following template:

```text
Subject:
 [SERVICE_NAME] unscheduled downtime

Message:
 Dear all,

 [SERVICE_NAME] experienced unscheduled downtime between [START] and [END].

 [DETAILED_FAILURE_DESCRIPTION]

 Apologies for any inconvenience caused.

 Best Regards
 [SERVICE_TEAM]
```

### Case 2: long "detected" outage

Service fails and administrator detects the problem. The problem takes at least
**1 hour** time to recover. In the sections below individual situations are
described.

#### 1. Outage

**Description:** Service failure is detected.

**Action:** Administrator announces the failure by using the following template:

```text
Subject:
 [SERVICE_NAME] outage

Message:
 Dear all,

 [SERVICE_NAME] is experiencing unscheduled downtime.

 [ADDITIONAL_INFO]

 Apologies for any inconvenience caused.

 Best Regards
 [SERVICE_TEAM]
```

#### 2. Extended downtime

**Description:** Service recovery is delayed. Update should be sent at least
every **24h**.

**Action:** The administrator announces that recovery is taking longer by using
the following template:

```text
Subject:
 [SERVICE_NAME] extended outage

Message:
 Dear all,

 Outage of [SERVICE_NAME] is extended.

 [ADDITIONAL_INFO]

 Apologies for any inconvenience caused.

 Best Regards
 [SERVICE_TEAM]
```

**Note:** In this template `[ADDITIONAL_INFO]` should indicate the estimated
time of recovery.

#### 3. Recovery

**Description:** Service is recovered.

**Actions:** At the time of recovery the administrator announces the recovery by
using the following template:

```text
Subject:
 [SERVICE_NAME] recovery

Message:
 Dear all,

 [SERVICE_NAME] is back online.

 [ADDITIONAL_INFO]

 Best Regards
 [SERVICE_TEAM]
```

#### 4. Post mortem analysis

**Description:** Service failure required further time to investigate the source
of the problem. This action is required only if the post mortem analysis is
needed.

**Actions:** The administrator announces the post mortem analysis of failure by
using the following notification template:

```text
Subject:
 [SERVICE_NAME] outage analysis

Message:
 Dear all,

 [SERVICE_NAME] experienced unscheduled downtime between [START] and [END].

 [DETAILED_FAILURE_DESCRIPTION]

 Best Regards
 [SERVICE_TEAM]
```
