---
title: MAN09 Accounting data publishing
permalink: /MAN09_Accounting_data_publishing/
---

## Introduction

In this manual we will show you how to publish accounting information
from different middlewares.

## General information

### Publishing with the APEL Client/SSM

To start sending accounting records:

1.  register each endpoint sending the accounting records to the central
    repository as 'gLite-APEL' endpoint in GOCDB with host DN
    information
      - either HTCondorCE or ARC-CE endpoints
      - it is needed to authorise the endpoint to use the ARGO Message
        Service (AMS)
      - Changes in GOCDB can take up to 4 hours to make it to AMS.
2.  install the APEL client and APEL SSM on your publisher host and edit
    client.cfg and sender.cfg
3.  install the APEL parser relevant to your batch system on each CE and
    edit parser.cfg
      - documentation for APEL
        here: <https://twiki.cern.ch/twiki/bin/view/EMI/EMI3APELClient>
          - <https://github.com/apel/apel>
          - <https://github.com/apel/ssm>
4.  The old ActiveMQ network was dismissed: have a look at the new
    settings to properly publish the accounting records via AMS:
    <https://github.com/apel/ssm/blob/dev/migrating_to_ams.md>
5.  configure the client to publish data from the start of the current
    month. 
6.  Run the parser(s) and client. 
7.  If there are no errors messages and the client says it has sent
    messages then wait a day and you should see summaries here:
    <http://goc-accounting.grid-support.ac.uk/apel/summaries2.html>
8.  If it doesn't open a GGUS ticket for the APEL Team.

### Monitoring the accounting data publication

In order to monitor the regular publication of accounting data, it is
enough registering only one CE with the "**APEL**" service type

See here the details about the related nagios probes:
<https://wiki.egi.eu/wiki/APEL/Tests>

### Publishing summarized records or single ones

Sites can send either but the preferred option is summaries. Larger
sites are recommended to send summaries.

### The frequency for sending aggregated/summary records to Apel database?

We recommend sending data daily for all sites, whether sending summaries
or individual records. I think this is in the interests of people who
are using the portal so that what they see is accurate. The summaries
are for a complete month or the current month so far.

### Authorization and authentication

Authorization and authentication is made by the host certificate (which
is signed by a trusted CA from the ca_policy_core package).
Certificate should be registered in GOC DB. The certificate must not
have the x509 extension: "Netscape Cert Type: SSL Server" because the
message brokers will reject it.

## ARC

ARC uses its own system to publish the accounting data through AMS, so
please refer to the NorduGrid ARC 6 documentation:

  - Information relevant only for 6.4 ARC releases and beyond:
    <http://www.nordugrid.org/documents/arc6/tech/accounting/accounting-ng.html#accounting-ng-tech>
  - The old ActiveMQ network was dissmissed. ARC 6.12 introduces new
    settings for publishing the accounting records via AMS:
    <http://www.nordugrid.org/arc/releases/6.12/release_notes_6.12.html>

## HTCondor-CE

To collect and publish the accounting data you need to install the APEL
software as explained in the general information section.

## Revision History

| Version | Authors            | Date           | Comments                                                                                    |
| ------- | ------------------ | -------------- | ------------------------------------------------------------------------------------------- |
|         | Alessandro Paolini | 2021-08-06     | updated the General Information and ARC sections; removed Globus, QCG, and Unicore sections |
|         | Alessandro Paolini | 2019-10-08     | added link to specific ARC 6 documentation                                                  |
|         | Alessandro Paolini | 2019-09-13     | updating the general information...                                                         |
|         | JC Gordon          | 17 Sept. 2014  | Remove requirement to test APEL client                                                      |
|         | M. Krakowian       | 19 August 2014 | Change contact group -\> Operations support                                                 |

[Category:Operations_Manuals](/Category:Operations_Manuals "wikilink")