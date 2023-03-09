---
title: MAN09 Accounting data publishing
weight: 70
type: "docs"
description: "Publishing accounting information for different middleware."
---

## Document control

| Property            | Value                                                          |
| ------------------- | -------------------------------------------------------------- |
| Title               | Accounting data publishing                                     |
| Policy Group        | Operations Management Board (OMB)                              |
| Document status     | Approved                                                       |
| Procedure Statement | How to publish accounting information for different middleware |
| Owner               | SDIS team                                                      |

## Introduction

In this manual we will show you how to publish accounting information from
different middleware.

## General information

### Publishing with the APEL Client/SSM

To start sending accounting records:

1. register each endpoint sending the accounting records to the central
   repository as 'gLite-APEL' endpoint in GOCDB with host DN information
   - either `HTCondorCE` or `ARC-CE` endpoints
   - it is needed to authorise the endpoint to use the ARGO Message Service
     (AMS)
   - Changes in GOCDB can take up to 4 hours to make it to AMS.
2. install the APEL client and APEL SSM on your publisher host and edit
   `client.cfg` and `sender.cfg`
3. install the APEL parser relevant to your batch system on each CE and edit
   `parser.cfg`
   - documentation for APEL
     [here](https://twiki.cern.ch/twiki/bin/view/EMI/EMI3APELClient)
     - [GitHub apel/apel](https://github.com/apel/apel)
     - [GitHub apel/ssm](https://github.com/apel/ssm)
4. The old ActiveMQ network was dismissed: have a look at the new settings to
   properly
   [publish the accounting records via AMS](https://github.com/apel/ssm/blob/dev/migrating_to_ams.md)
5. configure the client to publish data from the start of the current month.
6. Run the parser(s) and client.
7. If there are no errors messages and the client says it has sent messages then
   wait a day and you should see summaries
   [here](http://goc-accounting.grid-support.ac.uk/apel/summaries2.html)
8. If it doesn't open a GGUS ticket for the APEL Team.

### Monitoring the accounting data publication

In order to monitor the regular publication of accounting data, it is enough
registering only one CE with the `APEL` service type.

See [here](https://wiki.egi.eu/wiki/APEL/Tests) the details about the related
Nagios probes.

### Publishing summarized records or single ones

Sites can send either but the preferred option is summaries. Larger sites are
recommended to send summaries.

### The frequency for sending aggregated/summary records to APEL database?

We recommend sending data daily for all sites, whether sending summaries or
individual records. I think this is in the interests of people who are using the
portal so that what they see is accurate. The summaries are for a complete month
or the current month so far.

### Authorization and authentication

Authorization and authentication is made by the host certificate (which is
signed by a trusted CA from the ca_policy_core package). Certificate should be
registered in GOCDB. The certificate must not have the X509 extension:
`Netscape Cert Type: SSL Server` because the message brokers will reject it.

## ARC

ARC uses its own system to publish the accounting data through AMS, so please
refer to the NorduGrid ARC 6 documentation:

- Information relevant only for 6.4 ARC releases and beyond:
  [Accounting-NG](http://www.nordugrid.org/documents/arc6/tech/accounting/accounting-ng.html#accounting-ng-tech)
- The old ActiveMQ network was dismissed.
  [ARC 6.12](https://www.nordugrid.org/arc/releases/6.12/release_notes_6.12.html)
  introduces new settings for publishing the accounting records via AMS.

## HTCondor-CE

To collect and publish the accounting data you need to install the APEL software
as explained in the general information section. In addition, HTCondor-CE must
be configured to create accounting records:

- Information on configuring HTCondor-CE for APEL accounting:
  [APEL Accounting for HTCondor-CE](../../high-throughput-compute/htcondor-ce-apel)
