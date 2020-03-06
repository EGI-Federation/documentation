---
title: "Training Infrastructure"
type: docs
weight: 100
description: >
  The training infrastructure on EGI Cloud 
---

The training infrastructure is a resource pool within the EGI Federated
Cloud infrascture providing IaaS as well ass access services (login,
application catalogue and application management portal) for
face-to-face events, online training courses or self-paced learning
modules.

The training infrastructure is integrated with Check-in allowing
trainers to generate short-lived user accounts for training
participants. Such accounts can identify students individually, and for
a limited lifetime - typically few hours or days, depending on the
length of the training event - allow them to interact with the services.

The infrastructure currently includes enough capacity to scale up to
class-room size audiences, approximately up to 100 participants.

[An introductory slideset and poster of the
infrastructure](https://indico.egi.eu/indico/contributionDisplay.py?contribId=122&confId=2544)
from EGI Community Forum 2015, Bari. (Outdated in some parts).

## Usage models

The training infrastructure is suitable for two types of courses:

-   Cloud computing courses: Such courses teach students about IaaS
    clouds and on how Virtual Appliances, Virtual Machines, block
    storage and other types of 'low level' resources are managed. For
    such courses, the trainer does not need to deploy applications or
    online services in advance of the course. The applications/services
    will be deployed by the students themselves as training exercises.
    Such courses typically target developers or other rather technical
    members of scientific communities or projects.
-   Scientific courses: Such courses teach scientists or developers
    about a specific software suite relevant for their work. For example
    a specific gene sequence analysis application, an earthquake
    visualisation tool, or a data processing pipeline. In this
    operational mode, the trainer deploys the domain specific
    application/tool on the training infrastructure before the training
    and the students interact directly with those applications/tools
    without even knowing where those are deployed and running. Depending
    on how computationally or data intensive the exercises are, multiple
    students may share a single software deployment instance, or each
    student can have their own. The configuration can be controlled by
    the trainer when the setup is deployed.

In both cases the deployment of applications/tools/services can happen
in the form of 'Virtual Appliances' (VAs), and block storage - the
latter basically behaving like a virtual USB drive that can be
attached/detached to VMs to provide data and storage space for
applications.

The AppDB has a growing catalogue of Virtual Appliances that includes
both basic applications (e.g. latest version of clean Linux
distribution) and more specialised applications (e.g. Jupyter Notebook).
The list of VAs available on the training infrastructure is configurable
and listed in the [training.egi.eu VO entry of
AppDB](https://appdb.egi.eu/store/vo/training.egi.eu).

The VMOps can be used as web interface for both trainers and students to
deploy and manage VMs.

## Available resources

The available resources are offered by a set of providers included in
the [training.egi.eu VO Operation Level Agreement
(OLA)](https://documents.egi.eu/document/2768). Check the document for
the exact amount of resources and conditions of access for each
provider.

{{% alert title="Join the training infrastructure!" color="info" %}}

Do you want to join as a resource provider? Please email at
`support _at_ egi.eu`.
{{% /alert %}}

The list of providers and VAs is also discoverable in the
[training.egi.eu VO entry of
AppDB](https://appdb.egi.eu/store/vo/training.egi.eu). The VO is also
described at the [EGI Operations Portal training.egi.eu VO id
card](http://operations-portal.egi.eu/vo/view/voname/training.egi.eu).

## Modules and examples

The training infrastructure was used in July 2015 for two face-to-face
training courses that trained programmers about the use of the EGI Cloud
(the first operational model above). The focus of these courses was on
the use of the rOCCI client to interact with the providers (instantiate,
delete, access VMs). During these courses the training infrastructure
included three providers (CESNET, BIFI, UKIM) and hosted approx. 25
student per event. Before each event the trainers prepared a basic VM
that included the rOCCI client (with the training VO pre-configured in
it), one user account for each student with a short-term certificate
copied under each (with 24h lifetime). One instance of the VM was
started on the infrastructure by the trainers before the event and the
students were provided with login details for the user accounts. After
logging in the students could use the OCCI commands of the rOCCI client
with their own short-term certificates and could manage virtual machines
on the 3 providers.

The presentations and hands-on materials from the events are available
here:

-   [EGI Federated Cloud tutorial package (Software Carpentry Bootcamp,
    17 July 2015 Feltham, London,
    UK)](https://documents.egi.eu/document/2551).
-   [EGI Federated Cloud tutorial package (HPCS 2015 conference, 20-24
    July 2015, Amsterdam, NL)](https://documents.egi.eu/document/2553).
-   [EGI Federated Cloud for users (Training for MTA SZTAKI, 14 October
    2015, Budapest, HU)](https://documents.egi.eu/document/2622).
-   [Next Generation Sequencing Analysis Training Workshop (21 October,
    2015, Thessaloniki, GR)](https://documents.egi.eu/document/2641).
-   [Tutorials at the EGI Community Forum (10-12 November 2015, Bari,
    IT)](https://indico.egi.eu/indico/internalPage.py?pageId=7&confId=2544).
    -   Introduction to the EGI Federated Cloud -- the user perspective
    -   Dos and Don\'ts for Virtual Appliance Preparation
    -   DIRAC Service tutorial
    -   Running Chipster data analysis platform in EGI Federated Cloud
    -   NGS Data Analysis Training Workshop
    -   Programming Distributed Computing Platforms with COMPSs
    -   A Tutorial on Hybrid Data Infrastructures: D4Science as a case
        study
-   EGI Technical Support for ENVRI+ Use Cases Workshop (May 2016,
    Zandvoord, NL).
-   [Running CHIPSTER, Galaxy, Jupyter Notebook on the EGI Federated
    Cloud (ELIXIR-FI workshop)](https://documents.egi.eu/document/2822).
-   [EGI Federated Cloud for developers (DI4R, 28 September 2016,
    Krakow,
    PL)](https://www.digitalinfrastructures.eu/content/egi-federated-cloud-developers).
-   [UberCloud - EGI webinar: Cloud for SMEs in CAE -- OpenFOAM demo (20
    October 2016)](https://www.egi.eu/blog/egi-and-ubercloud-webinar-for-smes-cae-openfoam-demo-20oct2016/);
    [Webinar recording](https://www.youtube.com/watch?v=DU6LghOtrFs&feature=youtu.be).
-   [EGI training (ENVRIplus week, 14-18 November 2016, Prague,
    CZ)](https://documents.egi.eu/document/3005).
-   [MEDGENET-Workshop INAB (15 December 2016, Thessaloniki,
    GR)](http://tinyurl.com/medgenet).
-   [Cloud Tutorial at EUDAT summer School (03-07 July 2017, Heraklion,
    GR)](https://www.eudat.eu/eudat-summer-school).
-   [CODATA-RDA Research Data Science Summer School (21 July, 2017,
    Trieste, IT)](https://documents.egi.eu/document/3168).
-   [Scipion tutorial on Cloud (17-19 January 2017, Madrid,
    ES)](http://i2pc.es/instruct-course-on-image-processing-for-electron-microscopy-in-the-cloud-madrid-january-17-19-2018/).
-   [CODATA-RDA Research Data Science Summer School (17 August 2018,
    Trieste,
    IT)](https://documents.egi.eu/public/ShowDocument?docid=3349).
-   [NGSchool 2018](https://ngschool.eu/).
-   [3rd Int\'l Summer School on Data Science
    (SSDS 2018)](https://sites.google.com/site/ssdatascience2018/).
-   [Training for PhD students at the University of Genoa (04
    June 2019)](http://dottorato.dicca.unige.it/eng/schede_corsi_2019/eScience%20new%20information%20technologies%20for%20research.pdf).
-   [Introduction to Jupyter and Open Science - Training (27 September
    2019, Yervan)](http://go.egi.eu/eapec2019).

## Booking the infrastructure

The infrastructure currently includes enough capacity to scale up to
class-room size audiences, approximately up to 100 participants.

Do you want to book the infrastructure for a course? Please send a
request through <https://www.egi.eu/services/training-infrastructure/>
