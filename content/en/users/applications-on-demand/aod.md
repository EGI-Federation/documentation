---
title: "Applications on Demand (AoD)"
type: docs
weight: 10
description: >
  The Applications on Demand (AoD) service general information
---

The
[EGI Applications on Demand (AoD) service](https://www.egi.eu/services/applications-on-demand/)
is EGI's response to the requirements of researchers who are interested in using
applications in a on-demand fashion together with the compute and storage
environment needed to compute and store data.

You can order and access the service through the
[EGI Marketplace](https://marketplace.egi.eu).

## Service Description

The service allows user-friendly access to a portfolio of applications and
application hosting frameworks (e.g.: Science Gateways, VREs) that are
configured to use the dedicated pool of cloud computing clusters from our
providers. The service also allows users to run their own simulation/analysis
models with custom input data.

The service operates as an open and extensible 'hub' for providers and
e-infrastructure user support teams who wish to federated and share applications
and services with individual researchers, or small, fragmented communities,
typically referred to as 'the long tail of science'.

The portfolio of applications is currently composed by a readily available set
of applications relevant to different scientific and research areas. This
portfolio is open to be extended thanks to the contributions of users of the
service. If you are interested in this, please get in touch with us: support
(at) egi.eu

### Intended user groups

- Researchers and scientists.
- Application developers who want to share their applications available to the
  community through AoD.
- National e-Infrastructures who want to offer the EGI applications library to
  their national users by \"plugging\" compute and storage resources.

### Benefits

Through this service:

- **Researchers** can access applications underpinned by high-capacity compute
  and storage servers, to carry out compute and data-intensive simulations. Use
  of the service does not require advanced experience with distributed and/or
  cloud computing.
- **Developers** can integrate custom applications into the service and offer
  them as \'scalable, online services\' for researchers and scientists
  worldwide.
- **Providers** of compute and storage services can share their clusters and
  clouds to serve \'the long tail of science\'. For more information see
  [AoD for information providers](https://wiki.egi.eu/wiki/Applications_on_Demand_Service_-_information_for_providers).

### Service components

- **Scientific applications** that are offered 'as services' through graphical
  environments.
- **Science gateways** and **Virtual Research Environments (VREs)** that offer
  integrated development environments to port custom applications with cloud
  resources.
- **Cloud** compute resources suited for both compute/data intensive
  applications and for the hosting of scientific services.
- A network of **Consultants** and supporters who can provide guidance on the
  use of the service.

## Requirements and user registration

The service is open for any researchers, scientists and engineers who need a
simple and user-friendly access to compute, storage and applications services in
order to carry out data/compute intensive science and innovation. The user needs
to be affiliated with, or at least have a partnership (for example a referee)
with, a research institution in Europe to qualify for access.

Access **requires** acceptance of
[Acceptable Use Policy (AUP) and Conditions of the \'EGI Applications on Demand Service\'](https://documents.egi.eu/public/ShowDocument?docid=2635).

{{% alert title="Acknowledgment" color="info" %}}

Users of the service are asked to provide appropriate acknowledgement of the use
in scientific publications. The following acknowledgement text can be used for
this purpose:

**This work used the EGI Applications on Demand service, which is co-funded by
the EOSC-hub project (grant number 777536). The HNSciCloud project (grant
number 687614) is also sponsoring the service, allowing users to access the
HNSciCloud services pilot for limited scale usage using the voucher schemes
provided by the Exoscale contractor.** {{% /alert %}}

When requesting access to AoD users are guided through a lightweight
registration process. Members of the EGI support team will perform a lightweight
vetting process to validate the users\' requests before granting the access to
the resources.

### Service grant

Once granted access, each user will have a grant with a pre-defined quota of
resources, which can be used to run the application of choice. This grant
includes:

- up to 4 CPU cores,
- 8 GB of RAM,
- 100GB of block storage.

The grant to run applications is initially valid for 6 months and can be
extended/renewed upon request.

### How can you access the service?

1. Login to the [EGI Marketplace](https://marketplace.egi.eu) with the EGI AAI
   Check-In service.
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

## Application library

The service operates as an open modular environment where any application
developer can integrate and share applications, and providers can plug their own
data centre share.

### Computer Science & Mathematics

- [RStudio](https://www.rstudio.com/) (v3.2.2) is a free and open-source
  integrated development environment (IDE) for R, a programming language for
  statistical computing and graphics.

  Access via the
  [FutureGateway Science Gateway](https://fgsg.ct.infn.it/egissod/web/ssod/r-studio1).

- [Octave](https://www.gnu.org/software/octave/) is a high-level interpreted
  language, primarily intended for numerical computations. It provides
  capabilities for the numerical solution of linear and nonlinear problems, and
  for performing other numerical experiments.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

### Life Sciences

- [Chipster](http://chipster.csc.fi/) is a user-friendly analysis software for
  high-throughput data. It contains over 300 analysis tools for next generation
  sequencing (NGS), microarray, proteomics and sequence data. Users can save and
  share automatic analysis workflows, and visualize data interactively using a
  built-in genome browser and many other visualizations.

  Access via the
  [FutureCatania Science Gateway](https://fgsg.ct.infn.it/egissod/web/ssod/chipster-user-account-instructions).

- [Galaxy](https://galaxyproject.org/) is an open, web-based platform for data
  intensive biomedical research.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- [NAMD](http://www.ks.uiuc.edu/Research/namd/) is a parallel molecular dynamics
  code designed for high-performance simulation of large bio-molecular systems.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

### Tools

- [Docker](https://www.docker.com/) is an open-source project that automates the
  deployment of Linux applications inside software containers.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- [Hadoop](http://hadoop.apache.org/) is a framework that allows for the
  distributed processing of large data sets across clusters of computers using
  simple programming models.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- [Marathon](https://mesosphere.github.io/marathon)/[Chronos](https://github.com/mesos/chronos%20Chronos)
  orchestration and fault-tolerant scheduler that runs on top of Apache Mesos.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- [OSCAR](https://o-scar.readthedocs.io/) is a framework designed to efficiently
  support on-premises FaaS (Functions as a Service) for general-purpose file
  processing computing applications.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- [Kubernetes](https://kubernetes.io/) is an open-source container-orchestration
  system for automating application deployment, scaling, and management. Through
  this framework users can create a containerized version of workflows and
  services that can be deployed in the EGI Infrastructure.

  Access via the EC3 portal
  [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

- The [AppDB VMOps dashboard](https://dashboard.appdb.egi.eu/), a framework for
  performing Virtual Machine (VM) management operations on the EGI Federated
  Cloud. The graphical interfaces of the dashboard allows the user to choose VMs
  from the AppDB Catalogue, to define an execution topology for them, and then
  to instantiate them on infrastructure as service clouds.

  Access the [EGI VMOps dashboard](https://dashboard.appdb.egi.eu/vmops/).

## AoD portals/gateways

Applications of the service are accessed via the following portals/gateways:

### FutureGateway Science Gateway

The [FutureGateway Science Gateway (FGSG)](https://fgsg.ct.infn.it/) is a
programmable interface of a RESTful API Server, compliant with CSGF APIs
specifications, able to provide an easy access to the PaaS layer by leveraging
on recent Web technologies.

- The FGSG incorporates several applications and offers these \"as services\"
  for the user.
- The FGSG provides users with an intuitive web interface to execute docker
  applications on the cloud resources of the platform.
  - The FGSG take cares of starting the job in one of the available resources of
    the platform, of transferring the needed files (e.g. executable, input
    files, etc.) and downloading the output(s) in behalf of the users
- FGSG is open source and released under the Apache 2.0 license.

Access
[the FGSG integrated in the AoD](https://fgsg.ct.infn.it/egissod/web/ssod).

### EC3

[EC3](https://servproject.i3m.upv.es/ec3/) (Elastic Cloud Computing Cluster) is
a platform which allows to create elastic virtual clusters on top of
Infrastructure as a Service (IaaS) providers.

- The cluster, which is defined with a \'job wizard\' interface for the user, is
  composed by a front node, where a batch job scheduler is running, and a number
  of compute nodes.
  - These compute nodes will be dynamically deployed and provisioned to fit
    increasing load, and undeployed when they are in idle status.
- The list of application libraries/tools installed in the front-node can be
  exported via NFS in all the compute nodes.
- The installation and configuration of the cluster is performed by means of the
  execution of Ansible receipts.
- An Enterprise Linux OS is used for both the front-node and the compute nodes
  of the cluster.
- The cluster provided with AoD is personal - users have root-access to the
  environment, and can setup and configure the system to their needs. It is
  meant to be shut down when no longer needed.

Access the [EC3 portal](https://servproject.i3m.upv.es/ec3-ltos/index.php).

## References

Main scientific paper describing the service and status:

- [EGI Applications On Demand Service - Catering for the computational needs of the long tail of science](https://documents.egi.eu/document/3132)
  (May 2017).
  - [IWSG2017 Proceeding](http://ceur-ws.org/Vol-2363/paper9.pdf).

Presentations about the service:

- [Webinar to introduce the Applicatios on Demand (AoD)](https://www.egi.eu/blog/webinar-egi-applications-on-demand-service/)
  service to NGIs/USTs representatives, RI architects, resource providers and
  researchers (June 2017).
- [Slideset about the status report of the platform at the EGI Conference 2016](https://indico.egi.eu/indico/event/2875/session/35/contribution/89).
- [Slideset about the status report of the EGI platform at the DI4R Conference 2016](http://digitalinfrastructures.eu/content/serving-long-tail).
- [Overview of the EGI Infrastructure for serving the long tail](https://indico.egi.eu/indico/contributionDisplay.py?contribId=83&confId=2544)
  (EGI Community Forum, November 2015).
- [Poster and animated slides](https://indico.egi.eu/indico/contributionDisplay.py?contribId=124&confId=2544)
  from Demo at EGI Community Forum, November 2015 (Winner of best demo prize).
- [Slideset about the authentication and authorization model adopted](https://documents.egi.eu/document/2363)
  (from Nov. 2015).
- [Slideset about the concept of the EGI long-tail of science platform](https://documents.egi.eu/document/2358)
  (from Nov. 2014).
