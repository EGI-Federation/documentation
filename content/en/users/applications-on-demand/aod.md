---
title: "Applications on Demand (AoD)"
type: docs
weight: 10
description: >
  The Applications on Demand (AoD) service general information
---

The [EGI Applications on Demand (AoD)
service](https://www.egi.eu/services/applications-on-demand/) is EGI's
response to the requirements of researchers who are interested in using
applications in a on-demand fashion together with the compute and
storage environment needed to compute and store data.

You can order and access the service through the [EGI
Marketplace](https://marketplace.egi.eu).

## Service Description

The service combines compute and storage cloud with Application-development 
and hosting frameworks to run custom scientific applications, and/or 
to turn those into applications into online data analysis services that 
can be accessed by scientists worldwide.

The portfolio of applications is currently composed by a readily
available set of applications relevant to different scientific and
research areas. This portfolio is open to be extended thanks to the
contributions of users of the service. If you are interested in this,
please get in touch with us: support (at) egi.eu

### Intended user groups

The main target groups of this service are:
-   Application developers who want to make their applications and tools 
    accessible in a scalable way for researchers internationally.
-   Algorithm developers (researchers) who want to run their own codes 
    at scale in a compute cloud. 
    
The main target groups of the applications that are already hosted in this 
service are:

-   Researchers and innovators who want to run a specific scientific 
    application that is already available in the platform.

### Scientific applications

The scientific applications that are already available in this service are: 

-   [**Chipster**](https://marketplace.egi.eu/applications-on-demand/68-chipster.html) 
    a user-friendly analysis software for high-throughput data. It contains over 300 
    analysis tools for next generation sequencing (NGS), microarray, proteomics and 
    sequence data. The application is available through the Science Software on Demand 
    Service (SSoD). Instructions to run the application are available [here]
    (https://egi-federated-cloud.readthedocs.io/en/latest/aod/chipster.html).
    
-   [**NAMD**](https://marketplace.egi.eu/applications-on-demand/58-namd.html) 
    a parallel molecular dynamics code designed for high-performance simulation of 
    large bio-molecular systems. The application is available through the EC3 portal. 
    
-   [**ECAS**](https://marketplace.egi.eu/applications-on-demand/84-ecas.html)
    a complete environment enabling data analysis experiments from the ENES Climate 
    Analytics Service.

The service includes:

-   **Cloud compute** and **storage [resources]**(https://documents.egi.eu/public/ShowDocument?docid=2773) 
    to host and scale up scientific applications.

-   **Cloud access and application-hosting frameworks** 
    (to run and to operate your own scientific application in the cloud environment):
    that offer integrated development environments to port custom
    applications with cloud resources.
    
-   **[VMOps dashboard]:**(https://dashboard.appdb.egi.eu/vmops) 
    a graphical environment for the management of Virtual Machines (VM) in the 
    federated network of clouds that enable the Applications on Demand service.
    User documentation is available [here](https://wiki.appdb.egi.eu/main:faq:what_is_the_vmops_dashboard). 
    
-   **[Elastic Cloud Compute Cluster (EC3)]:**(https://servproject.i3m.upv.es/ec3-ltos/index.php) 
    a portal that allows the creation of elastic virtual clusters in the cloud. Those clusters can then 
    host your scientific application either directly, or via Apache Mesos, Chronos, Kubernetes, Marathon, 
    [OSCAR](https://github.com/grycap/oscar) or SLURM. 
    Instructions for application developers are available [here]
    (https://wiki.egi.eu/wiki/Applications_on_Demand_Service_-_information_for_developers#How_to_integrate_a_new_application_in_EC3).

-   **[Science Software on Demand (SSoD)]:**(https://fgsg.ct.infn.it/egissod/web/ssod) 
    a programmable interface of a RESTful API Server to provide an easy access PaaS layer by leveraging 
    recent Web technologies. Instructions for application developers are available [here]
    (https://wiki.egi.eu/wiki/Applications_on_Demand_Service_-_information_for_developers#How_to_integrate_a_new_application_in_the_FutureGateway_Science_Gateway)


## Requirements and user registration

The service is open for any scientific software developer who needs a 
scalable and user-friendly application execution and hosting environment 
to offer data/compute intensive scientific applications online.

Access **requires** acceptance of [Acceptable Use Policy (AUP) and
Conditions of the \'EGI Applications on Demand
Service\'](https://documents.egi.eu/public/ShowDocument?docid=2635).

{{% alert title="Acknowledgment" color="info" %}}

Users of the service are asked to provide appropriate acknowledgement of
the use in scientific publications. The following acknowledgement text
can be used for this purpose:

**This work used the EGI Applications on Demand service, which is
co-funded by the EOSC-hub project (grant number 777536). The HNSciCloud
project (grant number 687614) is also sponsoring the service, allowing
users to access the HNSciCloud services pilot for limited scale usage
using the voucher schemes provided by the Exoscale contractor.**
{{% /alert %}}

When requesting access to AoD users are guided through a lightweight
registration process. Members of the EGI support team will perform a
lightweight vetting process to validate the users\' requests before
granting the access to the resources.

### Service grant

Once granted access, each user will have a grant with a pre-defined
quota of resources, which can be used to run the application of choice.
This grant includes:

-   up to 4 CPU cores,
-   8 GB of RAM,
-   100GB of block storage.

The grant to run applications is initially valid for 6 months and can be
extended/renewed upon request.

### How can you access the service?

1.  Login to the [EGI Marketplace](https://marketplace.egi.eu) with the
    EGI AAI Check-In service.
1.  Setup a profile, including details about your affiliation and role
    within a research institute/project/team.
1.  Navigate the marketplace top-menu and click on the category:
    **Applications**.
1.  Click on the **Applications on Demand** service and submit an order
    for one of the available applications.
1.  When the request is approved, run the requested application(s) as
    described below.

Please check the [EGI Marketplace
guide](https://wiki.egi.eu/wiki/HowToAccessTheEGIMarketPlace) for
further details.


## References

Main scientific paper describing the service and status:

-   [EGI Applications On Demand Service - Catering for the computational
    needs of the long tail of
    science](https://documents.egi.eu/document/3132) (May 2017).
-   [IWSG2017 Proceeding](http://ceur-ws.org/Vol-2363/paper9.pdf).

Presentations about the service:

-   [Slideset about the Applications on Demand (AoD) service introduced at IWSG 2017]
    (http://iwsg2017.psnc.pl/programme/) (June 2017).
-   [Webinar to introduce the Applicatios on Demand
    (AoD)](https://www.egi.eu/blog/webinar-egi-applications-on-demand-service/)
    service to NGIs/USTs representatives, RI architects, resource
    providers and researchers (June 2017).
-   [Slideset about the status report of the platform at the EGI
    Conference
    2016](https://indico.egi.eu/indico/event/2875/session/35/contribution/89).
-   [Slideset about the status report of the EGI platform at the DI4R
    Conference
    2016](http://digitalinfrastructures.eu/content/serving-long-tail).
-   [Overview of the EGI Infrastructure for serving the long
    tail](https://indico.egi.eu/indico/contributionDisplay.py?contribId=83&confId=2544)
    (EGI Community Forum, November 2015).
-   [Poster and animated
    slides](https://indico.egi.eu/indico/contributionDisplay.py?contribId=124&confId=2544)
    from Demo at EGI Community Forum, November 2015 (Winner of best demo
    prize).
-   [Slideset about the authentication and authorization model
    adopted](https://documents.egi.eu/document/2363) (from Nov. 2015).
-   [Slideset about the concept of the EGI long-tail of science
    platform](https://documents.egi.eu/document/2358) (from Nov. 2014).
