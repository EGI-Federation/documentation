---
title: Operations Start Guide
type: docs
---

## Introduction

The Operations Start Guide will help you start with EGI Operations duties. It
covers the responsibilities of the various parties involved in the running of
the [EGI infrastructure](https://ims.egi.eu/display/EGIG/EGI+Infrastructure) and
guide how to join operations. As a newcomer, you need to understand the
structure of the infrastructure and roles of operators at different levels.
Reading the whole document will give you a complete overall picture of daily
operations within EGI.

## Resource Centres and Resource Infrastructures

Resources are geographically distributed and are contributed by
[Resource Centres](https://ims.egi.eu/display/EGIG/Resource+Centre). A Resource
Centre is the smallest resource administration domain within EGI. It can be
either localized or geographically distributed. A Resource Centre is also known
as a _site_. It provides a minimum set of local or remote IT Services, such as
High Throughput Compute (HTC), Cloud Compute, Storage and Data Transfer,
compliant to well-defined IT Capabilities necessary to make resources accessible
to authorised users. Users can access the services using common interfaces.

The EGI Federation is a
[Resource Infrastructure](https://ims.egi.eu/display/EGIG/Resource+Infrastructure)
federating Resource Centres to constitute a homogeneous operational domain, and
the
[Resource Infrastructure Provider](https://ims.egi.eu/display/EGIG/Resource+Infrastructure+Provider)
is the legal organisation that is responsible of establishing, managing and of
operating directly or indirectly the operational services to an agreed level of
quality needed by the Resource Centres and the user community. It holds the
responsibility of integrating them in EGI to enable uniform resource access and
sharing for the benefit of their consuming end-users. Examples of a Resource
infrastructure Provider are the
[European Intergovernmental Research Organisations (EIRO)](https://ims.egi.eu/display/EGIG/European+Intergovernmental+Research+Organisation)
and the [NGIs](https://ims.egi.eu/display/EGIG/NGI).

In Europe, Resource Centres are required to be affiliated to the respective
NGIs, which (a) have a mandate to represent their national users community in
all matters falling within the scope of the EGI Infrastructure, and (b) are the
only organization having the mandate described in (a) for its country and thus
provide a single contact point at the national level.

## Roles

The following sections covers the roles that are commonly involved in the
operations of the EGI Infrastructure. The correspondent
[roles defined in Configuration Database (GOCDB)](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#Roles)
give specific rights in the Configuration Database itself and in other EGI
services. There are roles whose scope is limited to the operation of a RC. A
number of other roles act on a higher level, involving the operations activities
related either to the NGI (Regional level) or to the EGI infrastructure as a
whole (global level). Other terms and definitions can be found in the
[EGI Glossary](https://go.egi.eu/glossary).

### Resource Centre level

#### Resource Centre Administrator

An individual responsible for installing, operating, maintaining and supporting
one or more Resources or IT Services in a Resource Centre. In the scope of
Operations, Resource Centres (RC) administrators primarily receive and react on
incidents at their Resource Centre and on service requests notified through
tickets created on the [EGI Helpdesk service](../../../internal/helpdesk). They
should respond to the tickets in a suitable time frame as defined in the
[Resource Centre Operational Level Agreement (OLA)](https://documents.egi.eu/document/31)
and be aware of the alarms at their site, eg. through the
[Operations Dashboard](https://operations-portal.egi.eu). Sites must only
operate supported middleware versions. This implies upgrading it regularly.
Emergency releases are treated in a special way. Resource Centre Administrators
must react to security issues that are at a global level, but affect their site.
See
[SEC03 EGI-CSIRT Critical Vulnerability Handling](https://wiki.egi.eu/wiki/SEC03_EGI-CSIRT_Critical_Vulnerability_Handling).

#### Resource Centre Operations Manager

An individual who leads the Resource Centre operations, who is the official
technical contact person in the connected organisation, and who is locally
supported by a team of Resource Centre Administrators. The Resource Centre
Operations Manager is responsible for the site at the political and legal levels
and for signing the
[Operational Level Agreement](https://documents.egi.eu/public/ShowDocument?docid=31))
between the Resource Centre and its hosting NGI. The Resource Centre Operations
Manager is also responsible for enforcing the EGI policies and procedures by the
Resource Centre and for assigning and approving the other site roles in the
Configuration Database. Further, they should ensure that administrators are
subscribed to the relevant mailing lists.

#### Resource Centre Security Officer

The person responsible for keeping the site compliant with the
[EGI security policies](https://wiki.egi.eu/wiki/EGI_CSIRT:Policies). They are
the primary contact for the [NGI Security officer](#ngi-security-officer) and
[EGI Computer Security Incident Response Team (CSIRT)](#egi-csirt). The Site
Security Officer deals with security incidents and shall respond to enquiries in
a timely fashion as defined in the collection of
[security procedures and policies](https://wiki.egi.eu/wiki/EGI_CSIRT:Policies).

### Regional level

#### Regional Operator on Duty (ROD)

A team responsible for solving problems and incidents in the infrastructure
according to agreed procedures. ROD teams monitor the Resource Centres in their
region, react to incidents identified by the monitoring tools, and oversee
incidents and related problems through to their resolution. They ensure that
incidents are properly recorded and that the solutions progress according to
specified time lines. They also provide support to Resource Centres and Virtual
Organisations (VOs) and provide support to oversight bodies in cases of
unresponsive Resource Centres. They ensure that all the necessary information is
available to all parties. The team is provided by each NGI and requires
procedural knowledge on the process (rather than technical skills) for their
work. New ROD team members are required to read the
[ROD Welcome page](https://wiki.egi.eu/wiki/Regional_Operator_on_Duty_welcome)
and be familiar with
[ROD wiki page](https://wiki.egi.eu/wiki/Regional_Operator_on_Duty).

#### NGI Security officer

The NGI Security Officer is member of the [EGI-CSIRT](#egi-csirt).

The NGI Security Officer coordinates the security activities within its NGI and
serves as the primary contact for all security related requests, in particular
from [EGI-CSIRT's IRTF](#egi-csirt-s-irtf) concerning issues with the sites
within the NGI.

Further, the NGI Security Officer is responsible for overseeing the security
related aspects of the operations of the NGI and coordinates the security
activities within its NGI.

NGIs and Sites _MUST_ respond in a timely manner to the security requests and
alerts coming from the EGI-CSIRT's IRTF.

The NGI Security Officer name and contact address needs to be registered in the
[Configuration Database (GOCDB)](https://goc.egi.eu) and the information
maintained by the NGI.

#### NGI Operations manager

The NGI Operations manager is the contact point for all operational matters and
represents the NGI within the
[Operations Management Board (OMB)](https://confluence.egi.eu/display/EGIBG/Operations+Management+Board).

They are mainly responsible for:

- keeping up to date the NGI entry in the Configuration Database and managing
  the status of all sites under their NGI, and ensuring their information is
  also kept current
- addressing problems with Site availability or reliability. The reports are
  issued on a monthly basis and the NGI operations managers have 10 days to
  respond to identified problems
- attending regular
  [Operations Management Board meetings](https://indico.egi.eu/category/19/)

All NGI operations management responsibilities are listed in the
[Resource Infrastructure Provider OLA document](https://documents.egi.eu/document/463).

### Global level

#### Chief Operations Officer

The Chief Operations Officer leads EGI Operations, and is responsible for
coordinating the operations of the infrastructure across the project.

#### EGI-CSIRT

[EGI-CSIRT](https://csirt.egi.eu) is the official security coordination team and
contact point at project level.

- [EGI-CSIRT website](https://csirt.egi.eu)
- [EGI-CSIRT profile according to RFC-2350](https://wiki.egi.eu/wiki/EGI_CSIRT:RFC_2350)
- [EGI-CSIRT Terms of References](https://csirt.egi.eu/files/2020/11/EGI-CSIRT-ToR_V2_20190819.pdf)

##### EGI-CSIRT's IRTF

The Incident Response Team for the Federation (IRTF) is a subgroup of EGI-CSIRT
which acts as the primary contact for all security related requests concerning
the Federation and the projects the EGI Foundation is involved in.

EGI-CSIRTs IRTF provides the Security Officer on Duty role on a weekly rota
basis. Details are in the
[EGI-CSIRT Terms of References](https://csirt.egi.eu/files/2020/11/EGI-CSIRT-ToR_V2_20190819.pdf).

#### EGI Security Officer

The EGI Security Officer, having the EGI CSIRT Officer role in the Configuration
Database, is leading and coordinating EGI-CSIRT.

The role of the EGI Security Officer is provided by a member of EGI-CSIRT's IRTF
on a weekly rota basis.

#### EGI Foundation SDIS team

The [EGI Foundation](https://ims.egi.eu/display/EGIG/EGI+Foundation) Service
Delivery and Information Security (SDIS) team, formerly known as the EGI
Operations team, is responsible of
[coordinating and supporting the operational activities](https://confluence.egi.eu/display/EGIPP/EGI+Infrastructure+operations+oversight)
of all the EGI Infrastructure.

#### VO

A
[Virtual Organisation (VO)](https://ims.egi.eu/display/EGIG/Virtual+organisation)
is a group of users and, optionally, resources, often not bound to a single
institution or national borders, who, by reason of their common membership and
in sharing a common goal, are given authority to use a set of resources. Each VO
member signs the VO Acceptable Usage Policy (AUP) (during registration) which is
the policy describing the goals of the VO thereby defining the expected and
acceptable use of the resources by the users of the VO. User documentation can
be found [in the users section](../../../users/) and
[in the EGI Wiki](https://wiki.egi.eu/wiki/User_Documentation).

#### VO manager

An individual responsible for the management of the membership registry of the
VO ensuring its accuracy and integrity.

## Joining operations

In order to join any of the organisational groups in your NGI, you will need to
go through the following steps in order:

### Authentication

In general the authentication in EGI infrastructure works either with X509
personal certificates or through federated identities using
[Check-in](../../check-in). For some services (HTC and Storage) the access is
granted only by using a X509 personal certificate due to legacy reasons: the
process of moving the authentication and authorisation mechanism to federated
identities has started but it will takes time before having everything compliant
with federated identities.

#### Obtaining a X509 personal certificate

If you do not already have a X509 personal certificate
[the EUGridPMA worlmap](https://www.eugridpma.org/members/worldmap/) provides a
map of all certification authorities according to the country (or NGI). Select
your country on the map to find out who is your local CA. Follow the procedure
of your local CA to request a certificate. When you have received your
certificate, install it into your web browser.

If case of setting up a new Resource Centre please request Host certificates.

EUGridPMA provides
[a web page allowing to test your certificate](https://www.eugridpma.org/your-identity/).
Please use this resource and contact your CA if your certificate does not work.

#### Create a federated identity: registration in EGI Check-in

As soon as you try to access an EGI service with your federated identity, you
will be requested to register an account in EGI Check-in if not existing yet.
The [Check-in sign up guide](../../../users/check-in/signup/) explains how to
sign up for an EGI account. If you already own an account, you will be simply
asked to login through EGI Check-in.

### Joining dteam VO

It is recommended to join the [dteam VO](https://wiki.egi.eu/wiki/Dteam_vo) at
the [dteam Registration](https://voms2.hellasgrid.gr:8443/voms/dteam/) page. You
should request group membership for `/dteam` and `/dteam/YOUR_NGI`. The dteam
group manager will then be notified and review your application. The membership
to dteam VO is possible only by using a X09 personal certificate and it is
useful to test the RCs and to debug related issues.

### Requesting GOCDB access

- Read
  [Input System User Documentation](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation)
  first.
- Go to the [Configuration Database](https://goc.egi.eu/) and follow
  [the instruction](https://wiki.egi.eu/wiki/GOCDB/Input_System_User_Documentation#Users_and_roles)

All members **should notify their NGI operations manager** about their role
requests, to be sure they are considered on time.

### Registering into GGUS

To register into GGUS please follow the
[Central GGUS registration](https://ggus.eu/?mode=register) link. GGUS can be
accessed either with your X509 personal certificate or with your federated
identity. Do not forget to apply for
[the support role](https://ggus.eu/?mode=register) as well. (The GGUS support
staff will approve you quickly as they get the notification automatically). To
get the supporter role with your federated identity, please enroll to the
[GGUS Supporters group](https://aai.egi.eu/registry/co_petitions/start/coef:69)
in Check-in.

If your NGI also have a local helpdesk interfaced with GGUS, please ensure that
you are properly registered also there: your NGI managers will take care of
that.

### Subscribing to mailing lists

NGIs and Sites have local mailing lists for ROD team members and Site
Administrators respectively. Please ensure that you subscribe to them. Depending
on your role ask your NGI operations manager or Site operations manager to have
you included on the necessary mailing lists if there is no automatic
subscription process.

NGI operations manager should contact `operations@egi.eu` and state that wish to
be subscribed to noc-managers mailing list `noc-managers@mailman.egi.eu`.

## Documentation

Procedures and policies are accessible on the
[EGI Policies and Procedures space](https://confluence.egi.eu/display/EGIPP/EGI+Federation+Procedures).
Additional documentation relevant to EGI operations is available at
[EGI Documentation wiki page](https://wiki.egi.eu/wiki/Documentation).

## Tools

A list of services relevant to EGI operations can be found at
[the section about internal services](../../../internal).
