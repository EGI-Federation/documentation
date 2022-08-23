---
title: "Service Types"
weight: 30
description: >-
  Description of Service types.
---

## Introduction

In the EGI Configuration Database, a service type is a technology used to
provide a service. Each service endpoint is associated with a service type.
Service types are pieces of software while service endpoints are a particular
instance of that software running in a certain context.

## Service Type Naming Scheme

- Service types include grid and cloud middleware, and operational services.
- This attribute corresponds to the Glue2 `Service.Type` attribute and is
  defined as the "Type of service according to a namespace based classification
  (the namespace MAY be related to a middleware name, an organisation or other
  concepts)".
- The naming scheme for new service types therefore follow a reverse DNS style
  syntax, usually naming the technology provider/project followed by technology
  type in lowercase, i.e. ‘provider.type’ (e.g. `org.openstack.swift`).
- Please note, this syntax does not necessarily indicate ownership, the main
  objective is to avoid name clashes between services. For example, different
  projects may have similar services but these may be modified/customised just
  enough to merit a different prefix or service type name.
- Glue2 defines a service type list at:
  - [Glue2 Enums](https://github.com/OGF-GLUE/Enumerations)
  - [Glue2 service types](https://github.com/OGF-GLUE/Enumerations/blob/master/ServiceType_t.csv).
- The Glue2 and GOCDB recommendation is to use lowercase (legacy enum values do
  exist that use camelCase).

These service types are used at some grid sites within EGI but aren't EGI
operational tools or a part of the core middleware distributions.

## Service Type List

To request a new service type, please submit a request for a new service type
(see the section "Adding a new service type").

In the following section there is the list of "middleware agnostic" service
types. You can obtain the whole list of service types by browsing
[Poem](https://poem.egi.eu/ui/public_servicetypes), or by launching the
following query to the GOCDBPI interface:

- [get_service_type](https://goc.egi.eu/gocdbpi/public/?method=get_service_types)

## Operational Components (middleware agnostic)

- [Site-BDII](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=Site-BDII):
  (Site service) This service collects and publishes site's data for the
  Information System. All grid sites MUST install one Site-BDII. For cloud sites
  eu.egi.cloud.information.bdii MUST be installed.
- [Top-BDII](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=Top-BDII):
  (Central service) The "top-level BDII". These collect and publish the data
  from site-BDIIs. Only a few instances per region are required.
- [MyProxy](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=MyProxy):
  [Central service] MyProxy is part of the authentication and authorization
  system. Often installed by sites installing the WMS service.
- [egi.APELRepository](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.APELRepository):
  (Central service) The central APEL repository
- [egi.AccountingPortal](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.AccountingPortal):
  (Central service) The central accounting portal
- [egi.GGUS](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.GGUS):
  (Central service) The central GGUS
- [egi.GOCDB](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.GOCDB):
  (Central service) The central GOCDB
- [egi.MSGBroker](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.MSGBroker):
  (Central service) The central message broker
- [egi.Portal](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.Portal):
  (Central Service) for monitoring generic web portals who dont have a specific
  service type
- (deprecated) MSG-Broker: (Central service) A broker for the backbone messaging
  system.
- [egi.MetricsPortal](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.MetricsPortal):
  (Central service) The central metrics portal
- [egi.OpsPortal](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.OpsPortal):
  (Central service) The central operations portal
- [egi.GRIDVIEW](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.GRIDVIEW):
  (Central service) The central gridview portal
- [egi.GSTAT](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.GSTAT):
  (Central service) The central GStat portal
- [egi.SAM](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.SAM):
  (Central service) The central SAM monitoring
- [ngi.SAM](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=ngi.SAM):
  (Regional Service) NGI-level SAM monitoring box
- [vo.SAM](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=vo.SAM):
  (Regional Service) VO-level SAM monitoring box
- [site.SAM](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=site.SAM):
  (Regional Service) Site-level SAM monitoring box
- [ngi.OpsPortal](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=ngi.OpsPortal):
  (Regional service) NGI-level regional operations portal instance
- [eu.egi.MPI](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=eu.egi.MPI):
  Defines a dummy Service Type to enable the running of MPI tests for services
  providing MPI capabilities. Sites must have one instance of this Service Type
  associated with a CE service.
- [argo.poem](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.poem):
  POEM is system for managing profiles of probes and metrics in ARGO system.
- [argo.mon](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.mon):
  ARGO Monitoring Engine gathers monitoring metrics and publishes to messaging
  service.
- [argo.consumer](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.consumer):
  ARGO Consumer collects monitoring metrics from monitoring engines.
- [argo.computeengine](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.computeengine):
  ARGO Compute Engine computes availability and reliability of services.
- [argo.api](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.api):
  ARGO API service for retrieving status and A/R results.
- [argo.webui](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=argo.webui):
  ARGO web user interface for metric A/R visualization and recalculation
  management.
- [egi.aai.saml](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.aai.saml):
  EGI Check-in SAML interface. Enables federated access to EGI services and
  resources using Security Assertion Markup Language (SAML). Provided by GRNET.
- [egi.aai.oidc](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.aai.oidc):
  EGI Check-in OpenID Connect interface. Enables federated access to EGI
  services and resources using OpenID Connect (OIDC). Provided by GRNET.
- [egi.aai.tts](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&service_type=egi.aai.tts):
  EGI Check-in token translation service. Enables the translation between
  different authentication and authorisation protocols. Provided by GRNET.

## Adding new services types

Please feel free to make a request for a new service type. All new service type
requests need to be assessed by EGI via lightweight review process (by
[EGI OMB](https://go.egi.eu/omb) and EGI Operations) so that only suitable types
are added, and to prevent duplication.

You can submit your request via [EGI Helpdesk](../../helpdesk) to the
"Configuration and Topology Database (GOCDB)" support unit.

Please specify the following information as part of your request:

- name of service type (lowercase):
- high-level description of the service functionality (255 characters max):
- project/community/organization maintaining the software:
- scale of deployment (number of instances and by which organizations):
- contact point (name/email address):

Note: please provide a suggested service type name following the naming scheme
described above (technology provider's reversed domain . software name) and a
brief sentence to describe the service type.
