---
title: "API"
description: "Accessing the Configuration Database API"
weight: 90
type: "docs"
---

{{% alert title="Note" color="info" %}} The API for the
[GOCDB service](https://github.com/GOCDB/gocdb), powering the EGI Configuration
Database, is available [on a dedicated site](https://gocdb.github.io/api/).
{{% /alert %}}

## API endpoints

The API is accessible in two different ways:

- [Public/read](https://gocdb.github.io/api/read/), allowing only to read some
  information.
- [Private/write](https://gocdb.github.io/api/write/), allowing to read all
  information and to edit content according to your roles.

Prefer to use the [read API](https://gocdb.github.io/api/read/) if possible, but
some information (like personal data) is only available via the
[write API](https://gocdb.github.io/api/write/). It's only possible to write
using the [write API](https://gocdb.github.io/api/write/).

## Querying the API

API calls can be tested in a browser or done from the commmand-line interface,
using `curl`.

Below are some examples:

- [Retrieving all service endpoints](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint)
  (Read API)
- [Collecting information about endpoints under the EGI and FedCloud scopes](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&scope=EGI,FedCloud)
  (Read API)
- [Retrieving all COD Staff and EGI CSIRT Officer to be allowed in secmon](https://goc.egi.eu/gocdbpi/private/?method=get_user&roletype=EGI%20CSIRT%20Officer,COD%20Staff)
  (Write API)
- [Querying for certification history for a site](https://goc.egi.eu/gocdbpi/private/?method=get_cert_status_changes&site=mainz)
  (Write API)
- [Querying for CSIRT emails of FedCloud sites](https://goc.egi.eu/gocdbpi/private/?method=get_site&scope=FedCloud,EGI&scope_match=all&certification_status=Certified&production_status=Production)
  (Write API)
- [Querying for Security officer at FedCloud sites](https://goc.egi.eu/gocdbpi/private/?method=get_site_contacts&roletype=Site%20Security%20Officer&scope=FedCloud,EGI&scope_match=all)
  (Write API)

## Extracting content

It is possible to filter content using `xpath`. Download
[information about endpoints under the EGI and FedCloud scopes](https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&scope=EGI,FedCloud)
as `egi_fedcloud_service_endpoints.xml`

```shell
# Extracting endpoints in production
$ xpath -q -e "//SERVICE_ENDPOINT[IN_PRODUCTION='Y']/HOSTNAME/text()" \
    egi_fedcloud_service_endpoints.xml | sort | uniq
```

## Using an X.509 client certificate to authenticate from the CLI

Querying information about a specific site using CURL, and authenticating with
an X.509 client certificate.

```shell
$ curl -v --cert ~/.globus/usercert.pem --key ~/.globus/userkey.pem \
    'https://goc.egi.eu/gocdbpi/private/?method=get_site&sitename=CESGA'
```

## Querying using python

### Looking for FedCloud endpoints

See
[python script from cloud-info-provider repository](https://github.com/EGI-Federation/cloud-info-provider/blob/master/cloud_info_provider/providers/gocdb.py).
