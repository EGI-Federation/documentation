---
title: "HTC"
dlinkTitle: "High Throughput Compute"
type: docs
weight: 60
description: >
  EGI High Throughput Compute (HTC)
---
EGI High Throughput Compute service is provided by a distributed network of computing centres, accessible via a standard interface and membership of a Virtual Organisation.
### What is High Throughput Compute? 
High Throughput Compute (HTC) can be described as a use case for an infrastructure that includes a big number of tasks (that could be data analysis tasks, also computing jobs for analysing data or other similar tasks) that are submitted in big numbers and loosely coupled. They can be executed individually and don’t need to interact with each other (too much). Users usually submit these tasks to the infrastructure in a big number of them and once the jobs have been scheduled and executed in the distributed resources of the infrastructure, the user can collect the output from the services that have executed their jobs.

### The EGI HTC Infrastructure
EGI HTC infrastructure is the federation of GRID resources provided by EGI providers, that aims to share and federate in a secure way distributed IT resources as part of the EGI infrastructure. It comprises
- Computer resources -- execution environment of computing tasks in clusters distributed in many different resource centers over Europe and outside Europe ; 
- Data infrastructure -- storage servers where users can upload and download their data/files in a distributed manner in the different resource centers 
- Federated operations -- a set of federated operations that are constituted of global tasks (central activities/ services, e.g., AAI, accounting, helpdesk) that are needed to federate the heterogeneous resources from different resource centers and their operation activities that are carried out by the different NGIs. 
- User support --  NGIs also carry out user support. EGI.eu provides the central user support and coordinates NGIs’ support activities.

### Target Users 
The target customers for EGI HTC service are research communities who need to share, store, process, and produce large sets of data. Typically, their research collaborations involve different organizations across Europe and the world. They may already have local resources, for example, universities, and research institutions, and these local resources normally can only be accessed by local users, according to the organisational authentication rules and access policies. For example, university researchers can go to their IT department and ask for grant access to the university cluster. However, when researchers join collaborations that need to share their research activities, data collections, repositories among different organisations, they will need more homogenous and coordinated operation of the resources that are not currently uniformly accessible. In addition, nowadays, many researcher collaborations generate a big amount of data, and managing such big data is time consuming and error prone. 

EGI HTC not only provides the basic access to resources but also offers a set of high-level tools allowing users to manage a large amount of data in a collaborative, for example, there are authorization and access control tools that can be regulated by the research collaboration in a central manner and uniformly distributed in the distributed infrastructure. And there are also tools to handle and manage a big amount of data (to move data, to create data catalogs for the distributed datasets, to balance the execution workloads, etc.).

### Main features
EGI HTC provides easy access to shared computing and data services from independent resource providers in a uniform way optimizing usage.  Most software deployed in the distributed resources centers are based on open standards, and are open source middleware services. Resource access is based on Virtual Organisation (VO). VOs are fully managed by communities allowing them to manage their users and grant control access to their services and resources. In order to optimize the usage of the resources, users can have opportunistic usage of unused resources. This means users can either own their resources and use EGI services to federate them and have easy access to them or use the resources already available in the EGI infrastructure. The opportunity resources are not dedicated to the users’ organization, but since you are enabled in these resources as the part of the EGI infrastructure, you can access when the research centers have some spare resources. And in this way, the resource providers are also happy since their resources are used in a more efficient way.

In summary, the main feature of the EGI HTC service are as follows: 
- Access to high-quality computing resources
- Integrated monitoring and accounting tools to provide information about the availability and resource consumption
- Workload and data management tools to manage all computational tasks
- Large amounts of processing capacity over long periods of time
- Faster results for your research
- Shared resources among users, enabling collaborative research

### EGI HTC Architecture and the Access Models
#### Architecture and Service Components
![EGI HTC architecture](htc_archtecture.png)

Key Components:
- [Data Transfer Service (FTS)](../datatransfer/)
- [Storage Services](../online-storage/)
- _Computing Elements (CE)_: Computing resources are made available through GRID interfaces called Computing Elements. Several implementations of CE include, HTCondor, ARC-CE
