---
title: "Security Monitoring"
weight: 30
type: "docs"
description: "Security Monitoring for EGI Resources Providers and Services"
---

## What is it?

EGI is an interconnected federation where a single vulnerable place may have a
huge impact on the whole infrastructure. In order to recognise the risks and to
address potential vulnerabilities in a timely manner, the EGI Security
Monitoring provides an oversight of the infrastructure from the security
standpoint.

Also, sites connected to EGI differ significantly in the level of security and
detecting weaknesses exposed by the sites allows the EGI security operations to
contact the sites before the issue leads to an incident.

Information produced by security monitoring is also important during assessment
of new risks and vulnerabilities since it enables to identify the scope and
impact of a potential security incident.

## Technical description

This service includes the following components.

### Secmon

A Nagios-based service provided to monitor a range of assets like CRLs, file
system permissions, vulnerable file permissions etc.

Ad-hoc probes are deployed to support incident management, to assess the
vulnerability of the infrastructure with regards to specific security issues and
for proactive security management.

The results produced are available to the EGI Security dashboard of the
[Operations Portal](../../operations-portal) for visualisation.

### Pakiti

[Pakiti](./pakiti) is the monitoring and notification service which is
responsible for checking the patching status of systems.

The results produced are available to the EGI Security dashboard of the
[Operations Portal](../../operations-portal) for visualisation.

### Incident reporting tool

Ticketing system for tracking of incident.

### Tools for Security Service Challenge support

Security challenges are a mechanism to check the compliance of sites/NGIs/EGI
with security requirements. Runs of Security Service Challenges need a set of
tools that are used during various stages of the runs.
