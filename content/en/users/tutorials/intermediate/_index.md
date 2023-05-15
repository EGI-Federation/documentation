---
title: Intermediate level
linkTitle: Intermediate
type: docs
weight: 20
description: >
  Tutorials for individual services from the EGI owned service portfolio,
  as well as services that are offered by the broader EGI community
  to complement the EGI services towards certain types of advanced computing use cases.
---

<!-- markdownlint-disable line-length no-inline-html -->

<table>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, developers, integrators and end users.
</td>
<td>
<i>"Data Management in EGI with Rucio and FTS" (October, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5711/">https://indico.egi.eu/event/5711/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/3lbr87TJzsk"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: <a href="https://rucio.cern.ch/">Rucio</a> is a data management software, originally developed
for ATLAS at CERN to supersede their previous data management software 10 years ago. Since then
Rucio has been constantly developed by ATLAS and other communities that have come to use Rucio,
ensuring that it is a feature rich, and well maintained open software.
<br/><br/>
Multi-VO Rucio implemented by the STFC in the UK hosts Rucio as a service for many communities.
This is to provide communities the opportunity to use Rucio for their data management solution,
without having to learn about, and host their own instance of Rucio.
<br/><br/>
FTS ( https://fts.web.cern.ch/fts/ ) is a low level data movement service, responsible for
reliable bulk transfer of files between storages. It’ s responsible for globally distributing
the majority of the LHC data across the WLCG infrastructure and it supports many communities is EGI.
<br/><br/>
In this webinar we introduce the main functionalities and show how to interact with the services
in order to schedule transfers.
<br/><br/>
<b>Suggested tutorials</b>
<ul>
<li><a href="../tutorials-adhoc/data-transfer-grid-storage/">Data transfer with grid storage</a>: Use EGI Data transfer to handle data in grid storage</li>
</ul>
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, developers, integrators and end users.
</td>
<td>
<i>"Using EGI Cloud infrastructure with fedcloudclient" (September, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5694/">https://indico.egi.eu/event/5694/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/atUswR3O9mQ"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: The FedCloud client is a high-level Python package for a command-line client
designed for interaction with the OpenStack services in the EGI infrastructure. The client
can access various EGI services and can perform many tasks for users including managing
access tokens, listing services, and mainly execute commands on OpenStack sites in EGI infrastructure.
<br/><br/>
The webinar will provide tutorial and demonstration of using fedcloudclient in EGI Cloud infrastructure.
<br/><br/>
<b>Suggested tutorials</b>
<ul>
<li><a href="../tutorials-adhoc/oidc-agent-fedcloudclient-terraform/">Automate with oidc-agent, fedcloudclient, terraform and Ansible</a>: Step by step guide to automating the deployment using Ansible with Terraform, oidc-agent and fedcloudclient</li>
</ul>
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, developers, IT service providers, and end users.
</td>
<td>
<i>"Using Dynamic DNS service in the EGI Cloud infrastructure" (June, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5559/">https://indico.egi.eu/event/5559/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/EWPMc1a7sow"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: Nowadays, more and more services are dynamically deployed in Cloud environments.
Usually, the services hosted on virtual machines in Cloud are accessible only via IP addresses
or pre-configured hostnames given by the target Cloud providers, making it difficult to provide
them with meaningful domain names.
<br/><br/>
The Dynamic DNS service provides a unified, federation-wide Dynamic DNS support for VMs in
EGI infrastructure. Users can register their chosen meaningful and memorable DNS host names
in given domains (e.g. my-server.vo.fedcloud.eu) and assign to public IPs of their servers.
By using Dynamic DNS, users can host services in EGI Cloud with their meaningful service names,
can freely move VMs from sites to sites without modifying server/client configurations (federated approach),
and can request valid server certificates in advance (critical for security).
<br/><br/>
The webinar will provide demonstration and tutorial, also practical advice on using Dynamic DNS
service in realistic user scenarios.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Developers and administrators of relying parties that want to connect
to Check-in for authenticating users and managing their access rights.
</td>
<td>
<i>"Providing controlled access to distributed resources and services with EGI Check-in:
the provider perspective"(May, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5494/">https://indico.egi.eu/event/5494/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/yUMPbehAND4"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: This webinar will help new services to integrate with Check-in,
the EGI Authentication & Authorisation Infrastructure enabling secure access
to relying parties. The target group of the training are developers and administrators
of services that want to connect to Check-in for user authentication and authorisation.
<br/><br/>
The training will showcase the use of the EGI Check-In Federation Registry tool for
managing the lifecycle of a relying party, i.e. registration, reconfiguration and
de-registration. The training will include hands-on sessions for the participants
to integrate their own relying party to Check-In.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities and IT-service providers who support
research and education.
</td>
<td>
<i>"Access and analyze data from the EGI DataHub with Jupyter notebooks and MATLAB" (May, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5499/">https://indico.egi.eu/event/5499/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/zT9aW1xHCJU"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: Good, clean data is hard to come by. The EGI provides scientists and
researchers access to a large collection of public datasets from data centres globally.
This data can be accessed using the EGI Jupyter Notebook service. MATLAB users can now
analyse this data using the familiar MATLAB desktop, via a web browser, on the EGI’s resources.
<br/><br/>
In this webinar, you will learn how to:
<ol>
<li>Use your MATLAB licence to login to the EGI MATLAB installation</li>
<li>Access data from the EGI DataHub</li>
<li>Read in scientific data into MATLAB</li>
<li>Analyse and visualise data using computational notebooks called MATLAB Live Scripts.</li>
<li>Share your MATLAB code with your peers.</li>
</ol>
<b>Suggested tutorials</b>
<ul>
<li><a href="../tutorials-adhoc/vm-datahub/">Access DataHub from a VM</a>: Use data in EGI DataHub from a virtual machine.</li>
<li><a href="../tutorials-adhoc/jupyter-datahub-virtual-machine/">Create a VM with Jupyter and DataHub</a>: Step by step guide to get a Virtual Machine for Jupyter and DataHub in your cloud provider</li>
</ul>
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities and IT-service providers.
</td>
<td>
<i>"Monitoring services with ARGO" (May, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5496/">https://indico.egi.eu/event/5496/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/By1XgcA-_5o"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: <a href="https://argo.egi.eu/">ARGO</a> is a lightweight
service for Service Level Monitoring designed for medium and large sized
Research Infrastructures. Services are monitored with probes compatible
with flexible and widely adopted Nagios plugin format. Besides basic availability
checks, services can be monitored by emulating typical user scenarios that allows
to derive the quality of service the actual user gets.
<br/><br/>
ARGO offers near real-time status updates which allow both end-users and site
admins to have an overview of the services offered at any given point in time
via a web user interface and via enriched email notifications. ARGO generates
custom Availability and Reliability reports based on the aggregated monitoring
data. The rich monitoring data collected in ARGO service is actually stored in
a highly flexible big data friendly form using state-of-the-art computational
pipelines and formats. This provides the ability to reuse & analyse the data in
different ways such as to highlight service usage patterns and provide a number
of trends and insights.
<br/><br/>
In this training session we are going to show the process we follow to monitor a
new service with ARGO. In addition, the real time computations and the results via
the alerts, API and UI will be shown.
<br/><br/>
ARGO is a service jointly developed and maintained by
<a href="http://www.cnrs.fr/en">CNRS</a>,
<a href="https://grnet.gr/en/">GRNET</a> and
<a href="https://www.srce.unizg.hr/en/">SRCE</a>.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, and programmers who support research and education.
</td>
<td>
<i>"Managing Singularity, Docker and udocker containers, Kubernetes clusters in the EGI Cloud" (April, 2021)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5492/">https://indico.egi.eu/event/5492/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/cZ3M47ON0pg"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: Containers provide a streamlined way to build, test, deploy,
and redeploy applications on different environments: from the developer’s
local machine to any cloud provider. Containers make it easy for developers
to package applications and for operators to manage and deploy those applications
on the infrastructure. Container orchestrators like Kubernetes facilitate the
management of containerized workloads and services, using declarative configuration
and automation. In this webinar we will introduce the different runtimes available
for executing containers in EGI infrastructure and will show how to manage Kubernetes
clusters to get your containers under control executed on EGI cloud providers.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Users and application experts of the EGI communities.
</td>
<td>
<i>"DIRAC Services for EGI users" (October, 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5267/">https://indico.egi.eu/event/5267/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/PyeGmjiN13A"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: DIRAC is a complete framework for building distributed computing systems
of any level of complexity. Initially developed for the LHCb High Energy Physics experiment
at the LHC collider at CERN, the framework was generalised for the use by multiple scientific
communities in various domains. Services based on the DIRAC software are offered by several
grid infrastructure projects such as France-Grilles or GridPP/UK. Since 2014, the DIRAC services
have also been provided for the EGI users. During the webinar, an overview of the DIRAC framework
will be presented together with a number of services offered to the users by EGI: how to manage
user jobs in the EGI infrastructure, how to connect custom computing and storage resources,
how to manage user data as well as automate regular tasks. Extending DIRAC with community
custom services will also be discussed.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: IT service providers, site and NGI operation managers (new member of staff).
</td>
<td>
<i>"EGI Operations and responsibilities of an NGI" (October 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5268/">https://indico.egi.eu/event/5268/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/rjNn9lyGOWI"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: This webinar will give an overview of tried and tested approaches to
federated operations, both at the level of the infrastructure as well as at the national
level. It will cover the most important aspects and day-to-day work covered by staff -
both at the international infrastructure level at EGI as well as at an example National Grid
Initiative (NGI). Example scenarios will be presented along with the tools used to deal with
the scenarios. Finally there will be an opportunity for questions and discussions arising
from the topics covered.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Site administrators and cluster administrators; CVMFS power users.
</td>
<td>
<i>"CernVM-FS for Containers" (October 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5251/">https://indico.egi.eu/event/5251/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/nwZj90i2us4"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: Delivering complex software stacks across a worldwide distributed system
is a challenge in high-throughput scientific computing. The global-scale virtual file
system CernVM-FS distributes more than a billion software binaries to hundreds of thousands
of machines around the world.
<br/><br/>
In this webinar, we will present the latest developments with regard to CernVM-FS container
integration. Containers and CernVM-FS team up nicely: containers provide the isolation
capabilities that decouple the application stack from the underlying platform and CernVM-FS
provides efficient distribution means for the containerized software binaries. Containers are
an enabling technology to harness opportunistic resources and HPC facilities. CernVM-FS enables
the use of such resources at scale. In this webinar, we will show how existing repositories can
be used with several popular container runtimes, such as docker, podman, singularity, and kubernetes.
We will also show how operating system containers themselves can be efficiently distributed through
CernVM-FS. Lastly, we will highlight an upcoming new way of publishing content from within a container.
This makes it easy to set up, build and test and deploy-to-cvmfs pipelines on kubernetes.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, and IT-service providers who support research and education.
</td>
<td>
<i>"The EGI Datahub to federate distributed data sets for data-intensive applications in the cloud" (June 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5089/">https://indico.egi.eu/event/5089/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/ayAplV2kEN4"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: The EGI DataHub allows users to make their data available using different
levels of access: from completely unrestricted open access to open data to authenticated
access to closed data sets. This is possible as a result of the seamless integration with
the EGI AAI service. The data hosted on the EGI DataHub can be readily accessible by cloud
Virtual Machines (VMs) or running grid jobs thanks to full integration with EGI Federated
Cloud and High-Throughput compute resources. The use of protocols such as POSIX and web
services guarantees easy and scalable access to data from cloud and HTC applications. This
ensures maximum compatibility with existing applications and minimum hassle for developers
and users alike. The EGI DataHub is built on top of the EGI Open Data Platform using Onedata
technology to connect a wide range of existing storage services, regardless of their underlying
technology (e.g. Lustre, Amazon S3, Ceph, NFS, or dCache).
<br/><br/>
During this webinar the QoS and hybrid cloud data processing scenarios for distributed EOSC
environments based on EGI DataHub and Onedata solutions will be introduced.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities and IT-service providers who operate IdP for them.
</td>
<td>
<i>"The EGI AAI Check-In service for scientific communities" (May 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5088/">https://indico.egi.eu/event/5088/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/erEAHqm19Qk"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: The EGI Check-in service (also called EGI AAI proxy) enables access to
EGI services and resources using federated authentication mechanisms. Specifically,
the proxy service is operated as a central hub between federated Identity Providers
(IdPs) residing ‘outside’ of the EGI ecosystem, and Service Providers (SPs) that are
part of EGI. The main advantage of this design principle is that all entities need to
establish and maintain technical and trust relation only to a single entity,
the EGI AAI proxy, instead of managing many-to-many relationships. In this context,
the proxy acts as a Service Provider towards the Identity Providers and as an Identity
Provider towards the Service Providers.
<br/><br/>
Through the EGI AAI proxy, users are able to authenticate with the credentials
provided by the IdP of their Home Organisation (e.g. via eduGAIN), as well as using
social identity providers, or other selected external identity providers (support for
eGOV IDs is also foreseen). To achieve this, the EGI AAI has built-in support for SAML,
OpenID Connect and OAuth2 providers and already enables user logins through Facebook,
Google, LinkedIn, and ORCID. In addition to serving as an authentication proxy, the
EGI AAI provides a central Discovery Service (Where Are You From – WAYF) for users to
select their preferred IdP.
<br/><br/>
The EGI AAI proxy is also responsible for aggregating user attributes originating
from various authoritative sources (IdPs and attribute provider services) and
delivering them to the connected EGI service providers in a harmonised and
transparent way. Service Providers can use the received attributes for authorisation
purposes, i.e. determining the resources the user has access to.
<br/><br/>
During this webinar we will give an overview about the service and provide
guidelines to support the resource providers’ and communities' needs for federated
access through the EGI AAI Check-In service. The webinar will also cover more advanced
workflows for addressing non-web-based access use cases (e.g. command line and API).
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Scientific communities, for programmers and IT-service providers who support research and education.
</td>
<td>
<i>"The EGI Notebooks service: Support for analytics and big data visualisation in the cloud" (May 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5087/">https://indico.egi.eu/event/5087/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/ed-oh4eCg0E"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: The EGI Notebooks service is an environment based on Jupyter and the
EGI cloud service that offers a browser-based, scalable tool for interactive data analysis.
The notebooks environment provides users with notebooks where they can combine text,
mathematics, computations and rich media output. The service, in production since late 2019,
is offered in two options: (i) Notebooks for researchers: EGI offers a basic instance of the
Notebooks as an open service. Any researcher can access this automatically to write and play
notebooks on limited capacity cloud servers. (ii) Notebooks for communities: EGI offers customised
Notebooks service to scientific communities. Such customised instances can be hosted on special
hardware (for example with fat nodes and GPUs), can offer special libraries, data import/export
and user authentication systems.
<br/><br/>
During the webinar Enol will go through the main features of the EGI Notebooks service and
he will explain how to use it with Binder and other open-source solutions to implement Open Science.
</td>
</tr>
<tr>
<td>
<b>Target Audience</b>: Researchers, and IT-service providers who support research and education.
</td>
<td>
<i>"Introduction of the EGI Cloud Compute service" (April 2020)</i>
<br/><br/>
Agenda, slides and recording: <a href="https://indico.egi.eu/event/5085/">https://indico.egi.eu/event/5085/</a>
<br/><br/>
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/lkJVV0OmweM"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  allowfullscreen>
</iframe>
<br/><br/>
<b>About</b>: The EGI Federated Cloud is a IaaS-type cloud, made of academic private
clouds and virtualized resources and built around open standards. Its development is
driven by requirements of the scientific community. The result is a new type of research
e-infrastructure, based on the mature federated operations services that make EGI a reliable
resource for science.
<br/><br/>
When using EGI Federated Cloud resources, researchers and research communities can
count on: a.) Total control over deployed applications, b.) Elastic resource consumption
based on real need, c.) Immediately processed workloads – no more waiting time,
d.) An extended e-Infrastructure across resource providers in Europe, and
e.) Service performance scaled with elastic resource consumption.
<br/><br/>
In this webinar an overview of the EGI Federated Cloud and how this scalable computing
platform can be used for data and/or compute driven research and/or support the development
of advanced services for research and science will be provided by Enol Fernandez. The webinar
will be relevant for researchers, and IT-service providers who support research and education.
<br/><br/>
<b>Suggested tutorials</b>
<ul>
<li><a href="../tutorials-adhoc/create-your-first-virtual-machine/">Create your first Virtual Machine (VM)</a>: Step by step guide to get your first Virtual Machine up and running</li>
<li><a href="../tutorials-adhoc/accessing-vm-with-ssh/">Accessing virtual machines with SSH</a>: Accessing virtual machines with SSH</li>
</ul>
</td>
</tr>
</table>
