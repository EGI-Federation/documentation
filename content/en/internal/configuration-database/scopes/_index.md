---
title: Data visibility / Scopes
description: "Understanding and manipulating roles"
weight: 30
type: "docs"
---

## Introduction

- Scope tags are used to group entities such as `Sites`, `Services` and
  `ServiceGroups` into flexible categories. A single entity can define multiple
  scope tags, allowing the resource to be associated with different categories
  without duplication of information. This is essential to maintain the
  integrity of topology information across different infrastructures and
  projects.
- The Configuration Database admins control which scope tags are made available
  to avoid proliferation of tags (user defined tags are reserved for the
  extensibility mechanism).
- As an example, a site’s scope list could aggregate all of the scopes defined
  by its child services. In doing this, the site scope list becomes a union of
  its service scopes plus any other site specific tags defined by the site.
- By defining scope tags, resources can be ‘filtered-by-scope-tag’ when querying
  for data in the PI using the ‘scope’ and ‘scope_match’ parameters, see
  [GOCDB Programmatic Interface (GOCDB-PI)](https://wiki.egi.eu/wiki/GOCDB/PI/Technical_Documentation)(link
  to old EGI Wiki) for details.

## Clear Separation of Concerns

It is important to understand that scopes and Projects are distinct:

- Projects are used to cascade roles and permissions over child objects
- Scope tags are used to filter resources into flexible categories/groupings
- Scope tags can be created to mirror the projects. For example, assuming two
  projects (e.g. EGI.eu and EUDAT), two corresponding tags may be defined.
- In addition, it is also possible define additional scopes for finer grained
  resource filtering e.g. ‘SubGroupX’ and ‘EGI_TEST’.
- The key benefit: A clear separation of concerns between cascading permissions
  and resource filtering.

## EGI Scopes

- To make a `Site`, `Service` or `ServiceGroup` visible to EGI, the resource's
  'EGI' scope tag checkbox must be ticked. EGI scoped resources are exposed to
  the central operational tools for monitoring and will appear in the central
  operations portal.
- **Un-ticking the EGI checkbox** and selecting the 'Local' scope makes the
  selected object invisible to EGI; it will be hidden from the central operation
  tools (it will not show in the central dashboard and it will not be monitored
  centrally). This can be useful if you wish to hide certain parts of your
  infrastructure from EGI but still have the information stored and accessed
  from the same Configuration Database instance.
- A use-case for non-EGI sites/services is to hide those entities from central
  EGI tools, but to include those sites/services for use by regional versions of
  the operational tools (such as regional monitoring).
- Note that exposing a site / service endpoint as EGI does not override the
  production status or certification status fields. For example if a site isn't
  marked as production it won't be monitored centrally even if it's marked as
  visible to EGI.
- You can submit your request for new scope tags via
  [EGI Helpdesk](../../helpdesk) to the "Configuration and Topology Database
  (GOCDB)" support unit.

## Reserved Scope Tags

- Some tags may be 'Reserved' which means they are protected - they are used to
  restrict tag usage and prevent non-authorised sites/services from using tags
  not intended for them.
- Reserved tags are initially assigned to resources by the Configuration
  Database admins, and can then be optionally inherited by child resources (tags
  can be initially assigned to NGIs, Sites, Services and ServiceGroups).
- When creating a new child resource (e.g. a child Site or child Service), the
  scopes that are assigned to the parent are automatically inherited and
  assigned to the child.
- Reserved tags assigned to a resource are optional and can be de-selected if
  required.
- Users can reapply Reserved tags to a resource ONLY if the tag can be inherited
  from the parent Scoped Entity (parents include NGIs/Sites).
  - For Sites: If a Reserved tag is removed from a Site, then the same tag is
    also removed from all the child Services - a Service can't have a reserved
    tag that is not supported by its parent Site.
  - For NGIs: If a Reserved tag is removed from an NGI, then the same tag is NOT
    removed from all the child Sites - this is intentionally different from the
    `Site`->`Service` relationship.
- To request a reserved scope tag, **an approval is required from the operators
  of the relevant resources**. Details on who to contact are listed below. Once
  authorisation is given, please contact the Configuration Database admins with
  details of the approval (e.g. link to an [EGI Helpdesk](../../helpdesk) ticket
  that approves the tag assignment).

### FedCloud Reserved Tag

- Tag for resources that contribute to the EGI Federated Cloud. To request this
  tag, please contact the FedCloud operators / EGI Operations.

### Elixir Reserved Tag

- Tag for resources that contribute to the EGI Federated Cloud. To request this
  tag, please contact the operators of the ‘ELIXIR’ NGI in the EGI Configuration
  Database.

### WLCG Reserved Tags

- A number of reserved scope tags have been defined for the WLCG:
  - The ‘tierN’ tags should be requested for WLCG sites that are defined in
    REBUS (a management view of the WLCG infrastructure/sites). To request a
    ‘tierN’ tag, raise a ticket against the REBUS support unit in GGUS.
  - For the experiment VO tags (alice, atlas, cms, lhcb), raise a ticket with
    the relevant VO support unit.
  - The wlcg tag is a generic catch-all tag for sites/services with either tierN
    and VO tags and is used to gain an overall view of the WLCG infrastructure.

### SLA Reserved Tag

- Entities covered by an EGI VO SLA
  - This Tag will only be applied at the request of EGI operations

### EOSCCore Tag

- Tag for resources that contribute to core services of the EOSC. To request
  this tag, please raise an [EGI Helpdesk](../../helpdesk) ticket against the
  Operations SU.

### EGICore Tag

Tag for resources that are part of the EGI Core services. To request this tag,
please raise an [EGI Helpdesk](../../helpdesk) ticket against the Operations SU.
