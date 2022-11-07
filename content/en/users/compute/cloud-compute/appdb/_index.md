---
title: AppDB REST API v1.0
linkTitle: AppDB REST API
type: docs
weight: 90
description: >
  AppDB Rest API documentation
---

This document is intended for developers who want to write applications that
interact with the AppDB API over the web using HTTP commands following the
[REST](http://en.wikipedia.org/wiki/Representational_state_transfer) paradigm.
The API endpoint is located at `http://appdb-pi.egi.eu` and it allows
information retrieval and modification from third party applications without
having to reside on the rich user interface of the AppDB portal. Thus one is
given the opportunity to design one's own frontends.

## Getting started

### Operations

Starting with version 1.0, the AppDB API features write access as well, by
supporting HTTP verbs such as `PUT`, `POST`, and `DELETE`. Verb mappings to data
operations follow a
[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) convention,
as depicted in the following table:

| Operation | HTTP Verb |
| --------- | --------- |
| Create    | `PUT`     |
| Read      | `GET`     |
| Update    | `POST`    |
| Delete    | `DELETE`  |

The API also supports the Listing operation
([CRUDL](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
extension), by passing the parameter listmode=listing in the querystring when
performing a `GET` request. Please note that in order to simplify the access
model, Update operations are always partial, meaning that properties of the
resource that is being updated which are entirely missing from the
representation, are ignored (i.e. their state in the backend does not change).
Therefore, in order to unset/remove a property, one has to explicitly specify it
as `NULL`, provided that this is permitted. This is the reason why Create and
Update [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
mappings are inverted with regards to what is usually accustomed. Finally, the
API also supports the `OPTIONS` HTTP verb, which returns a list of the
operations that are permitted, in principle, for the resource in question. The
base URI for this version of the RESTful API is

`http://appdb-pi.egi.eu/rest/1.0/`

and requests must be followed by at least one resource name, which may be
followed by one or more optional sub-resource names, separated by slashes, as in
the examples given bellow:

- `http://appdb-pi.egi.eu/rest/1.0/applications/`
- `http://appdb-pi.egi.eu/rest/1.0/applications/50/`

### Response types

Because the API conforms to the REST paradigm, responses to all
[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations
are always [XML](http://en.wikipedia.org/wiki/XML) document representations of
the resource in question. These documents are described by schema files which
reside publicly in the web server. All the XML documents are enveloped in a
common root element named `appdb` with attributes that describe request status,
such as paging, or errors. These attributes are:

- `count` (number) : the count of the entries found in the applications
  database. In case of paging, where only a subset of the results gets returned,
  the attribute is left unaffected.
- `pagelength`, `pageoffset` (numbers) : paging data in case the response is a
  list of resources. More information follows in the next section.
- `datatype` (string) : an identifier for the resource data that is enclosed in
  the response as defined in the XML schema.
- `type` (string) : the type of the response. Possible values are:
  - `list`: A collection of references to entries in the applications' database.
    In order to obtain the referenced entry, a request should be made using the
    entry's ID.
  - `entry`: Detailed information about an entry in the applications' database.
    Paging is never used for this type of response.
- `version` (number) : The version of the API that was accessed.
- `error` (string) : If an error occurs, this attribute will contain the error
  message.
- `errornum` (number) : If an error occurs, this attribute will contain the
  error number.
- `errordesc` (string) : If an error occurs, this attribute might contain a more
  detailed description about the error.
- `host`, `apihost` (strings) : the URIs of the host that provided the data and
  API access, respectively.

### Paging and Filtering

The paging mechanism that the API provides, as far as Read/Listing operations
are concerned, can be used through two query parameters (if allowed) and can be
displayed in the attributes of the root element of the response XML document.
The query parameters are:

- `pagelength`: defines the count of entries to be displayed in each page.
- `pageoffset`: defines the position in the list of entries from which the page
  will start.

So if the client wants a list of 50 entries and wants to display the first 10,
then the parameters should be set as page length=10 and page offset=0. To view
the next 10 entries it should change the page offset to 10, for the next 10, it
should set page length to 20, etc. One must remember that paging is not valid
for all resources, as documented in the query parameters section in the API
reference. A final note about paging is that if the client hasn't explicitly
enable paging, then the server will default to a preset paging value, in order
to reduce load; this value can be retrieved from the relevant attributes of the
response’s root node. If the paging parameters were set by the client but the
page length exceeds that of the server's default maximum value, then the later
is used. Otherwise the page length set by the client will be used. Moreover,
some of the API resources support filtering when doing Read/Listing operations;
filter expressions may be passed in the querystring by assigning a value to the
flt parameter, in order to retrieve just the subset of data that match certain
criteria. These filter expressions are strings that may range from simple
keywords to complex queries. They are search arguments which will be matched to
results that are deemed relevant in the scope of the search target. These
expressions can range from the simple and obvious space separated keyword list,
to complex operator and field specific queries. In particular, filter
expressions are composed of one or more keywords, optionally prefixed by
operators and/or specifiers. The syntax in BNF is:

```BNF
<expression> ::= <keyword>*
<keyword> ::= [<operator>][<specifier>:]some_string
<operator> ::= [<context_operator>]<comparison_operator>
<context_operator> ::= &
<comparison_operator> ::= = | * | ~ | $ | <[=] | >[=] | +[=|*|~|$|<[=]|>[=]] | -[=|*|~|$|<[=]|>[=]]
<specifier> ::= <related_entity>[.property_name] | property_name
<related_entity> ::= application | person | vo | middleware | country | [sub]discipline
```

Rules are as follow:

- Each keyword without an operator may partially match any property related to
  the filtered entity.
- If a keyword is prefixed with the `=` operator, then the keyword may exactly
  match any related property.
- If a keyword is prefixed with the `*` operator, then any part of a
  comma-separated set of keywords may exactly match any related property.

  Please note that in this case, the keyword `NULL` takes on the special meaning
  of a nil value

- If a keyword is prefixed with the `<` or `>` comparison operator, then the
  keyword may be greater than or lesser than any related property, respectively.

  Optionally prefixing the `=` operator as well, will make the comparison
  operator non-strict.

- If a keyword is prefixed with the `~` operator, then the keyword will be
  treated as a regular expression which may match any related property.
- If a keyword is prefixed with the `$` operator, then the keyword will be
  treated as a soundex phonem which may match any related property that sounds
  alike in the english language.
- If a keyword is prefixed with the `+` operator, then the keyword must match
  any related property.
- If a keyword is prefixed with the `-` operator, then the keyword must not
  match any related property.
- If a specifier is present, then the keyword applies only to the specified
  property.
- Specifiers refering to related entities may omit the property name, in which
  case the special property any will be implicit.
- In keywords without specifiers, the special specifier any.any will be
  implicit.
- The `&` context operator makes an entity's context private when present; this
  reduces results to the immediate neighborhoud of the target.

Consider the following examples when searching for software:

- ```plain
  cms atlas
  ```

  will return a software item named `CMSSW`, another named `ATLAS`, another
  belonging to the `atlas` VO, etc.

- ```plain
  cms atlas +greece
  ```

  will return only the subset of the previous example's results that actually
  mention Greece (e.g. in the description, or by having a researcher from Greece
  in their contact list, etc.)

- ```plain
  cms atlas -greece
  ```

  will return only the subset of the first example's results that do not mention
  Greece

- ```plain
  vo:biomed
  ```

  will return software that belong to the VO's that contain biomed in their name
  or description

- ```plain
  =vo.name:biomed
  ```

  will return software that belong to the VO named `biomed` only

- ```plain
  <dateadded:2011
  ```

  will return software that have been registered before the year 2011

- ```plain
  >=name:x
  ```

  will return software whose names begin with `x`,`y`, or `z`

- ```plain
  person:"john doe"
  ```

  will return software that has someone whose name contains `john doe` listed as
  a contact

- ```plain
  discipline:physics +tag:portal
  ```

  will return software that are filed under disciplines that are related to
  physics, and that are tagged as portals

For a list of possible specifiers, you can look up the `/filter/reflect`
subresource of any searchable resource (e.g. `/applications/filter/reflect`), or
you can also try using any search box in the [portal](http://appdb.egi.eu), and
check out the autocompletion list.

### Authenticated Access

Some or all operations on certain resources may require authentication, as
indicated in the API Reference section below. In order to perform authenticated
API calls, users need to create an access token and provide the following
parameters in the query string, or POST fields accordingly:

- `accesstoken`: a valid access token. Registered users can generate access
  tokens from within the AppDB portal, under their profile preferences tab

Access tokens may be assigned netfilters, which will only allow authenticated
access from specific sources. Defining netfilters for an access token is not
required, but it is strongly suggested, since they can help safeguard its use.

## API Reference

Below you may find an exhaustive list of the resources v1.0 of the AppDB RESTful
API offers. Details and documentation about a resource's representation may be
found as [XSD](http://en.wikipedia.org/wiki/XSD) annotations inside the
appropriate schema file, under
[the schemata base resource](http://appdb-pi.egi.eu/rest/1.0/schema). Note that
when performing `POST` operations, the representation must be passed as a
URL-encoded string in the query-string under the parameter `data`, whereas when
performing `PUT` operations, the representation must be passed as a normal text
stream. Representations passed to `PUT`/`POST` operations must be enclosed
within an `appdb:appdb` root element, with the appropriate
[XML](http://en.wikipedia.org/wiki/XML) namespaces declared, the same way that
responses are; nevertheless, this will be omitted in all following examples, in
order to reduce clutter. Also note that since all Update (`POST`) operations are
partial, [XML](http://en.wikipedia.org/wiki/XML) elements that represent
properties with a cardinality 0..\* must be either

- omitted, in which case the present state in the backend is left untouched,
- fully disclosed, in which case entities present in the backend but absent from
  the POSTed representation are deleted, and vice versa
- explicitly declared NULL by passing a single instance of the element, with no
  node value (is of _mixed_ type) and the single attribute `xsi:nil` with value
  `true`, in which case all instances of the entity are erased from the backend.

This way, it is possible to perform modifications to a resource's properties
without having to re-declare all instances of other properties with 0..\*
cardinality, lest they were to be erased. Properties of 0..1 cardinality may
also be declared `NULL` in a similar fasion, in which case their value in the
backed becomes undefined. Moreover, one should also note that the response of
all `PUT`/`POST`/`DELETE` operations equivalent to that of a `GET` operation,
with the state of the resource

- after the operation, in case of `PUT`/`POST`
- before the operation, in case of `DELETE`

This way, it is possible - as well as advised - to differentiate the response
with the input to such operations, in order to verify that the result is what
was intended, since properties that are malformed or invalid will not break the
operation, but rather be ignored, as long as the representation is well-formed
(i.e. passes the [XSD](http://en.wikipedia.org/wiki/XSD) compilation).

### Application List

- Resource: `applications/`
- Type: list
- Datatype: application
- Schema: application
- Filtering: yes
- Public Operations: `GET`
- Authenticated Operations: `PUT` `POST`

List of all application entries registered in the database

Examples:

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/applications?flt=metatype:0
  ```

  will return all applications that are listed under the Software Marketplace
  (i.e. Software)

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/applications?flt=metatype:1
  ```

  will return all applications that are listed under the Cloud Marketplace (i.e.
  Virtual Appliances)

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/applications?flt=country:Greece
  ```

  will return all applications that are related to Greece

- ```plain
  POST https://appdb-pi.egi.eu/rest/1.0/applications?data={data}&username={username}&passwd={passwd}&apikey={apikey}
  ```

  where `{data}` is

  ```xml
  <application:application id="123">
    <application:description>some new description</application:description>
  </application:application>
  ```

  will update application with ID `123` setting it description to
  `"some new description"` and leaving all other properties as-is.

  Similarly, providing

  ```xml
  <application:application id="123">
    <discipline:subdiscipline xsi:nil="true" />
  </application:application>
  ```

  as `{data}` will remove all subdiscipline associations from the application,
  and providing

  ```xml
  <application:application id="123">
    <discipline:discipline id="1"/>
    <discipline:discipline id="5"/>
  </application:application>
  ```

  will replace the list of associated disciplines of the application with ID
  `123`, with the disciplines with IDs `1` and `5` ("Life Sciences" and "Earth
  Sciences" respectively)

  Note that providing `{data}` as

  ```xml
  <application:application id="123">
    <discipline:discipline xsi:nil="true" />
  </application:application>
  ```

  to a `POST` operation will result in an error, since discipline elements are
  not defined as nillable in the schemata, meaning that all application entries
  must have at least on discipline in their complete representation.

- ```plain
  echo {data} | PUT https://appdb-pi.egi.eu/rest/1.0/applications?username={username}&passwd={passwd}&apikey={apikey}
  ```

  with `{data}` defined as

  ```xml
  <application:application tagPolicy="0">
    <application:name>MyGridApp</application:name>
    <application:description>my grid application</application:description>
    <application:abstract/>this is a grid application which performs task X</application:abstract>
    <application:category id="1" primary="true"/>
    <application:category id="2" primary="false"/>
    <discipline:discipline id="1"/>
    <application:status id="6"/>
    <vo:vo id="951"/>
    <application:contact id="189"/>
    <application:contact id="190"/>
    <publication:publication >
       <publication:title>Evidence of Y using novel method X</publication:title>
       <publication:url>http://linkto.my.pub</publication:url>
       <publication:conference>X developments 2012</publication:conference>
       <publication:proceedings/>
       <publication:isbn>ISSN 0000-0000</publication:isbn>
       <publication:startPage>592</publication:startPage>
       <publication:endPage>597</publication:endPage>
       <publication:volume>18</publication:volume>
       <publication:publisher/>
       <publication:journal/>
       <publication:year>2012</publication:year>
       <publication:type id="1">Full Paper</publication:type>
       <publication:author main="true" type="internal">
         <person:person id="189"/>
       </publication:author>
       <publication:author type="external">
         <publication:extAuthor>John Doe</publication:extAuthor>
       </publication:author>
    </publication:publication>
    <middleware:middleware id="1">gLite</middleware:middleware>
    <middleware:middleware id="5">MyGrid</middleware:middleware>
    <application:tag>methodX</application:tag>
    <application:tag>countryZ</application:tag>
  </application:application>
  ```

  will add a new application to the database, with the following properties:

  - belonging to two categories, of which the one with ID equal to 1 will be the
    primary
  - related to one discipline
  - with an application status with ID 6
  - listed as supported by the VO with ID 951
  - having two people in its scientific contact list, those with IDs 189 and 190
  - having one publication with two authors, one internal (i.e. registered with
    the AppDB) and one external (not registered, name-only entry)
  - listed as supported by two middlewares, and
  - with two tags applied

### Application Entry

- Resource: `applications/{id}`
- Type: entry
- Datatype: application
- Schema: application
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: `DELETE`

Detailed description of a specific application entry

### Moderated Application List

- Resource: `applications/moderated`
- Type: list
- Datatype: application
- Schema: application
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET` `PUT`

List of applications that have been moderated some some particular reason, and
thus hidden from public view until the issue gets resolved. Administrative
access only.

Examples:

- ```plain
  echo {data} | PUT https://appdb-pi.egi.eu/rest/1.0/applications/moderated?username={username}&passwd={passwd}&apikey={apikey}
  ```

  where `{data}` is

  ```xml
  <application:application id="123">
     <application:moderationReason>copyright violation</application:moderationReason>
  </application:application>
  ```

  will moderate the application with ID `123`, providing `"copyright violation"`
  as the reason

### Application Publication List

- Resource: `applications/{id}/publications`
- Type: list
- Datatype: publication
- Schema: publication
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: `PUT` `POST`

List of scientific publications related to an application entry. Publications
can be individually managed from this resource (and its sub-resources), or
collectively defined directly from `application/{id}` resources

### Application Publication Entry

- Resource: `applications/{id}/publications/{id}`
- Type: entry
- Datatype: publication
- Schema: publication
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: `DELETE`

Detailed description of a publication related to an application entry

### Application Tag List

- Resource: `applications/{id}/tags`
- Type: list
- Datatype: tag
- Schema: application
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: `PUT`

List of tags applied to an application entry. Tags can be individually managed
from this resource (and its sub-resources), or collectively defined directly
from `application/{id}` resources

Examples:

- ```plain
  echo {data} | PUT https://appdb-pi.egi.eu/rest/1.0/applications/123/tags?username={username}&passwd={passwd}&apikey={apikey}
  ```

  where `{data}` is

  ```xml
  <application:tag>C++</application:tag>
  ```

  will apply the tag `C++` to the application with ID `123`

### Application Tag Entry

- Resource: `applications/{id}/tags/{id}`
- Type: entry
- Datatype: tag
- Schema: application
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: `DELETE`

Detailed description of a tag applied to an application

### Related Application List

- Resource: `applications/{id}/relatedapps`
- Type: list
- Datatype: relatedapp
- Schema: application
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of applications related to an application entry

### Application Rating Report

- Resource: `applications/{id}/ratingsreport`
- Type: entry
- Datatype: ratingreport
- Schema: appratingreport
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Report on all user ratings of an application entry

### External Application Rating Report

- Resource: `applications/{id}/ratingsreport/internal`
- Type: entry
- Datatype: ratingreport
- Schema: appratingreport
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Report on user ratings of an application entry made by registered users

### Internal Application Rating Report

- Resource: `applications/{id}/ratingsreport/external`
- Type: entry
- Datatype: ratingreport
- Schema: appratingreport
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Report on user ratings of an application entry made by anonymous users

### Application Rating List

- Resource: `applications/{id}/ratings`
- Type: list
- Datatype: rating
- Schema: apprating
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of user rating entries applied to an application entry

### Application Rating Entry

- Resource: `applications/{id}/ratings/{id}`
- Type: entry
- Datatype: rating
- Schema: application
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Detailed description of a rating entry applied to an application entry

### Application State History List

- Resource: `applications/{id}/history`
- Type: list
- Datatype: history
- Schema: history
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET`

List of previous states of an application entry. Administrative access only.

### Application State History Entry

- Resource: `applications/{id}/history/{id}`
- Type: entry
- Datatype: history
- Schema: history
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET`

Detailed description of a previous state of an application entry. Administrative
access only.

### Bookmarked Application List

- Resource: `people/{id}/applications/bookmarked`
- Type: list
- Datatype: application
- Schema: application
- Filtering: yes
- Public Operations: none
- Authenticated Operations: `GET` `PUT`

List of application entries bookmarked by a user

Examples:

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/people/123/applications/bookmarked?flt=discipline:chemistry
  ```

  will return all application entries with a discipline related to chemistry and
  which have been bookmarked by the user with ID `123`

### Bookmarked Application Entry

- Resource: `people/{id}/applications/bookmarked/{id}`
- Type: entry
- Datatype: application
- Schema: application
- Filtering: N/A
- Public Operations: none
- Authenticated Operations: `DELETE`

Detailed description of an application entry bookmarked by a user

Examples:

- ```plain
  DELETE https://appdb-pi.egi.eu/rest/1.0/people/123/applications/bookmarked/111?username={username}&passwd={passwd}&apikey={apikey}
  ```

  will delete the application with ID `111` from the list of bookmarked
  applications of the user with ID `123`

### Editable Application List

- Resource: `people/{id}/applications/editable`
- Type: list
- Datatype: application
- Schema: application
- Filtering: yes
- Public Operations: none
- Authenticated Operations: `GET`

List of application entries that a user has permission to edit

### Owned Application List

- Resource: `people/{id}/applications/owned`
- Type: list
- Datatype: application
- Schema: application
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET`

List of application entries that a user holds ownership of

### Associated Application List

- Resource: `people/{id}/applications/associated`
- Type: list
- Datatype: application
- Schema: application
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET`

List of application entries that a user is associated to, as a member of the
application's contact list

### People List

- Resource: `people/`
- Type: list
- Datatype: person
- Schema: person
- Filtering: yes
- Public Operations: `GET`
- Authenticated Operations: `PUT` `POST`

List of users (people) that have registered with the database

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/people/?flt={flt}
  ```

  where `{flt}` is the URL-encoded representation of
  `>=registeredon:2012-02 +=vo.name:SEE -country:Greece`

  will return a list of all people who have registered after or in Feb 2012,
  have a relation to the VO named `SEE` and that are not related with Greece

### Person Entry

- Resource: `people/{id}`
- Type: entry
- Datatype: person
- Schema: person
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: `DELETE`

Detailed description of a user entry

### Regional Information List

- Resource: `regional/`
- Type: list
- Datatype: regional
- Schema: regional
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of countries, regions, and service providers participating in EGI and
available to application and user entries

### Application Category List

- Resource: `applications/categories/`
- Type: list
- Datatype: category
- Schema: application
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of category types available for application entries

### Discipline/Subdiscipline List

- Resource: `disciplines/`
- Type: list
- Datatype: discipline
- Schema: discipline
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of discipline and subdiscipline types available for application entries

### Middleware List

- Resource: `middlewares/`
- Type: list
- Datatype: middleware
- Schema: middleware
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of grid middlewares supported by application entries and VOs

### Application Status List

- Resource: `applications/statuses/`
- Type: list
- Datatype: status
- Schema: application
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of status states available to application entries

### VO List

- Resource: `vos/`
- Type: list
- Datatype: vo
- Schema: vo
- Filtering: yes
- Public Operations: `GET`
- Authenticated Operations: none

List of VOs registered with the
[EGI Operations Portal](https://operations-portal.egi.eu/vo/a/list) and
available to application entries

- ```plain
  GET http://appdb-pi.egi.eu/rest/1.0/vos/?flt={flt}
  ```

  where `{flt}` is the URL-encoded representation of
  `application:CMS +description:CERN`

  will return the list of VOs that contain the word CERN in their description,
  and that are related to any application that mentions CMS in any of its
  properties

### VO Entry

- Resource: `vos/{id}`
- Type: entry
- Datatype: vo
- Schema: vo
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Detailed description of a VO registered with the
[EGI Operations Portal](https://operations-portal.egi.eu/vo/a/list) and
available to application entries

### User Role List

- Resource: `people/roles/`
- Type: list
- Datatype: role
- Schema: person
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of user roles available, which define base user privileges

### Available Tag List

- Resource: `applications/tags/`
- Type: list
- Datatype: tag
- Schema: application
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of all tag entries that have been attached at least once on any application
entry

### Contact Type List

- Resource: `people/contacttypes/`
- Type: list
- Datatype: tag
- Schema: person
- Filtering: no
- Public Operations: `GET`
- Authenticated Operations: none

List of contact types available to user contact information entries

### Application Filter Normalization

- Resource: `applications/filter/normalize`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Validates and normalizes a filter expression for application searches, defined
by the querystring parameter `flt`

### Application Filter Reflection

- Resource: `applications/filter/reflect`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Returns a nested representation of the filtering expression specifiers available
to application searches

### Person Filter Normalization

- Resource: `people/filter/normalize`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Validates and normalizes a filter expression for user searches, defined by the
querystring parameter `flt`

### Person Filter Reflection

- Resource: `people/filter/reflect`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Returns a nested representation of the filtering expression specifiers available
to user searches

### VO Filter Normalization

- Resource: `vos/filter/normalize`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Validates and normalizes a filter expression for VO searches, defined by the
querystring parameter `flt`

### VO Filter Reflection

- Resource: `vos/filter/reflect`
- Type: entry
- Datatype: filter
- Schema: filter
- Filtering: N/A
- Public Operations: `GET`
- Authenticated Operations: none

Returns a nested representation of the filtering expression specifiers available
to VO searches

### Dissemination Log List

- Resource: `dissemination/`
- Type: list
- Datatype: dissemination
- Schema: dissemination
- Filtering: no
- Public Operations: none
- Authenticated Operations: `GET`

List of dissemination messages that have been dispatched to registered users.
Administrative access only.

## Dissemination Log Entry

- Resource: `dissemination/{id}`
- Type: entry
- Datatype: dissemination
- Schema: dissemination
- Filtering: N/A
- Public Operations: none
- Authenticated Operations: `GET`

Detailed description of a dissemination message that has been dispatched to
registered users. Administrative access only.
