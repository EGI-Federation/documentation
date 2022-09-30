---
title: NGI Core Services
description: "Managing the NGI Core Services entries in Configuration Database"
weight: 30
type: "docs"
---

## NGI Core Services

NGIs can register a number of ‘NGI-Core’ services in the Configuration Database.
A core NGI service is one that is used to calculate the availability and
reliability of the NGI. These services fall under the responsibility of the NGI
and provide production quality (no testing instances). NGIs can distinguish/flag
their core services from their other (non-core) services using one of two ways
(see A and B below).

### Core Service Requirements

The service instance MUST:

- Be flagged as ‘Production’ (see
  [Production Flag](../service-entities/#production-flag-tf))
- Not be flagged as ‘Beta’ (see [Beta Flag](../service-entities/#beta-flag-tf))
- Monitored flag set to true (see
  [Monitored Flag](../service-entities/#monitoring-flag-tf))
- Be hosted under a ‘NGI’ scoped Site that has a certification status of
  ‘Certified’

### Required Service Types

The following service types are mandatory to support the central operations and
all NGIs in the EGI scope should define instances of these services:

- emi.ARGUS (Mandatory) (NGI ARGUS)
- Top-BDII (Mandatory)

Other Mandatory services, depending on middleware deployed by sites under NGI
responsibility, are the following:

- MyProxy
- VOMS

NGIs should also register their custom core services like accounting, helpdesk
if provided. 

### Registering NGI Core Services

NGI core services can be grouped/flagged in one of two ways:

- A) By creating a ‘**NGI_XX_SERVICES’ Site** and adding their core services
  under this site. This site must be scoped as ‘NGI’ and define a certification
  status of ‘Certified’.
- B) By creating a ‘**NGI_XX_SERVICES’ ServiceGroup** and adding their core
  services to this ServiceGroup.

It is important that these core service Sites/ServiceGroups adhere to the
‘NGI_XX_SERVICES’ naming scheme. The list of existing Service Groups is
available on
[GOCDB](https://goc.egi.eu/portal/index.php?Page_Type=Service_Groups).
