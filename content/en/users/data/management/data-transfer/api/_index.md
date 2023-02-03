---
title: Data Transfer API
linkTitle: API
weight: 30
type: docs
aliases:
  - /users/data-transfer/api
description: >
  The programmatic interface of EGI Data Transfer
---

## Overview

EGI Data Transfer offers Application Programming Interfaces (APIs) for both
regular users and administrator. This page focuses on the user APIs,
available in two favors:

- REST API
- Python Easy Bindings

{{% alert title="Note" color="info" %}} Please check out the
[documentation](https://fts3-docs.web.cern.ch/fts3-docs/fts-rest/docs/easy/index.html)
for more details about the avilable APIs, their parameters and return values.
{{% /alert %}}

## Authentication & Authorisation

Users have to authenticate before they can call the API.

<!-- markdownlint-disable no-inline-html -->

{{% alert title="Important" color="warning" %}} Authentication requires an
**X.509 user certificate**.<br/>
Integration with [EGI Check-in](../../../../aai/check-in), which will allow
authentication using OIDC tokens is under development.
{{% /alert %}}

<!-- markdownlint-enable no-inline-html -->

During the authentication phase, credentials are delegated to the FTS service,
which will contact the storages to steer the data transfers on behalf of the
users.

The FTS service supports both plain X.509 proxies and
[X.509 proxies extended with VO information](https://italiangrid.github.io/voms/index.html) (VOMS)
for authentication and authorisation. You can learn more about
[VOMS configuration and proxy creation](../../../../aai/check-in/vos/voms#creating-a-proxy).

## RESTFul API

The User RESTFul APIs can be used to submit transfers jobs (collections of
single transfers), monitor and cancel existing transfers. Please check the CERN
[documentation](https://fts3-docs.web.cern.ch/fts3-docs/fts-rest/docs/api.html)
for the full API details. Here we will provide some examples usage using the
Curl client.

### Checking how the server sees the identity of the user

```shell
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY \
  --cacert $X509_USER_PROXY https://fts3-public.cern.ch:8446/whoami
{
  "dn": [
    "/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi",
    "/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi/CN=proxy"
  ],
  "vos_id": [
    "6b10f4e4-8fdc-5555-baa2-7d4850d4f406"
  ],
  "roles": [],
  "delegation_id": "9ab8068853808c6b",
  "user_dn": "/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi",
  "level": {
    "transfer": "vo"
  },
  "is_root": false,
  "base_id": "01874efb-4735-4595-bc9c-591aef8240c9",
  "vos": [
    "dteam"
  ],
  "voms_cred": [
    "/dteam/Role=NULL/Capability=NULL"
  ],
  "method": "certificate"
}
```

### Getting a list of jobs running

Filtered by VO

```shell
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY \
  --cacert $X509_USER_PROXY https://fts3-public.cern.ch:8446/jobs?vo_name=dteam

[
  {
    "cred_id": "1426115d1660de4d",
    "user_dn": "/DC=ch/DC=cern/OU=Organic Units/OU=Users/CN=ftssuite/CN=737188/CN=Robot:
    fts3 testsuite",
    "job_type": "N",
    "retry": -1,
    "job_id": "94560e74-7ca3-11e9-97dd-02163e00d613",
    "cancel_job": false,
    "job_state": "FINISHED",
    "submit_host": "fts604.cern.ch",
    "priority": 3,
    "source_space_token": "",
    "max_time_in_queue": null,
    "job_metadata": {
      "test": "test_bring_online",
      "label": "fts3-tests"
    },
    "source_se": "mock://somewhere.uk",
    "bring_online": 120,
    "reason": null,
    "space_token": "",
    "submit_time": "2019-05-22T15:09:22",
    "retry_delay": 0,
    "dest_se": "mock://somewhere.uk",
    "internal_job_params": "nostreams:1",
    "overwrite_flag": false,
    "copy_pin_lifetime": -1,
    "verify_checksum": "n",
    "job_finished": null,
    "vo_name": "dteam"
  }
]
```

### Cancelling a job

```shell
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY \
  --cacert $X509_USER_PROXY \
   -X DELETE \
  https://fts3-pilot.cern.ch:8446/jobs/a40b82b7-1132-459f-a641-f8b49137a713
```

### Getting expiration time of delegated credentials

```shell
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY \
  --cacert $X509_USER_PROXY \
  https://fts3-public.cern.ch:8446/delegation/9ab8068853808c6b
{
  "voms_attrs": [
    "/dteam/Role=NULL/Capability=NULL"
  ],
  "termination_time": "2020-07-31T22:50:28"
}
```

## Python Bindings

The Python bindings for FTS can be installed from the EPEL package repository
(EL6 and EL7 packages are available) with Python 2.7 being supported.

```shell
yum install python-fts -y
```

For using the bindings, you need to import `fts3.rest.client.easy`, although for
convenience it can be renamed as something else:

```shell
import fts3.rest.client.easy as fts3
```

In the following code snippets, an import as above is assumed.

In order to be able to do any operation, information about the state of the user
credentials and remote endpoint needs to be kept. That's the purpose of a
Context.

```shell
context = fts3.Context(endpoint, ucert, ukey, verify=True)
```

The endpoint to use corresponds to the FTS instance REST server and it must have
the following format:

`https://\<host>:\<port>`

for instance `https://fts3-public.cern.ch:8446`

If you are using a proxy certificate, you can either specify only
`user_certificate`, or point both parameters to the proxy. `user_certificate`
and `user_key` can be safely omitted, and the program will use the values
defined in the environment variables `X509_USER_PROXY` or `X509_USER_CERT` +
`X509_USER_KEY`.

If verify is `False`, the server certificate will not be verified.

Here are some examples about creating a context, submitting a job with a single
transfer and getting the job status:

```shell
# pretty print the json outputs
>>> import pprint
>>> pp = pprint.PrettyPrinter(indent=4)

# creating the context
>>> context = fts3.Context("https://fts3-public.cern.ch:8446")
# printing the whoami info
>>>  pp.pprint (fts3.whoami(context))

{   u'base_id': u'01874efb-4735-4595-bc9c-591aef8240c9',
    u'delegation_id': u'9ab8068853808c6b',
    u'dn': [   u'/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi',
               u'/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi/CN=proxy'],
    u'is_root': False,
    u'level': {   u'transfer': u'vo'},
    u'method': u'certificate',
    u'roles': [],
    u'user_dn': u'/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi',
    u'voms_cred': [u'/dteam/Role=NULL/Capability=NULL'],
    u'vos': [u'dteam'],
    u'vos_id': [u'6b10f4e4-8fdc-5555-baa2-7d4850d4f406']}

# creating a new transfer and submiting a job
>>> transfer = fts3.new_transfer(
...   'gsiftp://source/path', 'gsiftp://destination/path',
...   checksum='ADLER32:1234', filesize=1024,
...   metadata='Submission example'
... )
>>> job = fts3.new_job([transfer])
>>> job_id = fts3.submit(context, job)
>>> print job_id
b6191212-d347-11ea-8a47-fa163e45cbc4

# get the job status
>>> pp.pprint(fts3.get_job_status(context, job_id))
{   u'bring_online': -1,
    u'cancel_job': False,
    u'copy_pin_lifetime': -1,
    u'cred_id': u'9ab8068853808c6b',
    u'dest_se': u'gsiftp://destination',
    u'http_status': u'200 Ok',
    u'internal_job_params': u'nostreams:1',
    u'job_finished': u'2020-07-31T16:05:55',
    u'job_id': u'b6191212-d347-11ea-8a47-fa163e45cbc4',
    u'job_metadata': None,
    u'job_state': u'FAILED',
    u'job_type': u'N',
    u'max_time_in_queue': None,
    u'overwrite_flag': False,
    u'priority': 3,
    u'reason': u'One or more files failed. Please have a look at the details for
    more information',
    u'retry': -1,
    u'retry_delay': 0,
    u'source_se': u'gsiftp://source',
    u'source_space_token': u'',
    u'space_token': u'',
    u'submit_host': u'fts-public-03.cern.ch',
    u'submit_time': u'2020-07-31T16:05:54',
    u'user_dn': u'/DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Manzi',
    u'verify_checksum': u't',
    u'vo_name': u'dteam'}
```
