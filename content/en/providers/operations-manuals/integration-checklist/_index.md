---
title: Resource Centre Integration Check List
weight: 5
type: docs
description: "Steps required to integrate a Resource Centre"
---

This page provides an overview of what are the required steps to get a new
Resource Centre integrated into the EGI Federation.

1. Be aware of the
   [security policies](https://go.egi.eu/policies-and-procedures).

1. Acceptance of the
   [RC OLA](https://documents.egi.eu/public/ShowDocument?docid=31) (agreed with
   the NGI the RC belongs to).

1. Registration on the
   [Configuration Database](../../../internal/configuration-database):

   - an entry for the resource centre was created
   - Required mailing lists are registered
   - people operating the services are registered
   - service endpoints are registered associated to the proper service types
     ([e.g. for cloud providers](../../cloud-compute/registration)), and the
     flags _monitored_ and _production_ are set to _yes_

1. Support through the [EGI Helpdesk service](../../../internal/helpdesk):

   - The RC name is listed in the GGUS fields “Affected site” and “Notify Site”
   - The site administrators can modify and reply to the tickets assigned to
     their RC
     - The Supporter role can be requested either directly on GGUS by using the
       own X509 personal certificate or by
       [enrolling to the ggus-supporters](https://aai.egi.eu/registry/co_petitions/start/coef:69)
       group in Check-in.

1. Security:

   - HTC: [pakiti](../../../internal/security-coordination/monitoring/pakiti) is
     installed and the outcome of the EGI CSIRT assessment is positive;
   - Cloud: the [EGI security Survey](https://survey.egi.eu/327232) was sent to
     the EGI CSIRT and the outcome was positive.

1. AAI:

   - HTC/Storage Compliant with X509 certificates and VOMS attributes
   - [OpenStack clouds integration with Check-in](../../cloud-compute/openstack/#egi-aai)
   - [General integration with Check-in for SPs](../../check-in/sp/)

1. Monitoring: the registered endpoints are automatically detected by
   [ARGO](../../../internal/monitoring) and monitored according to their type
   registered in the Configuration Database.

1. [Accounting](../../../internal/accounting): The accounting records are
   properly sent to the accounting repository and displayed by the
   [Accounting Portal](https://accounting.egi.eu/).

   - Accounting probes and [APEL SSM](https://github.com/apel/ssm) are properly
     installed and configured:
     - HTC: [APEL client](https://github.com/apel/apel)
     - Cloud: [cASO](https://github.com/IFCA/caso).

1. Information discovery:

   - HTC/Storage: the information about compute and storage endpoints are
     [published by the site-bdii into the Top-BDIIs](../../operations-manuals/man01_how_to_publish_site_information/).
   - Cloud: site is
     [added to the fedcloud-catchall-operations repository](../../cloud-compute/openstack/#catch-all-operations)

1. Middleware: latest version of technology products are installed using the
   [UMD](https://confluence.egi.eu/display/EGIBG/Unified+Middleware+Distribution)
   and
   [CMD](https://confluence.egi.eu/display/EGIBG/Cloud+Middleware+Distribution)
   releases.

1. Software distribution:
   - HTC (Optional): [CVMFS](https://github.com/cvmfs-contrib/egi-cvmfs)
   - Cloud: VM image synchronisation is configured with a HEPIX VM image list
     compliant software (e.g.
     [cloudkeeper](https://github.com/the-cloudkeeper-project/cloudkeeper))
