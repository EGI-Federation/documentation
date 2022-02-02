---
title: "STFC CVMFS Content Distribution Service"
type: docs
linkTitle: "CVMFS"
weight: 130
description: >
  Documentation for Content Managers of the CVMFS Stratum-0 instance at RAL
---

## Overview

This page is about the CVMFS service at RAL.

The CernVM-File System (CVMFS) provides a scalable, reliable and low-maintenance
software distribution service. It was developed to assist High Energy Physics 
collaborations to deploy software on the worldwide distributed computing 
infrastructure used to run data processing applications. CVMFS is implemented as
a POSIX read-only file system in user space. Files and directories are hosted on
standard web servers and mounted in the universal namespace /cvmfs. CernVM-FS 
uses outgoing HTTP connections only, thereby it avoids most of the firewall 
issues of other network file systems. It transfers data and meta-data on demand 
and verifies data integrity by cryptographic hashes. CVMFS is actively used by 
small and large collaborations.  In many cases, it replaces package managers and
shared software areas on cluster file systems as means to distribute the 
software used to process experiment data.

The STFC Scientific Computing Department at RAL maintains one of these single 
sources of data, or Stratum-0, for several communities:

- GridPP
- EGI
- IRIS

This documentation is for the VO content managers.

## Official CVMFS pages

- [CVMFS Documentation](https://cvmfs.readthedocs.io/en/latest/)
- [Q&As and Discussion Forum](https://cernvm-forum.cern.ch/)

## Request the creation of a new repository

In the case of a new repository for EGI, steps are described
[here](https://wiki.egi.eu/wiki/PROC22)

For non-EGI repositories, simply send a request to 
cvmfs-support@gridpp.rl.ac.uk

## Onboarding new Content Managers

Steps for a new VO Content Manager to be granted access to the Stratum-0 at RAL.

### Request access

Request access to the service sending an email to cvmfs-support@gridpp.rl.ac.uk 
In the email, include the following information:

- Name of the VO or CVMFS repository.
- Distinguish Name (DN) from your X509 grid certificate.

### Mailing list

All VO content managers should join the CVMFS-UPLOADER-USERS mailing list in 
[JISCMAIL](https://www.jiscmail.ac.uk/cgi-bin/webadmin?A0=cvmfs-uploader-users).

### Relevant documents

Read these documents:

- [PRIVACY NOTICE](https://www.scd.stfc.ac.uk/Pages/CVMFS-Privacy-Notice.aspx)
- [Acceptable Use Policy](https://www.scd.stfc.ac.uk/Pages/CVMFS-Acceptable-Use-Policy.aspx)

## Distributing new content

To login to the service, make sure you have a valid X509 proxy (with the same DN
provided [in this step](#request-access)), 
and execute the following command:

```shell
$ gsissh -p 1975 cvmfs-upload01.gridpp.rl.ac.uk
```
If you are the Content Manager for more than one repository, you would need to 
specify explicit which account you want to login to:

```shell
$ gsissh -p 1975 <myreposgm>@cvmfs-upload01.gridpp.rl.ac.uk
```
To copy data:

```shell
$ gsiscp -P 1975 <source> cvmfs-upload01.gridpp.rl.ac.uk:<destination>
```

After login, you will find a single directory in the home directory:

```shell
[myreposgm@cvmfs-uploader02 ~]$ ls
cvmfs_repo
```

Add to that directory the new content you want to distribute.

Files and directories cannot be distributed with CVMFS if they are not 
world-wide readable. You may want to ensure they have the right permissions with
the following commands:

```shell
$ find . -type d -exec chmod go+rx {} \;
$ find . -type f -exec chmod go+r {} \;
```

### Building your software

CVMFS is an infrastructure to distribute software world-wide. However, the 
uploader host should not be used for the purposes of building and compiling it
prior to distribution.

The right approach is for you to have your own local building environment, and
use the uploader host only to upload the new content for distribution.

If you have non-relocatable software, then you will need a 
/cvmfs/&lt;myrepo&gt;/ directory on your building host. One option is to use an
actual CVMFS client, so you have ready all the existing content being already 
distributed by CVMFS. 
By default, the /cvmfs/ directory on a CVMFS client host is read-only, but that 
can be solved using an 
[ephemeral writable container](https://cvmfs.readthedocs.io/en/latest/cpt-enter.html).
