---
title: "Piloting applications in EGI"
type: docs
weight: 05
description: >
  Pilot your application using EGI services
---

EGI offers a plaground allocation for users get access to the services and
understand how to port applications and develop new data analytics tools that
can be turn into online services that can be accessed by scientist worldwide.

## Requirements and user registration

Access **requires** acceptance of
[Acceptable Use Policy (AUP) and Conditions of the \'EGI Applications on Demand Service\'](https://documents.egi.eu/public/ShowDocument?docid=2635).

{{% alert title="Acknowledgment" color="info" %}}

Users of the service are asked to provide appropriate acknowledgement of the use
in scientific publications. The following acknowledgement text can be used for
this purpose (you can adapt to match the exact providers in your case):

**This work used advanced computing resources from the 100%IT, CESGA, CLOUDIFIN,
CYFRONET-CLOUD, GSI-LCG2, IFCA-LCG2, IN2P3-IRES, INFN-CATANIA-STACK,
INFN-PADOVA-STACK, SCAI, TR-FC1-ULAKBIM, UA-BITP and UNIV-LILLE resource centres
of the EGI federation. The services are co-funded by the EGI-ACE project (grant
number 101017567).** {{% /alert %}}

When requesting access users are guided through a registration process. Members
of the EGI support team will perform a lightweight vetting process to validate
the users\' requests before granting the access to the resources.

### How can you access the service?

1. Login to the [EGI Marketplace](https://marketplace.egi.eu) with the
   [EGI AAI Check-In service](../check-in).
1. Setup a profile, including details about your affiliation and role within a
   research institute/project/team.
1. Navigate the marketplace top-menu and click on the category:
   **Applications**.
1. Click on the **Applications on Demand** service and submit an order for one
   of the available applications.
1. When the request is approved, run the requested application(s) as described
   below.

Please check the
[EGI Marketplace guide](https://wiki.egi.eu/wiki/HowToAccessTheEGIMarketPlace)
for further details.

## Services available

### Cloud Compute

Once granted access, each user will have a grant with a predefined quota of
resources, which can be used to run the application of choice. This grant
includes:

- up to 4 CPU cores,
- 8 GB of RAM,
- 100GB of block storage.

The grant to run applications is initially valid for 6 months and can be
extended/renewed upon request. These resources are delivered
[through the vo.access.egi.eu VO](https://documents.egi.eu/public/ShowDocument?docid=2773).

You can manage those resources via [command-line](../cli) or any of the
dashboards of the EGI Cloud: the [VMOps dashboard](../../cloud-compute/vmops)
and the [IM dashboard](../../cloud-compute/im).

### Scientific applications

You can also access scientific applications via the piloting allocation:

- [Chipster](https://marketplace.egi.eu/applications-on-demand/68-chipster.html)
  a user-friendly analysis software for high-throughput data. It contains over
  300 analysis tools for next generation sequencing (NGS), microarray,
  proteomics and sequence data. The application is available through the Science
  Software on Demand Service (SSoD). You can access the
  [EGI Chipster instace](https://chipster.fedcloud-tf.fedcloud.eu/)
- [EC3](../ec3) has a list of [applications](../ec3/apps/) that you can easily
  start from the [EC3 porta](https://servproject.i3m.upv.es/ec3-ltos/index.php)
