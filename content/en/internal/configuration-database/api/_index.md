---
title: "API"
description: "Accessing the Configuration Database API"
weight: 90
type: "docs"
---

{{% alert title="Note" color="info" %}} Exhaustive documentation of the API for
the [GOCDB service](https://github.com/GOCDB/gocdb), powering the
[EGI Configuration Database](../), is available
[on the dedicated GOCDB API documentation site](https://gocdb.github.io/api/).
{{% /alert %}}

The GOCDB Programmatic Interface (PI) is available under `/gocdbpi`.

## API components

The GOCDB PI has two main components:

- The [Read API](https://gocdb.github.io/api/read/)
- The [Write API](https://gocdb.github.io/api/write/)

The **Read API** provides programmatic access to the data. Access to some
information (security/critical, personal details, otherwise sensitive
information) is restricted, more details are available in the section about
[data protection levels](https://gocdb.github.io/api/read/#data-protection-levels).

The **Write API** provides limited functionality to add, update, and delete
entities. Access is restricted, more details can be found in the section about
[authentication and authorisation](https://gocdb.github.io/api/write/#authenticationauthorisation).

## Using the Read API

### Querying

API calls can be tested in a browser or done from the command-line interface,
using `curl`.

Below are some examples, including methods with different
[data protection levels](https://gocdb.github.io/api/read/#data-protection-levels).

> API calls starting with `https://goc.egi.eu/gocdbpi/private` require the
> client to present a valid credential.

- **Public** calls, no authentication required:
  - [Retrieving all service endpoints](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint)
  - [Collecting information about endpoints under the EGI and FedCloud scopes](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&scope=EGI,FedCloud)
- **Private** calls, with authentication required:
  - [Retrieving all COD Staff and EGI CSIRT Officer to be allowed in secmon](https://goc.egi.eu/gocdbpi/private/?method=get_user&roletype=EGI%20CSIRT%20Officer,COD%20Staff)
  - [Querying for certification history for a site](https://goc.egi.eu/gocdbpi/private/?method=get_cert_status_changes&site=mainz)
  - [Querying for CSIRT emails of FedCloud sites](https://goc.egi.eu/gocdbpi/private/?method=get_site&scope=FedCloud,EGI&scope_match=all&certification_status=Certified&production_status=Production)
  - [Querying for Security officer at FedCloud sites](https://goc.egi.eu/gocdbpi/private/?method=get_site_contacts&roletype=Site%20Security%20Officer&scope=FedCloud,EGI&scope_match=all)

### Extracting content

It is possible to filter content using `xpath`. Download
[information about endpoints under the EGI and FedCloud scopes](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&scope=EGI,FedCloud)
as `egi_fedcloud_service_endpoints.xml`.

```shell
# Extracting endpoints in production
$ xpath -q -e "//SERVICE_ENDPOINT[IN_PRODUCTION='Y']/HOSTNAME/text()" \
    egi_fedcloud_service_endpoints.xml | sort | uniq
```

### Using an X.509 client certificate to authenticate from the CLI

Querying information about a specific site using CURL, and authenticating with
an X.509 client certificate.

```shell
$ curl -v --cert ~/.globus/usercert.pem --key ~/.globus/userkey.pem \
    'https://goc.egi.eu/gocdbpi/private/?method=get_site&sitename=CESGA'
```

### Querying using python

#### Looking for FedCloud endpoints

See
[python script from cloud-info-provider repository](https://github.com/EGI-Federation/cloud-info-provider/blob/master/cloud_info_provider/providers/gocdb.py).

## Using the Write API

Examples of using the Write API can be found on the
[GOCDB PI site](https://gocdb.github.io/api/write/#examples).
