---
title: Data Transfer Clients
linkTitle: Clients
type: docs
weight: 20
aliases:
  - /users/data-transfer/clients
description: >
  Clients for accessing EGI Data Transfer
---

<!--
// jscpd:ignore-start
-->

## Overview

The FTS3 service offers a command-line client to ease the interaction with the
service.

## Prerequisites

The client software is available for RHEL and derivatives.

Users from other distributions should refer to the
[RESTFul API section](../api/#restful-api).

## Installation

The CLI can be installed from the EPEL repositories with the following package:

```shell
yum install fts-rest-cli -y
```

## Commands

This section describes some of the commands that can be issues via the FTS CLI.
As per the API, in order to authenticate to the FTS REST server you need an
X.509 User certificate or an EGI Check-in token, please refer to this
[section](../api/#authentication--authorisation) for more information.

Please note that when authenticating via EGI-Check-in only https/s3 transfers are supported.

Check the [full documentation about the FTS CLI](https://fts3-docs.web.cern.ch/fts3-docs/fts-rest/docs/cli/index.html)

### fts-rest-whoami

This command can be used to check, as the name suggests, who are we for the server.

#### Usage

```shell
fts-rest-whoami [options]
Options

-h/--help : Show this help message and exit

-v/--verbose : Verbose output.

-s/--endpoint : Fts3 rest endpoint.

-j/--json : Print the output in json format.

--key : The user certificate private key.

--cert : The user certificate.

--capath : Use the specified directory to verify the peer

--insecure : Do not validate the server certificate

--access-token : Oauth2 access token (supported only by some endpoints,
                 takes precedence)
```

#### Example

```shell
$ fts-rest-whoami --access-token $TOKEN -s https://fts-egi.cern.ch:8446/
User DN: 2dee939532f16e482748b6c25f6ebbf2cac57abd28ca98bee06a114393d14a89@egi.eu
VO: aai.egi.eu
VO id: 2b4ace55-1b2e-5bf3-837d-03e3b08777d9
Delegation id: bd9a59d81b2c37ab
Base id: 01874efb-4735-4595-bc9c-591aef8240c9
```

### fts-rest-transfer-submit

This command can be used to submit new jobs to FTS3. It supports simple and bulk
submissions. The bulk format is as follows:

```shell
{
  "files": [
    {
      "sources": [
        "gsiftp://source.host/file"
      ],
      "destinations": [
        "gsiftp://destination.host/file"
      ],
      "metadata": "file-metadata",
      "checksum": "ADLER32:1234",
      "filesize": 1024
    },
    {
      "sources": [
        "gsiftp://source.host/file2"
      ],
      "destinations": [
        "gsiftp://destination.host/file2"
      ],
      "metadata": "file2-metadata",
      "checksum": "ADLER32:4321",
      "filesize": 2048,
      "activity": "default"
    }
  ]
}
```

#### Usage

```shell
fts-rest-transfer-submit [options] SOURCE DESTINATION [CHECKSUM]
Options

-h/--help : Show this help message and exit

-v/--verbose : Verbose output.

-s/--endpoint : Fts3 rest endpoint.

-j/--json : Print the output in json format.

--key : The user certificate private key.

--cert : The user certificate.

--capath : Use the specified directory to verify the peer

--insecure : Do not validate the server certificate

--access-token : Oauth2 access token (supported only by some endpoints,
                 takes precedence)

-b/--blocking : Blocking mode. Wait until the operation completes.

-i/--interval : Interval between two poll operations in blocking mode.

-e/--expire : Expiration time of the delegation in minutes.

--delegate-when-lifetime-lt : Delegate the proxy when the remote lifetime
 is less than this value (in minutes)

-o/--overwrite : Overwrite files.

-r/--reuse : Enable session reuse for the transfer job.

--job-metadata : Transfer job metadata.

--file-metadata : File metadata.

--file-size : File size (in bytes)

-g/--gparam : Gridftp parameters.

-t/--dest-token : The destination space token or its description.

-S/--source-token : The source space token or its description.

-K/--compare-checksum : Deprecated: compare checksums between source and
destination.

-C/--checksum-mode : Compare checksums in source, target, both or none.

--copy-pin-lifetime : Pin lifetime of the copy in seconds.

--bring-online : Bring online timeout in seconds.

--timeout : Transfer timeout in seconds.

--fail-nearline : Fail the transfer is the file is nearline.

--dry-run : Do not send anything, just print the json message.

-f/--file : Name of configuration file

--retry : Number of retries. If 0, the server default will be used.
If negative, there will be no retries.

-m/--multi-hop : Submit a multihop transfer.

--cloud-credentials : Use cloud credentials for the job (i. E. Dropbox).

--nostreams : Number of streams

--ipv4 : Force ipv4

--ipv6 : Force ipv6
```

#### Example

```shell
fts-rest-transfer-submit -s https://fts-egi.cern.ch:8446 \
  --access-token=$TOKEN \
  https://source.host/file https://destination.host/file
Job successfully submitted.
Job id: 83ef08a6-1ac7-11f0-ae40-fa163ebe1520

$ fts-rest-transfer-submit -s https://fts-egi.cern.ch:8446 \
  --access-token=$TOKEN  -f test.json
Job successfully submitted.
Job id: 9a28d204-d568-11ea-9c80-02163e018681
```

### fts-rest-transfer-status

This command can be used to check the current status of a given job.

#### Usage

```shell
fts-rest-transfer-status [options] JOB_ID
Options

-h/--help : Show this help message and exit

-v/--verbose : Verbose output.

-s/--endpoint : Fts3 rest endpoint.

-j/--json : Print the output in json format.

--key : The user certificate private key.

--cert : The user certificate.

--capath : Use the specified directory to verify the peer

--insecure : Do not validate the server certificate

--access-token : Oauth2 access token (supported only by some endpoints,
 takes precedence)
```

#### Example

```shell
fts-rest-transfer-status -s https://fts-cern.cern.ch:8446 
  --access-token=$TOKEN 83ef08a6-1ac7-11f0-ae40-fa163ebe1520
Request ID: 83ef08a6-1ac7-11f0-ae40-fa163ebe1520
Status: FAILED
Client DN: 2dee939532f16e482748b6c25f6ebbf2cac57abd28ca98bee06a114393d14a89@egi.eu
Reason: One or more files failed. Please have a look at the details for more information
Submission time: 2025-04-16T13:34:26
Priority: 3
VO Name: aai.egi.eu
```

### fts-rest-transfer-cancel

This command can be used to cancel a running job. It returns the final state of
the cancelled job. Please, mind that if the job is already in a final state
`(FINISHEDDIRTY`, `FINISHED`, `FAILED`), this command will return this state.
You can additionally cancel only a subset appending a comma-separated list of
file IDs.

#### Usage

```shell
fts-rest-transfer-cancel [options]
Options

-h/--help : Show this help message and exit

-v/--verbose : Verbose output.

-s/--endpoint : Fts3 rest endpoint.

-j/--json : Print the output in json format.

--key : The user certificate private key.

--cert : The user certificate.

--capath : Use the specified directory to verify the peer

--insecure : Do not validate the server certificate

--access-token : Oauth2 access token (supported only by some endpoints,
 takes precedence)
```

#### Example

```shell
fts-rest-transfer-cancel -s https://fts3-public.cern.ch:8446 \
 --access-token=$TOKEN 9a28d204-d568-11ea-9c80-02163e018681
CANCELED
```

<!--
// jscpd:ignore-end
-->
