---
title: "Alarm tickets"
type: docs
weight: 40
description: >
  Alarm tickets
---

## Introduction: purpose and conditions

- The purpose of ALARM tickets is to notify WLCG Tier-0 and Tier-1
administrators about serious problems of the site at any time, independent from
usual office hours.
- Only experts, nominated by the WLCG VOs are allowed to submit alarm tickets.
They need to have the appropriate permissions in GGUS user database.
- The involved VOs are:
  - Alice
  - Atlas
  - Cms
  - Lhcb
- Only the Tier-0 & Tier-1 sites are involved in the alarm tickets process.
The WLCG Tier-0/Tier-1 site names can be used as well as the relevant GOC DB
site names.
- Alarm tickets are routed to the NGI/ROC the tier site belongs to automatically.
They do not need a routing by the TPM. The NGI/ROC is notified about the ticket in
the usual way. In parallel the site receives an alarm email signed with a GGUS
certificate. This alarm email is processed at the Tier-0/Tier-1 and notifies the
relevant people at any time.
- Alarm email addresses are taken from GOC DB for the EGI sites and from OIM for
the OSG sites. VOMS is used by GGUS as the information source for authorised alarmers.

### Becoming an Alarm-ticket member

People who want to become an alarmer have to

- register in GGUS first
- be added to the appropriate group in a VOMS server.

GGUS system synchronizes its user database once per night with the VOMS servers.
The synchronization is based on the DN string. Please make sure the DN of your GGUS
account is the same than the one registered in VOMS.

Tier-1 site admins can become alarmers for testing the alarm process for their site.
They have to fill in the [registration form](https://ggus.eu/?mode=register) for
supporters. Please add an appropriate comment (e.g. "I'm a xxx tier-1 site admins and
I want to become an alarmer for testing purposes.") in the registration form.

