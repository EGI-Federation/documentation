---
title: "File Transfer with grid storage"
linkTitle: "File Transfer with grid storage"
type: docs
weight: 80
draft: true
description: >
  Use EGI File Transfer to handle data in grid storage
---


## Overview

This tutorial describes how to perform a transfer usin FTS transfers services
and WebFTS.

## Prerequisites

As first step please make sure that you have installed the FTS client as
described in [Data Transfer](../../data-transfer/), and in particular
[Clients](../../data-transfer/clients/) for the command line FTS and to have
your certificate installed in your browser to use
[WebFTS](../../data-transfer/webfts/) browser based client.

To access services and resources in the
[EGI Federated Cloud](../../getting-started), you will need:

- An [EGI Check-in](../../check-in) account, you can [sign up here](../../check-in/signup)
- Enrollment into a [Virtual Organisation](../../check-in/vos) (VO) that has
  access to the services and resources you need

## Using the FTS client

### Step 1 Configuration check

To verify that everything is configured properly you can check with the
following command pointing to the cerficates directly:

```shell
$ fts-rest-whoami --key .globus/userkey.pem --cert .globus/usercert.pem -s https://fts3-public.cern.ch:8446/
User DN: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
VO: AndreaCristoforiac@egi.eu@tcs.terena.org
VO id: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
Delegation id: XXXXXXXXXXXXXXXX
Base id: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
```

In general the commands can be used by specifying the user public and private
key like shown in the example or by creating a proxy certificate as

### Proxy creation

To avoid the need to specify at each command the private and public key if
everything is already configured and working properly it will be enough to
execute the following coomand:

```shell
$ voms-proxy-init
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
Creating proxy ........................................... Done

Your proxy is valid until Wed Aug 25 04:18:14 2021
```

As the output of the command shows a proxy certificate has been generated that
will be valid, by default, for 12 hours. This can be usually increased for
example to 48 hours with the following option:

```shell
$ voms-proxy-init -valid 48:00
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
Creating proxy ................................... Done

Your proxy is valid until Thu Aug 26 16:23:01 2021
```

To verify the timeleft for the validity of the proxy created use the following
command:

```shell
$ voms-proxy-info
subject   : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu/CN=1451339003
issuer    : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
identity  : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
type      : RFC compliant proxy
strength  : 1024 bits
path      : /tmp/x509up_u1000
timeleft  : 19:59:57
```

<!-- markdownlint-enable line-length -->

When the timeleft reaches zero if the previous command used to check the
identity will return the following message:

<!-- markdownlint-disable line-length -->

```shell
$ fts-rest-whoami -s https://fts3-public.cern.ch:8446/
Error: Proxy expired!
```

<!-- markdownlint-enable line-length -->

The last option that we need to use is specify the VO that we want to use for
the proxy being created. In the following example the "dteam" VO has been used:

<!-- markdownlint-disable line-length -->

```shell
[ac@localhost ~]$ voms-proxy-init --voms dteam
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Andrea Cristofori ac@egi.eu
Creating temporary proxy ................................................................... Done
Contacting  voms2.hellasgrid.gr:15004 [/C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms2.hellasgrid.gr] "dteam" Done
Creating proxy .............................................................................. Done

Your proxy is valid until Wed Sep  8 04:37:07 2021
```

<!-- markdownlint-enable line-length -->

### Find the storage

In general it should be already known the source and destination storage for a
specific project however to find the available options we can use for a
transfer, source and destination, we can use the
[VAPOR service](https://operations-portal.egi.eu/vapor/resources/GL2ResVO).

![VAPOR main page](VAPOR-home.png)

Once the page is loaded on the left column it is possible to filter by VO or
scroll the list and click the desired VO as show in the following picture:

![VAPOR VO detail](VAPOR-VO_detail.png)

Once selected we can see all the resources associated with the spcific VO. In
particular in this case we're interested in the information on the status,
capacity, type of storage, etc. Following is a screenshot of the visualization
of the list of storage available to "dteam"

![VAPOR storage page](VAPOR-storage.png)

###Start a transfer

Once we have identified the surce and destination storage needed for the
transfer we can proceed with the transfer between the two endpoints. To do that
we can use a command of this type:

<!-- markdownlint-disable line-length -->

```shell
$ fts-transfer-submit -s https://fts3-public.cern.ch:8446/ --source https://dc2-grid-64.brunel.ac.uk/dpm/brunel.ac.uk/home/dteam/00 --destination https://golias100.farm.particle.cz/dpm/farm.particle.cz/home/dteam/00
d7920806-10b1-11ec-8218-fa163ecee758
```

<!-- markdownlint-enable line-length -->

Which return the jobid correspondedent to the transfer that we started. To check
the status of the transfer we can use the returned jobid and use the following
command:

<!-- markdownlint-disable line-length -->

```shell
$ fts-transfer-status -s https://fts3-public.cern.ch:8446/ d7920806-10b1-11ec-8218-fa163ecee758
ACTIVE
```

<!-- markdownlint-enable line-length -->

which specify the server that control the transfer, the source and the transfer
itself.

## WebFTS

### Access the WebFTS interface

The WebFTS is accessible at this URL, [WebFTS](https://webfts.cern.ch/)
Similarly to what has been done from the command line interface we need to
provide our private key for delegation of the credential. To do that we use the
following command:

<!-- markdownlint-disable line-length -->

```shell
#openssl pkcs12 -in yourCert.p12 -nocerts -nodes | openssl rsa
Enter Import Password:
writing RSA key
-----BEGIN RSA PRIVATE KEY-----
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
...
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-----END RSA PRIVATE KEY-----
```

<!-- markdownlint-enable line-length -->

Which extract the private key in RSA format and we paste it in the windows that
opens:

![WebFTS credential delegation](WebFTS-credential_delegation.png)

And select the desired VO. Once the delegation is set it's possible to move to
the following steps.

### Submitting a transfer

The tab <Submit a transfer> is divided in two parts in which is possible to add
two endpoints that can be used both as source or destination. After adding the
URL for the two endpoints, it is possible to browse and select the files and
directories to be transferred. In the destination select the destination
directory. In the following example the file 1MB has been selected and by simply
clicking the arrow in the middle directing to the right we are instructing the
system to copy the file from the storage and path on the left to the one on the
right:

![WebFTS submit transfer](WebFTS-submit_transfer.png)

On the top of the page is also shown a confirmation that the transfer has been
submitted successfully. This same webpage shows the status of the current
transfers in the `My jobs` tab.
