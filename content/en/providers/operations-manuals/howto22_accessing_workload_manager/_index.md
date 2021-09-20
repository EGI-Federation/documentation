---
title: HOWTO22
weight: 130
type: "docs"
description: "Asking the access to the Workload Manager service"
---

The glite-WMS service is going to be dismissed at the end of 2017 and
all the servers provided by the NGIs will be decomissioned in January
2018. The suggestion to all the glite-WMS users is moving to DIRAC, a
service that offers features very similar to the glite-WMS ones.

EGI provides a central DIRAC server (DIRAC4EGI) for the Virtual
Organisations that need a Workload Management System for their daily
activities. If your VO is willing to use it or simply to evaluate how
much it fits your needs, please contact EGI Operations by opening a GGUS
ticket and the DIRAC4EGI server will be set-up for your VO.

## Users registration in DIRAC

**Important for VO managers**: please agree with the DIRAC team how many
users you want to register and how (few selected users or anyone in the
VO).

DIRAC can register automatically the users by querying the VOMS server.
Here what can help greatly in the automatic user registration procedure.

In DIRAC registered users are getting a short login name: it is unique
and will show up in various places ( in monitoring, authentication, etc
). You can think of it as of a unix login name. In VOMS you can define
for each user an attribute "**nickname**" that DIRAC can pick up as user
name in its context. Otherwise, if nickname is not defined, DIRAC will
try to generate some "reasonable" name that can or can not be
satisfactory for the users. One more important point about the user
nickname is that if a user later changes one's certificate (which will
certainly happen for some of your users eventually) but not the
nickname, then DIRAC will know that this is not a new user but just a
certificate change. This helps a lot the automation of the user
registration.

## Using DIRAC through the client

In the following sections you will see how to install the DIRAC client
on your UI, how to get a proxy through DIRAC, and how to submit (simple)
jobs compared to the glite-WMS case.

You can find more detailed infornation on the [DIRAC User
Guide](http://dirac.readthedocs.io/en/latest/UserGuide/index.html).

### DIRAC client installation

The generic installation and configuration of the client is shown in the
[DIRAC official
documentation](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/ClientInstallation/index.html).
We are reporting here the client installation using the EGI default
configuration.

  - Download the DIRAC installation script:

`$ mkdir DIRAC`
`$ cd DIRAC/`
`$ wget -O dirac-install `<https://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/dirac-install>
`--2018-07-19 10:39:26--  `<https://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/dirac-install>
`Resolving lhcbproject.web.cern.ch (lhcbproject.web.cern.ch)... 188.184.65.125, 188.184.67.62`
`Connecting to lhcbproject.web.cern.ch (lhcbproject.web.cern.ch)|188.184.65.125|:443... connected.`
`HTTP request sent, awaiting response... 200 OK`
`Length: 53970 (53K) [text/plain]`
`Saving to: ‘dirac-install’`

`dirac-install                           100%[=============================================================================>]  52.71K   316KB/s    in 0.2s`

`2018-07-19 10:39:27 (316 KB/s) - ‘dirac-install’ saved [53970/53970]`

`$ chmod +x dirac-install`

  - DIRAC team prepared default settings for the VOs that requested to
    use the service. Run the script using the EGI defualt configuration:

`$ ./dirac-install -V egi`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Processing installation requirements`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Destination path for installation is /home/paolini/DIRAC`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Discovering modules to install`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Installing modules...`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Installing COMDIRAC:v0r12`
`2016-11-03 10:32:55 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/COMDIRAC-v0r12.tar.gz>
`2016-11-03 10:32:56 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/COMDIRAC-v0r12.md5>
`2016-11-03 10:32:56 UTC dirac-install [NOTICE]  Installing DIRAC:v6r14p4`
`2016-11-03 10:32:56 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/DIRAC-v6r14p4.tar.gz>
`2016-11-03 10:32:57 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/DIRAC-v6r14p4.md5>
`2016-11-03 10:32:57 UTC dirac-install [NOTICE]  Deploying scripts...`
`  Scripts will be deployed at /home/paolini/DIRAC/scripts`
`  Inspecting DIRAC module`
`  Inspecting COMDIRAC module`
`2016-11-03 10:32:57 UTC dirac-install [NOTICE]  Installing client externals...`
`2016-11-03 10:32:58 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/Externals-client-v6r3p2-Linux_x86_64_glibc-2.12-python27.tar.gz>
`2016-11-03 10:32:59 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/Externals-client-v6r3p2-Linux_x86_64_glibc-2.12-python27.md5>
`2016-11-03 10:33:03 UTC dirac-install [NOTICE]  Fixing externals paths...`
`2016-11-03 10:33:04 UTC dirac-install [NOTICE]  Running externals post install...`
`2016-11-03 10:33:04 UTC dirac-install [NOTICE]  Retrieving `<http://lhcbproject.web.cern.ch/lhcbproject/dist/Dirac_project/installSource/>`../lcgBundles/DIRAC-lcg-2015-07-09-Linux_x86_64_glibc-2.12-python27.tar.gz`
`2016-11-03 10:33:28 UTC dirac-install [NOTICE]  Executing /home/paolini/DIRAC/scripts/dirac-fix-mysql-script...                                                                        `
`2016-11-03 10:33:35 UTC dirac-install [NOTICE]  Creating /home/paolini/DIRAC/bashrc`
`2016-11-03 10:33:35 UTC dirac-install [NOTICE]  Creating /home/paolini/DIRAC/cshrc`
`2016-11-03 10:33:36 UTC dirac-install [NOTICE]  Defaults written to defaults-egi.cfg`
`2016-11-03 10:33:36 UTC dirac-install [NOTICE]  Executing /home/paolini/DIRAC/scripts/dirac-externals-requirements...`
`2016-11-03 10:33:38 UTC dirac-install [NOTICE]  egi properly installed`
` `
`[paolini@test13 DIRAC]$ ls -ltr`
`total 100`
`-rwxrwxr-x  1 paolini paolini 53970 Aug 28  2012 dirac-install`
`-rw-r--r--  1 paolini paolini   722 Jul  9  2015 version-2015-07-09.txt`
`drwxr-xr-x 10 paolini paolini  4096 Jul  9  2015 Linux_x86_64_glibc-2.12`
`drwxr-xr-x  3 paolini paolini  4096 Oct 29 22:41 COMDIRAC`
`drwxr-xr-x 15 paolini paolini  4096 Nov  3 11:33 DIRAC`
`-rw-rw-r--  1 paolini paolini   918 Nov  3 11:33 cshrc`
`-rw-rw-r--  1 paolini paolini  1111 Nov  3 11:33 bashrc`
`drwxrwxr-x  2 paolini paolini 12288 Nov  3 11:33 scripts`
`-rw-rw-r--  1 paolini paolini   296 Nov  3 11:33 defaults-egi.cfg`

  - Once the client software is installed, it should be configured in
    order to access the DIRAC4EGI service:

`$ source bashrc`

  - To proceed further a temporary proxy of the user certificate should
    be created. This is necessary to get information from the central
    Configuration Service

`$ dirac-proxy-init -x `
`Generating proxy...`
`Enter Certificate password:`
`...`
` `

  - Now the client can be configured to work in conjunction with the
    DIRAC4EGI service

`$ dirac-configure defaults-egi.cfg `
`Executing: /home/paolini/DIRAC/DIRAC/Core/scripts/dirac-configure.py defaults-egi.cfg  `
`Checking DIRAC installation at "/home/paolini/DIRAC" `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/vo.formation.idgrilles.fr/cclcgvomsli01.in2p3.fr.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/vo.formation.idgrilles.fr `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/eli-beams.eu/voms1.egee.cesnet.cz.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/eli-beams.eu/voms2.grid.cesnet.cz.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/eli-beams.eu `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/vlemed/voms.grid.sara.nl.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/vlemed `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/hungrid/grid11.kfki.hu.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/hungrid `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/eng.vo.ibergrid.eu/voms01.ncg.ingrid.pt.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/eng.vo.ibergrid.eu `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/compchem/voms-01.pd.infn.it.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/compchem/voms.cnaf.infn.it.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/compchem `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/enmr.eu/voms-02.pd.infn.it.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/enmr.eu/voms2.cnaf.infn.it.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/enmr.eu `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/eiscat.se/voms1.grid.cesnet.cz.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/eiscat.se/voms2.grid.cesnet.cz.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/eiscat.se `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/training.egi.eu/voms1.egee.cesnet.cz.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/training.egi.eu/voms2.grid.cesnet.cz.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/training.egi.eu `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/vo.plgrid.pl/voms.cyf-kr.edu.pl.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/vo.plgrid.pl `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/fedcloud.egi.eu/voms1.grid.cesnet.cz.lsc `
`Created vomsdir file /home/paolini/DIRAC/etc/grid-security/vomsdir/fedcloud.egi.eu/voms2.grid.cesnet.cz.lsc `
`Created vomses file /home/paolini/DIRAC/etc/grid-security/vomses/fedcloud.egi.eu`

### Managing proxies

First you need to setup the DIRAC environment:

`$ cd DIRAC/`
`$ source bashrc`

Then you can generate the proxy containing the credentials of your VO.
Specify the VO in the "--group" option:

`$ dirac-proxy-init --debug --group compchem_user -U --rfc`
`Generating proxy...`

`Your certificate will expire in 19 days. Please renew it!`

`Enter Certificate password:`
`Contacting CS...`
`Checking DN /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`Username is apaolini`
`Creating proxy for apaolini@compchem (/O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini)`
`X509_CERT_DIR is unset. Abort check of CAs`
`=======================================================================`
`  Your certificate will expire in less than 19 days. Please renew it!  `
`=======================================================================`
`Uploading proxy for compchem...`
`Uploading compchem proxy to ProxyManager...`
`Loading user proxy`
`Uploading proxy on-the-fly`
`Cert file /home/paolini/.globus/usercert.pem`
`Key file  /home/paolini/.globus/userkey.pem`
`Loading cert and key`
`User credentials loaded`
` Uploading...`
`Proxy uploaded`
`Proxy generated:`
`subject      : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini/CN=7349567351`
`issuer       : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`identity     : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`timeleft     : 23:59:58`
`DIRAC group  : compchem`
`rfc          : True`
`path         : /tmp/x509up_u516`
`username     : apaolini`
`properties   : NormalUser, Pilot`

`Proxies uploaded:`
` DN                                               | Group    | Until (GMT)`
` /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini | compchem | 2017/11/01 16:17`

As a result of this command, several operations are accomplished:

  - a long user proxy ( with the length of the validity of the
    certificate ) is uploaded to the DIRAC ProxyManager service,
    equivalent of the gLite MyProxy service
  - a short user proxy is created with the DIRAC extension carrying the
    DIRAC group name and with the VOMS extension corresponding to the
    DIRAC group if the gLite UI environment is available.

If the gLite UI environment is not available, the VOMS extensions will
not be loaded into the proxy. This is not a serious problem, still most
of the operations will be possible.

For checking the details of you proxy, run the following comand:

`$ dirac-proxy-info`
`subject      : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini/CN=7349567351`
`issuer       : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`identity     : /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`timeleft     : 23:48:19`
`DIRAC group  : compchem`
`rfc          : True`
`path         : /tmp/x509up_u516`
`username     : apaolini`
`properties   : NormalUser, Pilot`

To check that your proxy has been properly uploaded to the ProxyManager
service:

`$ dirac-proxy-get-uploaded-info`
`Checking for DNs /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini`
`------------------------------------------------------------------------------------------------------------------`
`| UserName | UserDN                                           | UserGroup | ExpirationTime      | PersistentFlag |`
`------------------------------------------------------------------------------------------------------------------`
`| apaolini | /O=dutchgrid/O=users/O=egi/CN=Alessandro Paolini | compchem  | 2017-11-01 16:17:11 | False          |`
`------------------------------------------------------------------------------------------------------------------`

### Managing jobs

In the following table there is a comparison between the glite-WMS CLI
and the DIRAC one:

<table>
<thead>
<tr class="header">
<th><p>gLite-WMS command</p></th>
<th><p>DIRAC command</p></th>
<th><p>Note</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>glite-wms-job-list-match</p></td>
<td><hr /></td>
<td><p>not needed</p></td>
</tr>
<tr class="even">
<td><p>glite-wms-job-submit</p></td>
<td><p>dirac-wms-job-submit</p></td>
<td><p>to submit a job</p></td>
</tr>
<tr class="odd">
<td><p>glite-wms-job-status</p></td>
<td><p>dirac-wms-job-status</p></td>
<td><p>to check the status of a job</p></td>
</tr>
<tr class="even">
<td><p>glite-wms-job-output</p></td>
<td><p>dirac-wms-job-get-output</p></td>
<td><p>to retrieve the job output</p></td>
</tr>
<tr class="odd">
<td><p>glite-wms-job-logging-info</p></td>
<td><p>dirac-wms-job-logging-info</p></td>
<td><p>to retrieve history of transitions for a DIRAC job</p></td>
</tr>
<tr class="even">
<td><p>glite-wms-job-cancel</p></td>
<td><p>dirac-wms-job-delete</p></td>
<td><p>to delete a job</p></td>
</tr>
<tr class="odd">
<td><p>glite-wms-job-delegate-proxy</p></td>
<td><hr /></td>
<td><p>not needed</p></td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

Have a look at the official [command reference
documentation](http://dirac.readthedocs.io/en/latest/UserGuide/CommandReference/WorkloadManagement/index.html)
for the complete list of the Workload Management commands.

In general, you can submit jobs, check their status, and retrieve the
output in the same way than the glite-WMS. For example:

`$ dirac-wms-job-submit test.jdl`
`JobID = 23844073`

`$ dirac-wms-job-status 23844073`
`JobID=23844073 Status=Waiting; MinorStatus=Pilot Agent Submission; Site=ANY;`

`$ dirac-wms-job-status 23844073`
`JobID=23844073 Status=Done; MinorStatus=Execution Complete; Site=EGI.HG-08-Okeanos.gr;`

`$ dirac-wms-job-get-output --Dir joboutput/ 23844073`
`Job output sandbox retrieved in joboutput/23844073/`

Find more details about:

  - JDL language and simple jobs submission: [JDLs and Job Management
    Basic](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/JDLsAndJobManagementBasic/index.html)
  - Submitting Parametric and MPI jobs, using DIRAC API: [Advanced Job
    Management](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/JobManagementAdvanced/index.html)

### Data management

DIRAC provides also a file catalogue service for managing input and
output data of your jobs. There is a list of default SEs available for
data management and they are defined in the DIRAC configuration: ask the
DIRAC4EGI administrators to add to this list the infrastructure SEs
supporting your VO (it is under discussion the feature of taking
automatically the VO SEs from the BDII).

Find more information about:

  - [Data Management
    Basic](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/DataManagementBasic/index.html)
  - [File Catalog
    Interface](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/FileCatalogBasic/index.html)
  - [Data Management
    Advanced](http://dirac.readthedocs.io/en/latest/UserGuide/Tutorials/DataManagementAdvanced/index.html)
