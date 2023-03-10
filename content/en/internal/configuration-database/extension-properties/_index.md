---
title: "Extension Properties"
weight: 30
type: "docs"
description: >
  Extension Properties
---

## Introduction

- Sites, Services, service endpoints, and Service Groups can be extended by
  adding custom key-value pairs (this follows the GLUE2 extensibility
  mechanism).
- Extension properties address a number of use cases, such as filtering Sites
  and/or Services that define particular properties.
- Selected methods in the Configuration Database API support the 'extensions'
  URL parameter. This parameter is used to filter resources according to the
  extensions they define (described below).
- Properties are rendered in the XML results of the Site/Service/ServiceGroup
  using the "EXTENSIONS" XML element, for an example see a
  [sample output from get_service_endpoint](https://wiki.egi.eu/wiki/GOCDB/PI/get_service_endpoint_method)(link
  to old EGI Wiki)
- Note, anyone with permissions over the target entity can add extension
  properties to that object.
- This allows 'Folksonomy' building: 'a user-generated system of classifying and
  organizing content into different categories by the use of metadata such as
  electronic tags'
- A number of use cases can be addressed; e.g. filtering Sites that support a
  specific property, e.g. ‘P4U_Pilot_Cloud_Wall’
- Key-value pairs prevent certain characters from being used in their values.
  This includes the equals and opening/closing parenthesis chars ‘=()’. This is
  to simplify lexical parsing of the query. In addition, to guard against
  cross-site scripting attacks, the quote, double quote, semi-colon and back
  tick chars are also not allowed.
- Keys must be unique for a given site, service, or service endpoint, or service
  group.

### Extension Properties in the PI

- Selected PI methods allow results to be filtered by extension properties via
  the 'extensions' PI parameter.
- Supported methods include: get_site, get_site_list, get_service_endpoints and
  get_service_group, get_downtime, get_downtime_nested, get_site_list.
- For individual method support please refer to the PI documentation:
  [GOCDB/PI/Technical Documentation](https://wiki.egi.eu/wiki/GOCDB/PI/Technical_Documentation)
  (link to old EGI Wiki)
- The format of the 'extensions' PI parameter is one or more (key=value) pairs
  enclosed in brackets.
  - The value part of a (k=v) pair can be omitted if filtering by value is not
    required (i.e. '(somekey=)' means select all resources that define the
    'somekey' property with any value.
  - (k=v) pairs can be optionally prefixed with one of following operators: AND,
    OR, NOT.
  - If no operator is specified before the FIRST (k=v) pair, then AND is
    assumed.
  - A single operator applies to ALL the (k=v) pairs to the right of the
    operator until another operator is encountered.
  - An AND forms a logical conjunction with any previously specified conditions.
  - An OR forms a logical disjunction with any previously specified conditions.
  - A NOT forms a logical conjunction with any previously specified conditions
    (it can be read as 'AND NOT')
  - Because an OR always forms a logical disjunction with any previously
    specified conditions, you can’t OR against a group occurring to the right
    that contains multiple k=v pairs e.g. the following is not supported (if
    there is sufficient demand, it could be considered for a future
    enhancement): - ((k=v1)AND(k=v2)) OR ((k=v3)AND(k=v4))

Examples:

- Eg (note no leading AND):
  - (key1=val)(key2=va2)OR(key3=val3)(key4=val4)NOT(key5=val5)(key6=val6) is
    expanded to:
  - AND(key1=val)AND(key2=va2)OR(key3=val3)OR(key4=val4)NOT(key5=val5)NOT(key6=val6)
    which is interpreted as:
  - (((key1=val)AND(key2=va2))OR(key3=val3)) OR(key4=val4) NOT(key5=val5)
    NOT(key6=val6)
- Eg:
  - (VObing=true)AND(VObaz=true)AND(VObar=true)OR(s1p1=v1) is equal to:
  - ((VObing=true)AND(VObaz=true)AND(VObar=true))OR(s1p1=v1)
- Eg:
  - (VO=food)OR(VO2=bar)AND(s4p1=v1) is equal to:
  - ((VO=food)OR(VO2=bar))AND(s4p1=v1)
- Eg:
  - (VO=food)(s4p1=v1)OR(VObar=true)(VObaz=true) is equal to:
  - ((VO=food)AND(s4p1=v1))OR(VObar=true)OR(VObaz=true)
- Eg:
  - (VO=food)(s4p1=v1)OR(VObaz=true)AND(VObling=true) is equal to:
  - (((VO=food)AND(s4p1=v1))OR(VObaz=true))AND(VObling=true)

To return all sites that define VO with a value of Alice:

```markdown
?method=get_site&extensions=(VO=Alice)
```

Use no value to define a wildcard search, i.e. all sites that define the VO
property regardless of value:

```markdown
?method=get_site&extensions=(VO=)
```

NOTE: From version 5.7 (Autumn/Winter 2016) keys must be unique for a given
site, service, or service endpoint, or service group. The following section of
documentation has not yet been changed to reflect this.

Extensions also supports OR/AND/NOT operators. This can be used to search
against multiple key values eg:

```markdown
?method=get_site&extensions=AND(VO=Alice)(VO=Atlas)(VO=LHCB)
```

These can be used together:

```markdown
?method=get_site&extensions=AND(VO=Alice)(VO=Atlas)NOT(VO=LHCB)
```

```markdown
?method= get_service_endpoint&extensions=(CPU_HS01_HOUR=1)OR(CPU_HS02_HOUR=2)
```

When no operator is specified the default is AND, therefore the following:

```markdown
?method= get_service_endpoint&extensions=(CPU_HS01_HOUR=1)(CPU_HS02_HOUR=2)
```

Is the same as:

```markdown
?method= get_service_endpoint&extensions=AND(CPU_HS01_HOUR=1)(CPU_HS02_HOUR=2)
```

The extensions parameter can also be used in conjunction with the existing
parameters previously supported:

```markdown
?method=get_site&extensions=(VO=Alice)NOT(VO=LHCB)&scope=EGI&roc=NGI_UK
```

The _site_extensions_ and _service_extensions_ can also be used on the
_get_downtime_ and _get_downtime_nested_services_ methods using same logic
described above. Note, the _EXTENSIONS_ element is not rendered in the XML
output for these queries.

```markdown
?method=get_downtime_nested_services&site_extensions=(eg.2=val.2)&service_extensions=(eg.2=)
```

```markdown
?method=get_downtime&site_extensions=(eg.2=val.2)&service_extensions=(eg.2=)
```

### Standard Extension Properties

#### HostDN

For EGI Services, the Standard Extension property "HostDN" has been defined to
allow the fetching the DNs of multiple hosts behind a load balanced service from
the endpoint properties of a single GOCDB Service, rather than creating multiple
GOCDB Services with different host DNs.

#### Recommended Use

To supply multiple or alternate DN(s) for a service, for example of the multiple
hosts supporting a single service entry, the Service Extension Property
(hereafter Ext) "HostDN" SHOULD be used. If Ext "HostDN" is present it MUST
contain one or more x.509 DN values. Multiple values MUST be delimited by
enclosing each within "<>" characters. If Ext "HostDN" is present, the Service
"Host DN" SHOULD contain the x.509 SubjectAltName used in the X509
certificate(s) presented by the hosts identified by the Ext "HostDN" values.
