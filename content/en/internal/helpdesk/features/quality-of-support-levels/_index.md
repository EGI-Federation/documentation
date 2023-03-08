---
title: "Quality of Support (QoS) levels"
type: docs
weight: 40
description: >
  Quality of Support (QoS) levels
---

## Introduction

QoS stands for Quality of Support. It describes the level of support provided by
Support Units in GGUS system.

It has an impact on the ticket
[priority colour](../ticket-priority) in GGUS and the warnings are sent
to SUs if 75% of the maximum response time of the QoS level are over.

## QoS levels

There are three different QoS levels, each defining different response times for
given Ticket Priority.

- Base
- Medium
- Advanced

The default QoS level, if not declared differently, is **Base**.

### Base Level

Base QoS level defines a response time of **5 working days** regardless of the
ticket priority.

### Medium Level

| Ticket Priority | Response time  |
| --------------- | -------------- |
| less urgent     | 5 working days |
| urgent          | 5 working days |
| very urgent     | 1 working day  |
| top priority    | 1 working day  |

### Advanced service

| Ticket Priority | Response time   |
| --------------- | --------------- |
| less urgent     | 5 working days  |
| urgent          | 1 working day   |
| very urgent     | 1 working day   |
| top priority    | 4 working hours |

## QoS level declaration

The QoS level for all of the SUs are available
[here](https://ggus.eu/?mode=resp_unit_info)

For the several EGI services, the QoS levels are defined in the specific
Operational Level Agreements linked in the
[EGI OLA SLA framework page](https://confluence.egi.eu/display/EGISLM/EGI+OLA+SLA+framework#EGIOLASLAframework-OperationalLevelAgreements)
