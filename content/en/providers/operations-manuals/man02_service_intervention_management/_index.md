---
title: "MAN02 Service intervention management"
weight: 20
type: "docs"
description: "How to service interventions"
---

## Document control

| Property            | Value                             |
| ------------------- | --------------------------------- |
| Title               | Service Intervention Management   |
| Policy Group        | Operations Management Board (OMB) |
| Document status     | Approved                          |
| Procedure Statement | Managing Service interventions    |
| Owner               | SDIS team                         |

## Service Intervention

A **service intervention** is defined as an action which will involve or lead to
the possibility of a loss, or noticeable degradation of a service. Depending on
the planning of the outage, we have two types of intervention:

1. **Scheduled** interventions: planned and agreed in advance
2. **Unscheduled** interventions: unplanned, usually triggered by an unexpected
   failure

## How to manage an intervention

Interventions are recorded through the
[Configuration Database](../../../internal/configuration-database). For more
information, have a look at the
[description](../../../internal/configuration-database/downtimes).

### Scheduled interventions

- Scheduled interventions **MUST** be declared at least 24 h in advance,
  specifying reason and duration.
- Existing scheduled interventions **CAN** be extended, provided that it’s done
  24 hours in advance.

### Unscheduled interventions

- Any intervention declared less than 24 h in advance will be considered
  **unscheduled**.
- Sites **MUST** declare unscheduled interventions as soon as they are detected
  to inform the users. Unscheduled interventions CAN be declared up to 48 hours
  in the past (retroactive information to the user community).

### Required information

The required information to fill in when declaring an intervention is:

- Severity (Outage or Warning)
- Description
- Timezone
- Starting and ending dates
- Affected site / Affected services and endpoints

## Recommendations

- For interventions that impact end users, the downtime **SHOULD** be declared 5
  working days in advance, specifying reason and duration.
- A post−mortem **SHOULD** be included in the downtime report.

## Notifications

Intervention notifications (through broadcasts, RSS feeds, etc) as specified in
the following procedures are automatically sent when declaring a downtime in
[Configuration Database](../../../internal/configuration-database): at
declaration time, 24 h in advance and 1 h before the intervention.

## Suspension policy

Sites on downtime for more than 1 month will be suspended/uncertified. `AT_RISK`
downtime declarations are only for providing warnings to users, and are ignored
for calculating site availability (actual status will be used).
