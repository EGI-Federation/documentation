---
title: Resource Center Integration Check List
type: docs
---

This page provides an overview of what are the required steps to get a new
Resource Center integrated into the EGI Federation.

1. Be aware of the
   [security policies](https://wiki.egi.eu/wiki/EGI_CSIRT:Policies).

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

1. Monitoring: the several endpoints are properly detected by ARGO
   automatically, according to the information registered on the Configuration
   Database.

1. Support through the [EGI Helpdesk service](../../../internal/helpdesk):

   - The RC name is listed in the GGUS fields “Affected site” and “Notify Site”
   - The site administrators can modify and reply to the tickets assigned to
     their RC
     - The Supporter role can be requested either directly on GGUS by using the
       own X509 personal certificate or by enrolling to the ggus-supporters
       group in Check-in by using the federated identity.

1. Security:

   - HTC: pakiti is installed and the outcome of the EGI CSIRT assessment is
     positive;
   - Cloud: the EGI security Survey was sent to the EGI CSIRT and the outcome
     was positive.

1. AAI:

   - HTC/Storage Compliant with X509 certificates and VOMS attributes
   - [OpenStack clouds integration with Check-in](../../cloud-compute/openstack/#egi-aai)
   - [General integration with Check-in for SPs](../../check-in/sp/)

1. Accounting: The accounting records (HTC, Storage, Cloud) are properly sent to
   the accounting repository and displayed by the Accounting Portal

   - APEL Client, APEL SSM, cASO, any other software compliant with the EGI
     Accounting service is properly installed and configured.

1. Information discovery:

   - HTC/Storage: the information about compute and storage endpoints are
     published by the site-bdii into the Top-BDIIs.
   - Cloud: site is added to the fedcloud-catchall-operations repository

1. Middleware: latest version of technology products are installed using the
   UMD/CMD release.

1. Software distribution:
   - HTC: CVMFS
   - Cloud: VM image synchronisation is configured with a HEPIX VM image list
     compliant software (e.g. cloudkeeper)
