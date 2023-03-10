---
title: Service groups
description: "Understanding and manipulating service groups"
weight: 30
type: "docs"
---

## Service Groups

A service group is an arbitrary grouping of existing service endpoints that can
be distributed across different physical sites and users that belong to the SG
(SGs were previously known as 'Virtual Sites'):

- Each service that appears in a group **must already exist and be hosted by a
  physical site**.
- A service group role does **not extend any permissions** over its child
  services. This means that you cannot declare a downtime on the services that
  you group together or modify the service attributes.
- Any GOCDB user can create their own service group and as the 'Service Group
  Administrator' you can control subsequent user membership requests to the SG
  (everything is logged, including who created the service group).
- GOCDB users can request to join an existing service group by finding the
  target SG and requesting a role on that SG.
- Service groups are typically used for monitoring a particular collection of
  services and/or users using the GOCDB 'get_service_group' and
  'get_service_group_role' PI methods.
- SG members can be listed using the get_service_group_role PI method.
- PI doc:
  - [get_service_group](https://wiki.egi.eu/wiki/GOCDB/PI/get_service_group)(link
    to old EGI Wiki)
  - [get_service_group_role](https://wiki.egi.eu/wiki/GOCDB/PI/get_service_group_role)(link
    to old EGI Wiki)
- If you have any further use-cases or suggestions, please submit a GGUS ticket.
