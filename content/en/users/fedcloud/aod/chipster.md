---
title: "Chipster"
type: docs
weight: 20
description: >
  Chipster on Applications on Demand
---

[Chipster](http://chipster.csc.fi/) is a user-friendly software for
analysing high-throughput data such as NGS and microarrays and provided
as part of EGI\'s AoD service.

The software contains over 400 analysis tools and a large collection of
reference genomes.

Users can save and share automatic analysis workflows, and visualize
data interactively using for example the built-in genome browser.

## EGI Chipster

The Chipster testbed configured at [CESGA](https://www.cesga.es/)
offers:

-   8 vCPU cores,
-   32GB of RAM,
-   1TB of block storage in /data,
-   Software and tools are in available under the `/cvmfs/tools_*`
    partition,
-   Chipster (v3.16.3).

For accessing this testbed you need to be a member of the [Applications
on Demand](https://www.egi.eu/services/applications-on-demand/).

## Create/Review a temporary account

You need to create a temporary account to access the Chipster server, by
default this account is valid for **one month**.

Go to [Chipster entry in Science Software on Demand
Portal](https://fgsg.egi.eu/egissod/web/ssod/chipster-accounts) and:

-   Click on the *\"Show form\"*.
-   If the account has expired, the Science Gateway will automatically
    generate a new password for you.
    -   To activate the new account, click on the *\"Execute\"* button
        to trigger the creation/update of the temporary account in the
        Chipster testbed. This operation may takes a few minutes.
    -   You can monitor the account creation by clicking in the
        *\"Show\"* button.
-   Once your account is available, the web interface will show a link
    to access the [Chipster
    server](http://chipster.aod.fedcloud.eu:8081/chipster.jnlp) with the
    new credentials.

![Chipster in Science Software on Demand](../chipster.png)

{{% alert title="Acknowledgment" color="info" %}}

Please provide appropriate acknowledgement of the use in scientific
publications. You can use this The following acknowledgement text this
purpose:

**This work used the EGI Applications on Demand service, which is
co-funded by the EOSC-hub project (grant number 777536)**
{{% /alert %}}
