---
title: Software Distribution
linkTitle: Software Distribution
type: docs
weight: 70
description: >
  Software distribution in the EGI infrastructure
aliases:
  - /users/compute/content-distribution
---

This page documents usage the CernVM-FS (CVMFS) service operated for EGI by UKRI-STFC.

## Overview

The CernVM-File System (CVMFS) provides a scalable, reliable and low-maintenance
software distribution service. It was developed to assist High Energy Physics
collaborations to deploy software on the worldwide distributed computing
infrastructure used to run data processing applications. CVMFS is implemented as
a POSIX read-only file system in user space. Files and directories are hosted on
standard web servers and mounted in the universal namespace `/cvmfs`. CernVM-FS
uses outgoing HTTP connections only, thereby it avoids most of the firewall
issues of other network file systems. It transfers data and metadata on demand
and verifies data integrity by cryptographic hashes. CVMFS is actively used by
small and large collaborations. In many cases, it replaces package managers and
shared software areas on cluster file systems as means to distribute the
software used to process experiment data.

The current list of EGI repositories is as follows (disclaimer, some of them are inactive, but we keep them for archival purposes):

| Repository                    | Project's URL |
|-------------------------------|---------------|
| auger.egi.eu                  |               |
| biomed.egi.eu                 | https://vip.creatis.insa-lyon.fr/home.html |
| cernatschool.egi.eu           |               |
| chipster.egi.eu               |               |
| comet.egi.eu                  |               |
| config-egi.egi.eu             |               |
| dirac.egi.eu                  | https://dirac.readthedocs.io/en/latest/ |
| eiscat.egi.eu                 |               |
| eosc.egi.eu                   |               |
| extras-fp7.egi.eu             |               |
| galdyn.egi.eu                 |               |
| ghost.egi.eu                  |               |
| glast.egi.eu                  |               |
| gridpp.egi.eu                 |               |
| hyperk.egi.eu                 |               |
| intertwin.egi.eu              |               |
| km3net.egi.eu                 | https://www.km3net.org/ |
| ligo.egi.eu                   |               |
| lucid.egi.eu                  |               |
| mice.egi.eu                   |               |
| na62.egi.eu                   |               |
| neugrid.egi.eu                |               |
| notebooks.egi.eu              | https://notebooks.egi.eu |
| pheno.egi.eu                  |               |
| phys-ibergrid.egi.eu          |               |
| pravda.egi.eu                 |               |
| researchinschools.egi.eu      |               |
| seadatanet.egi.eu             |               |
| snoplus.egi.eu                | https://snoplus.phy.queensu.ca |
| solidexperiment.egi.eu        |               |
| supernemo.egi.eu              |               |
| t2k.egi.eu                    |               |
| unpacked.egi.eu               |               |
| wenmr.egi.eu                  |               |
| west-life.egi.eu              |               |



This documentation is for the VO content managers.

## Official CVMFS pages

- [CVMFS Documentation](https://cvmfs.readthedocs.io/en/latest/)
- [Q&As and Discussion Forum](https://cernvm-forum.cern.ch/)

## Requesting the creation of a new repository

In the case of a new repository for EGI, steps are described
[in PROC22](https://ims.egi.eu/display/EGIPP/PROC22+Support+for+CVMFS+replication+across+the+EGI+Infrastructure).

## Onboarding new Content Managers

Steps for a new VO Content Manager to be granted access to the Stratum-0.

### Requesting access

Request access to the service sending an email to cvmfs-support@gridpp.rl.ac.uk
In the email, include the following information:

- Name of the VO or CVMFS repository.
- Your [Check-in ID](../../../providers/check-in/sp/#1-community-user-identifier)
  from [EGI Check-in](../../aai/check-in/).

### Mailing list

All VO content managers should join the CVMFS-UPLOADER-USERS mailing list in
[JISCMAIL](https://www.jiscmail.ac.uk/cgi-bin/webadmin?A0=cvmfs-uploader-users).

## Distributing new content

To log into the service, just use `ssh` to log into the Uploader host. It's hostname is `cvmfs-uploader-egi.gridpp.rl.ac.uk`. Also, to maintain backwards compatibility, the alias `cvmfs-upload01.gridpp.rl.ac.uk` can be used. 
You need to specify explicitly which username you want to use to log in.
The username is composed as `reponame+"sgm"`.
For example, for the repository `dirac.egi.eu`, the username is `diracsgm`.

```shell
# Replace with the proper username
$ ssh diracsgm@cvmfs-upload01.gridpp.rl.ac.uk
```

To copy data:

```shell
# Replace with the proper username
$ scp source_file.txt diracsgm@cvmfs-upload01.gridpp.rl.ac.uk:destination_folder/
```

When running the `ssh` or `scp` commands, a message like this is displayed:

```shell
# Replace with the proper username
$ ssh diracsgm@cvmfs-upload01.gridpp.rl.ac.uk
Authenticate at
-----------------
https://aai.egi.eu/device?user_code=AAAAA-BBBBB
-----------------
Hit enter when you have finished authenticating
```

Copy and paste the URL into a browser, and follow the instructions to authenticate
yourself using your home institution Identity Management Service.

After login, you will find a single directory in the home directory:

```shell
$ ls
cvmfs_repo
```

Add the new content you want to distribute into that directory.


### Building your software

CVMFS is an infrastructure to distribute software world-wide. However, the
uploader host should not be used for the purposes of building and compiling it
prior to distribution.

The right approach is for you to have your own local building environment, and
use the uploader host only to upload the new content for distribution.

If you have non-relocatable software, then you will need a `/cvmfs/<myrepo>/`
directory on your building host. One option is to use an actual CVMFS client, so
you have ready all the existing content being already distributed by CVMFS. By
default, the `/cvmfs/` directory on a CVMFS client host is read-only, but that
can be solved using an
[ephemeral writable container](https://cvmfs.readthedocs.io/en/latest/cpt-enter.html).
