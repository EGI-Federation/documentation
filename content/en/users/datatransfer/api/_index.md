---
title: "API"
linkTitle: "API"
type: docs
description: "Documentation for EGI Data Transfer API"
weight: 30
---

## Overview 

The EGI Data Transfer service offers API both for Users and Admins, in this section 
we are focusing on the User API.
2 APIs are available to users:

- RESTFul API
- Python Easy Bindings

In both cases users need a way to be authenticated and authorised and this is explained
in the next section.

## Authentication & Authorisation

{{% alert title="Warning" color="warning" %}}

Users have to authenticate using a X509 User certificate. The integration 
with EGI Check-in in order to authenticate via OIDC tokens  
is under development and will be later be made available in production endpoints.

{{% /alert %}}

During the authentication phase, credentials are delegated to the FTS service, which will contact 
the storages to steer the data transfers on behalf of the users.

The FTS service supports both plain X509 proxies than [VOMS](https://italiangrid.github.io/voms/index.html) X.509 proxies extended with VO information for authentication and authorisation.


### VOMS configuration

Every VO needs two different pieces of information:

-   the `vomses` configuration files, where the details of the VO are
    stored (e.g. name, server, ports). These are stored by default at
    `/etc/vomses` and are normally named following this convention:
    `<vo name>.<server name>` 
-   the `.lsc` files that describe the trust chain of the VOMS server.
    These are stored at `/etc/grid-security/vomsdir/<vo name>` and there
    should be one file for each of the VOMS server of the VO.

You can check specific configuration for your VO at the [Operations
portal](https://operations-portal.egi.eu/vo). Normally each VOMS server
has a *Configuration Info* link where the exact information to include
in the *vomses* and *.lsc* files.


VOMS client expects your certificate and private key to be available at
`$HOME/.globus/usercert.pem` and `$HOME/.globus/userkey.pem`
respectively.

### Creating a proxy

Once you have the VO information configured (`vomses` and `.lsc`) and
your certificate available in your `$HOME/.globus` directory you can
create a VOMS proxy to be used with clients (voms-clients package) with:

```console
voms-proxy-init --voms <name of the vo> --rfc
```

Plain proxies can still be created via 

```console
voms-proxy-init --rfc
```

## RESTFul API

The User RESTFul APIs can be used to submit transfers jobs (collections of single transfers), monitor and cancel existing transfers. Please check the CERN [documentation](https://fts3-docs.web.cern.ch/fts3-docs/fts-rest/docs/api.html) for the full API details. Here we will provide some examples usage using the Curl client.

### Checking how the server sees us

```console
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY --cacert $X509_USER_PROXY https://fts3-public.cern.ch:8446/whoami
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

### Get a List of Jobs Running

Filtered by VO

```console
bash-4.2# curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY --cacert $X509_USER_PROXY https://fts3-public.cern.ch:8446/jobs?vo_name=dteam 

[
  {
    "cred_id": "1426115d1660de4d",
    "user_dn": "/DC=ch/DC=cern/OU=Organic Units/OU=Users/CN=ftssuite/CN=737188/CN=Robot: fts3 testsuite",
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


### Cancel a Job

```console
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY --cacert $X509_USER_PROXY  https://fts3-pilot.cern.ch:8446/jobs/a40b82b7-1132-459f-a641-f8b49137a713 -X DELETE
```

### Get Expiration time of delegated credentials

```console
curl --capath /etc/grid-security/certificates -E $X509_USER_PROXY --cacert $X509_USER_PROXY https://fts3-public.cern.ch:8446/delegation/9ab8068853808c6b 
{
  "voms_attrs": [
    "/dteam/Role=NULL/Capability=NULL"
  ],
  "termination_time": "2020-07-31T22:50:28"
}
```


## Python Bindings

The Python bindings for FTS can be installed from the EPEL package repository (EL6 and EL7 packages are available) with Python 2.7 being supported.

```console
yum install python-fts -y
```

For using the  bindings, you need to import fts3.rest.client.easy, although for convenience it can be renamed as something else

```console
import fts3.rest.client.easy as fts3
```

In the following code snippets, an import as above is assumed.

In order to be able to do any operation, some state about the user credentials and remote endpoint need to be kept. That's the purpose of a Context.
```console
context = fts3.Context(endpoint, ucert, ukey, verify=True)
```

The endpoint to use corresponds to the FTS instance REST server and it must have the following format:

https://\<host>:\<port>

for instance ```https://fts3-public.cern.ch:8446```

If you are using a proxy certificate, you can either specify only user_certificate, or point both parameters to the proxy. user_certificate and user_key can be safely omitted, and the program will use the values defined in the environment variables X509_USER_PROXY or X509_USER_CERT + X509_USER_KEY.

If verify is False, the server certificate will not be verified.

Here some examples on how to create a context, submit a job with a single transfer and get the job status:

```console
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
    u'reason': u'One or more files failed. Please have a look at the details for more information',
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

Full [documentation](https://fts3-docs.web.cern.ch/fts3-docs/fts-rest/docs/easy/index.html) is also available.
