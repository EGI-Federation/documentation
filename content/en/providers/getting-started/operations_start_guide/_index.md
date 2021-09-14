---
title: Operations Start Guide
type: docs
---

## Introduction

The Operations Start Guide will help you start with EGI Operations duties. It
covers the responsibilities of the various parties involved in the running of
the [EGI infrastructure](https://ims.egi.eu/display/EGIG/EGI+Infrastructure) 
and guide how to join operations. As a newcomer, you need to understand the 
structure of the infrastructure and roles of operators at different levels. 
Reading the whole document will give you a complete overall picture of daily 
operations within EGI.

## Resource Centres and Resource Infrastructures

Resources are geographically distributed and are contributed by [Resource Centres](
https://ims.egi.eu/display/EGIG/Resource+Centre).
A Resource Centre is the smallest resource administration domain within EGI. It can
be either localized or geographically distributed. A Resource Centre is also known
as a “site”. It provides a minimum set of local or remote IT Services compliant to 
well-defined IT Capabilities necessary to make resources accessible to authorised 
Users such as HTC, Cloud Compute, Storage, Data Access, etc. Access is granted by 
exposing common interfaces to users.

A Resource Infrastructure federates one or more Resource Centres to constitute a 
homogeneous operation domain, and the [Resource Infrastructure Provider](
https://ims.egi.eu/display/EGIG/Resource+Infrastructure+Provider) is the legal 
organisation that is responsible of establishing, managing and of operating directly 
or indirectly the operational services to an agreed level of quality needed by the 
Resource Centres and the user community. It holds the responsibility of integrating 
them in EGI to enable uniform resource access and sharing for the benefit of their 
consuming end-users. Examples of a Resource infrastructure Provider are the [European 
Intergovernmental Research Organisations(EIRO)](
https://ims.egi.eu/display/EGIG/European+Intergovernmental+Research+Organisation) and the 
[NGIs](https://ims.egi.eu/display/EGIG/NGI).

In Europe, Resource Centres are required to be affiliated to the respective NGIs, which 
(a) have a mandate to represent their national users community in all matters falling 
within the scope of the EGI Infrastructure, and (b) are the only organization having the 
mandate described in (a) for its country and thus provide a single contact point at the 
national level.

## Roles

The following describes the roles that are commonly found in the EGI Infrastructure and 
Operations. The correspondent roles defined in GOCDB give specific rights in the GOCDB 
itself and in other EGI services. Other terms  and definitions can be found in the 
[EGI Glossary](https://go.egi.eu/glossary).

### Resource Centre level

#### Resource Centre Administrator

An individual who is responsible for installing, operating, maintaining and supporting 
one or more Resources or IT Services in a Resource Centre. In the scope of
Operations, RC administrators primarily receive and react on incidents at their RC and on 
service requests notified through tickets created on the [EGI Helpdesk service]
(http://ggus.eu). They should respond to the tickets in a suitable time frame as defined in the
[RC OLA document](https://documents.egi.eu/document/31) and be aware of the alarms at their 
site, eg. through the [operations dashboard](https://operations-portal.egi.eu). Sites 
must only operate supported middleware versions. This implies upgrading it from time to
time. Emergency releases are treated in a special way. RC Administrators will  also 
need to react to security issues that are at a global level, but affect their site.
See
[SEC03 EGI-CSIRT Critical Vulnerability Handling](https://wiki.egi.eu/wiki/SEC03_EGI-CSIRT_Critical_Vulnerability_Handling).

#### Site Operations Manager

The person responsible for the site at the political and legal level. S/he is
responsible for signing the Operations Level Agreement
([OLA](https://documents.egi.eu/public/ShowDocument?docid=31)) between the Site
and the NGI that hosts the site operationally. The Site Operations Manager is
also responsible for assigning and approving the other site roles in the
[GOCDB](https://goc.egi.eu/). Further, s/he should ensure that administrators
are subscribed to relevant mailing lists.

#### Site Security Officer

The person responsible for keeping the site compliant with the
[Security policies](https://wiki.egi.eu/wiki/EGI_CSIRT:Policies). She/he is also
the primary contact for the NGI Security officer and EGI CSIRT. The Site
Security Officer deals with security incidents and shall respond to enquiries in
a timely fashion as defined in the collection of
[security procedures and policies](https://wiki.egi.eu/wiki/EGI_CSIRT:Policies).

### Regional level

#### Regional Operator on Duty (ROD)

A team responsible for solving problems/incidents in the infrastructure
according to agreed procedures. ROD (teams) monitor the sites in their region,
react to problems identified by the monitoring tools, and oversee problems
through to their resolution. They ensure that problems are properly recorded and
that the solutions progress according to specified time lines. They also provide
support to sites and VOs as needed and provide informational flow to oversight
bodies in cases of non-responsive sites. They ensure that all necessary
information is available to all parties. The team is provided by each NGI and
requires procedural knowledge on the process (rather than technical skills) for
their work. New ROD team members are required to read the
[ROD Welcome page](https://wiki.egi.eu/wiki/Regional_Operator_on_Duty_welcome)
and be familiar with
[ROD wiki page](https://wiki.egi.eu/wiki/Regional_Operator_on_Duty).

#### NGI Security officer

The member of EGI-CSIRT IRTF (Incident Response Task Force) currently on shift.
Further information can be found at the
[CSIRT:IRTF](https://wiki.egi.eu/wiki/EGI_CSIRT:IRTF) page. The role of the IRTF
team is to handle day to day operational security issues and coordinate
_Computer Security Incident Response_ across the EGI infrastructure. NGIs and
Sites **MUST** respond in a timely manner to its requests and alerts.

#### NGI Operations manager

NGI operations manager is the contact point for all operational matters and
represents the NGI within the
[Operations Management Board](https://confluence.egi.eu/display/EGIBG/Operations+Management+Board).

S/he is mainly responsible for:

- keeping the NGI entry in the GOCDB up to date and for managing the status of
  all sites under that NGI, and ensuring that that information is also kept
  current
- addressing problems with Site availability or reliability. The reports are
  issued on a monthly basis and the NGI operations manager has 10 days to
  respond to identified problems
- attending regular
  [Operations-Management-Board (OMB) meetings](https://indico.egi.eu/category/19/)

All NGI operations management responsibilities are listed in the
[RP OLA document](https://documents.egi.eu/document/463).

### Project level

#### Chief Operations Officer

Chief Operations Officer leads EGI Operations, and is responsible for
coordinating the operations of the infrastructure across the project.

#### EGI CSIRT

[EGI CSIRT](https://wiki.egi.eu/wiki/EGI_CSIRT:Main_Page) is an official
security team coordinator and contact point at project level.

#### Operations Support

Operations Support team is provided on a global layer and is responsible for the
supporting EGI Operations. Examples of its activities are service level
management, service level reporting, service management in general and central
technical.

#### VO

A Virtual Organisation (VO) is a group of users and, optionally, resources,
often not bound to a single institution or national borders, who, by reason of
their common membership and in sharing a common goal, are given authority to use
a set of resources. Each VO member signs the VO AUP (during registration) which
is the policy document describing the goals of the VO thereby defining the
expected and acceptable use of the Grid by the users of the VO. User
documentation can be found [here](https://wiki.egi.eu/wiki/User_Documentation).

#### VO manager

An individual responsible for the membership registry of the VO including its
accuracy and integrity.

## Joining operations

In order to join any of the organisational groups in your NGI, you will need to
go through the following steps in order:

### Authentication

The authentication in EGI infrastructure works either with X509 personal
certificates or through federated identities

#### Obtaining a X509 personal certificate

If you do not already have a X509 personal certificate
[this page](http://www.eugridpma.org/members/worldmap/) provides a map of all
certification authorities according to country (or NGI). Select your country on
the map to find out who is your local CA. Follow the procedure for your local CA
to request a certificate. When you have received your certificate, install it
into your web browser.

If case of setting up new Resource Center please request for Host certificate.

EUGridPMA provides
[a web page allowing to test your certificate](https://www.eugridpma.org/your-identity/).
Please use this resource and contact your CA if your certificate does not work.

#### Create a federated identity: registration in EGI Check-in

As soon as you try to access an EGI service with your federated identity, you will be
requested to register an account in EGI Check-in if not existing yet.
[On this page you will find a guide](https://docs.egi.eu/users/check-in/signup/) 
explaining how to sign up for an EGI account.
If you already own an account, you will be simply asked to login through EGI Check-in.

### Joining dteam VO

It is recommended to join the [dteam VO](https://wiki.egi.eu/wiki/Dteam_vo) at
the [dteam Registration](https://voms2.hellasgrid.gr:8443/voms/dteam/) page. You
should request group membership for `/dteam` and `/dteam/YOUR_NGI`. The dteam
group manager will then be notified and review your application.

### Requesting GOCDB access

- Read
  [Input System User Documentation](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation)
  first.
- Go to the [GOCDB instance](http://goc.egi.eu/) and follow
  [the instruction](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#Users_and_roles)

All new members **need to notify their NGI operations manager** about their role
request, as GOCDB currently '''does not '''send any notification about pending
requests.

### Registering into GGUS

To register into GGUS please follow the
[Central GGUS registration](https://ggus.eu/?mode=register) link. GGUS can be
accessed either with your X509 personal certificate or with your fedewrated identity.
Do not forget to apply for [the support role](https://ggus.eu/?mode=register) as well. (The GGUS support
staff will approve you quickly as they get the notification automatically).
To get the supporter role with your federated identity, please enroll to the [GGUS
Supporters group](https://aai.egi.eu/registry/co_petitions/start/coef:69) in Check-in.

Some NGIs also have a local helpdesk or a regional GGUS. Ask your NGI operations
manager if how to register to them.

### Subscribing to mailing lists

NGIs and Sites have local mailing lists for ROD team members and Site
Administrators respectively. Please ensure that you subscribe to them. Depending
on your role ask your NGI operations manager or Site operations manager to have
you included on the necessary mailing lists if there is no automatic
subscription process.

NGI operations manager should contact operations@egi.eu and state that wish to
be subscribed to noc-managers mailing list `noc-managers@mailman.egi.eu`.

## Documentation

Documentation relevant to EGI operations can also found at
[EGI Documentation wiki page](https://wiki.egi.eu/wiki/Documentation).

## Tools

A list of services relevant to EGI operations can be found at
[the section about internal services](../../../internal).
