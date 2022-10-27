---
title: "Submitting HTC Jobs"
type: docs
weight: 160
description: >
  Submitting High Throughput Compute jobs
---

## Overview

This tutorial describes how to submit
[High Throughput Compute (HTC)](../../compute/high-throughput-compute) jobs
using command-line.

## Prerequisites

To submit an EGI HTC job, you will have to:

1. Obtain an X.509 user certificate. The supported certificates are issued by
   Certification Authorities (CAs) part of the
   [European Policy Management Authority for Grid Authentication (EUGridPMA)](https://www.eugridpma.org),
   which is also part of the
   [International Global Trust Federation (IGTF)](https://www.igtf.net).
1. Enrol into a VO having access to HTC resources.

> This tutorial will be using `dteam` a test Virtual Organisation that can be
> used by resource providers, commands should be adjusted to the appropriate VO.

## Step 1: getting access to a User Interface (UI)

In order to interact with HTC resources, you should have access to a
`User Interface`, often referred to as a `UI`. This software environment will
provide all the tools required to interact with the different middleware, as
different sites can be using different Computing Element (CE), such as
HTCondorCE and ARC-CE (CREAM is a legacy software stack that is not officially
supported).

Different possibilities are available to access an UI:

- Having access to an UI provided by/for your community
- Deploying a UI

### Deploying an UI

The UI is available as a package in the [UMD](https://go.egi.eu/umd) software
distribution, but it will also require additional software and configuration.

In order to help with deploying an UI, different solutions are possible:

- Deploying an UI manually, using the packages available from
  [UMD repositories](https://go.egi.eu/umd). You will need to install at least
  the `ui` meta-package, with `voms-client`, the
  [IGTF distribution](../../../providers/operations-manuals/howto01_using_igtf_ca_distribution),
  and
  [configure the system to use voms-client](#configuring-the-system-to-use-voms-client).
- Some
  [Ansible roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
  are available in the
  [EGI Federation GitHub organisation](https://github.com/EGI-Federation?q=ansible-role),
  mainly [ansible-role-ui](https://github.com/EGI-Federation/ansible-role-ui)
  that should be used together with
  [ansible-role-VOMS-client](https://github.com/EGI-Federation/ansible-role-VOMS-client),
  providing software and material required for the authentication and
  authorisation, and
  [ansible-role-umd](https://github.com/EGI-Federation/ansible-role-umd)
  configuring the software repositories from where all the software will be
  installed.
- The repository
  [ui-deployment](https://github.com/EGI-Federation/ui-deployment) provides a
  [terraform](https://terraform.io) based deployment allowing to deploy a
  `User Interface (UI)` in a
  [Cloud Compute virtual machine](../../compute/cloud-compute). This integrated
  deployment is based on the Ansible modules, and should be adjusted to your
  environment and needs.

> This tutorial is based on using a VM deployed using the
> [ui-deployment](https://github.com/EGI-Federation/ui-deployment) repository,
> refer to the repository for detailed instructions on deploying the UI.

## Step 2: creating a VOMS proxy

> The
> [Virtual Organization Membership Service (VOMS)](https://italiangrid.github.io/voms/index.html)
> enables Virtual Organisation (VO) access control in distributed services. A
> proxy allows limited delegation of rights, allowing remote services to
> securely interact with other resources and services on behalf of the user.

### Configuring the system to use voms-client

> When using
> [ansible-role-VOMS-client](https://github.com/EGI-Federation/ansible-role-VOMS-client),
> the full environment has been setup for you, and there is no need for manual
> configuration.

Before being able to use `voms-client`, it is required to
[configure access to the VOMS server of the chosen VO](https://italiangrid.github.io/voms/documentation/voms-clients-guide/),
using the proper `.vomses` and `.lsc` files, based on the information available
on the VOMS server of the specific VO.

- as an example with `dteam`, you can find the VOMS server address in the
  [Operations Portal](../../../internal/operations-portal):
  [https://operations-portal.egi.eu/vo/view/voname/dteam](https://operations-portal.egi.eu/vo/view/voname/dteam).
  Then looking at
  [dteam VOMS configuration](https://voms2.hellasgrid.gr:8443/voms/dteam/configuration/configuration.action),
  you can create:
  - `/etc/vomses/dteam-voms2.hellasgrid.gr` with the content of the **VOMSES
    string**.
  - `/etc/grid-security/vomsdir/dteam/voms2.hellasgrid.gr.lsc` with the content
    for the **LSC configuration**.

If you cannot edit content in `/etc/vomses` and `/etc/grid-security/vomsdir`,
you can respectively use `~/.glite/vomses` and `~/.glite/vomsdir`. You may have
to export `X509_VOMSES` and `X509_VOMS_DIR` in your shell, as documented
[on CERN's twiki](https://twiki.cern.ch/twiki/bin/view/DREAM/GridSetup):

```shell
export X509_VOMSES=~/.glite/vomses
export X509_VOMS_DIR=~/.glite/vomsdir
```

### Preparing the X.509 credentials

Once you have obtained an X.509 user certificate issued by a Certification
Authority (CA) part of the
[International Global Trust Federation (IGTF)](https://www.igtf.net), you should
extract the certificate and private key, and add them to a `~/.globus`
directory.

If the X.509 certificate is in your browser's keyring, you should export it to a
passphrase protected `.p12` file, then using
[`openssl pkcs12`](https://www.openssl.org/docs/man1.0.2/man1/pkcs12.html) you
can extract the required **PEM** files:

```shell
# Creating and protecting ~/.globus directory
$ mkdir -p ~/.globus
$ chmod 750 ~/.globus
# Extracting the certificate from the p12 file "exported_cert.p12"
openssl pkcs12 -in exported_cert.p12 -out ~/.globus/usercert.pem -clcerts -nokeys
# Adjusting rights on the user certificate
$ chmod 640 ~/.globus/usercert.pem
# Extracting the certificate key from the p12, protecting it with a passphrase
$ openssl pkcs12 -in exported_cert.p12 -out ~/.globus/userkey.pem -nocerts
# Adjusting rights on the certificate key
$ chmod 400 ~/.globus/userkey.pem
```

If you are using a certificate provided by the
[GÉANT Trusted Certificate Service (TCS)](https://wiki.geant.org/display/TCSNT/),
in addition to the official documentation provided by your organisation, you may
be interested by looking at the following documentation:

- [Generation 4 GEANT Trusted Certificate Service TCS](https://ca.dutchgrid.nl/tcs/),
  covering how to get and install your credentials, addressing potential issues
  with an improper _.p12_. **Highly recommended**.
- [SUNET TCS 2020- Information for administrators](https://wiki.sunet.se/display/TCS/SUNET+TCS+2020-+Information+for+administrators),
  an exhaustive documentation mainly for administrators but also covering
  client-related aspects.

### Using voms-client

Once the
[configuration for the VOMS client](#configuring-the-system-to-use-voms-client)
has been completed, and when the
[X.509 credentials have been prepared](#preparing-the-x509-credentials), you can
create a **VOMS proxy** for `dteam` VO:

```shell
# Creating the proxy
$ voms-proxy-init -voms dteam --rfc
Enter GRID pass phrase for this identity:
Contacting voms2.hellasgrid.gr:15004 [/C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms2.hellasgrid.gr] "dteam"...
Remote VOMS server contacted succesfully.


Created proxy in /tmp/x509up_u1001.

Your proxy is valid until Wed Oct 26 23:27:30 CEST 2022
# Checking the proxy
$ voms-proxy-info
subject   : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Jane Doe/CN=123456319
issuer    : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Jane Doe
identity  : /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Jane Doe
type      : RFC3820 compliant impersonation proxy
strength  : 2048
path      : /tmp/x509up_u1001
timeleft  : 11:58:48
key usage : Digital Signature, Key Encipherment
```

### References

- [VOMS Documentation](https://italiangrid.github.io/voms/documentation.html)
- [USG Proxy Certificates](https://wiki.egi.eu/wiki/USG_Proxy_Certificates)

## Step 3: identifying available resources

Nowadays two Computing Element (CE) "flavours" are mainly used:

- [HTCondorCE](https://htcondor.org/htcondor-ce/overview/), a Compute Entrypoint
  (CE) based on [HTCondor](http://htcondor.org/).
- [ARC-CE](http://www.nordugrid.org/arc/ce/), the
  [ARC](http://www.nordugrid.org/arc/) Compute Element (CE).

The [CREAM CE](https://cream-guide.readthedocs.io/en/latest/) is a legacy and no
more supported middleware.

In this section we will document querying the EGI Information System to retrieve
information about the available resources.

> Those examples are relying on the Top BDII maintained by EGI Foundation:
> `ldap://lcg-bdii.egi.eu:2170`

```shell
# Dumping the glue schema
$ ldapsearch -x -H ldap://lcg-bdii.egi.eu:2170 -b o=glue
```

The following queries can be used to retrieve information about **all** the
Computing Elements of a given type. You will likely be able to use only a subset
of them, only the ones supporting the Virtual Organisation you are a member of,
and for which you have a valid VOMS proxy.

```shell
# Querying for all HTCondorCE compute resources
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEInfoJobManager=HTCondorCE))' \
    GlueCEImplementationVersion GlueCEImplementationName \
    GlueCEStateStatus GlueCEUniqueID GlueServiceEndpoint GlueServiceType
# Querying for all ARC CE compute resources
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEInfoJobManager=arc))' \
    GlueCEImplementationVersion GlueCEImplementationName \
    GlueCEStateStatus GlueCEUniqueID GlueServiceEndpoint GlueServiceType
```

Using `lcg-info` it's possible to easily do more targeted queries, like focusing
on a specific VO.

> `lcg-info` and `lcg-infosites` are only taking into account the **GLUE 1**
> schema, and will lack information that is only published according to the
> **GLUE 2** schema, like for most `HTCondorCE` Computing Elements.

```shell
# Identify compute resources available for dteam VO
$ lcg-info --list-ce --vo dteam --bdii ldap://lcg-bdii.egi.eu:2170
# Identify storage resources available for dteam VO
$ lcg-info --list-se --vo dteam --bdii ldap://lcg-bdii.egi.eu:2170
```

```shell
$ lcg-info --list-ce --vo dteam --bdii ldap://lcg-bdii.egi.eu:2170 \
    --attrs CEImpl --query 'CEImpl=*HTCondorCE'
(...)
- CE: ce01.knu.ac.kr:9619/ce01.knu.ac.kr-condor
  - CEImpl              HTCondorCE

- CE: ce13.pic.es:9619/ce13.pic.es-condor
  - CEImpl              HTCondorCE
(...)
- CE: condorce1.ciemat.es:9619/condorce1.ciemat.es-condor
  - CEImpl              HTCondorCE

- CE: condorce2.ciemat.es:9619/condorce2.ciemat.es-condor
  - CEImpl              HTCondorCE
(...)
```

We can see that the `dteam` VO should be able to access Computing Elements from
the various types:

```shell
$ lcg-info --list-ce --vo dteam --bdii ldap://lcg-bdii.egi.eu:2170 \
    --attrs CEImpl --query 'CEImpl=*' | grep CEImpl | sort | uniq -c
    123   - CEImpl              ARC-CE
     22   - CEImpl              CREAM
      7   - CEImpl              HTCondorCE
```

Once you have selected a site, you can start sending jobs there.

The following sites will be used in this tutorial:

- HTCondorCE: `condorce1.ciemat.es:9619/condorce1.ciemat.es-condor`
- ARC-CE: `alex4.nipne.ro:2811/nordugrid-SLURM-dteam`

You can query for information using `ldapsearch`, and the information returned
by `lcg-info`:

```shell
# Querying information about the HTCondor CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=condorce1.ciemat.es:9619/condorce1.ciemat.es-condor))'

# Limiting output for the Condor CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=condorce1.ciemat.es:9619/condorce1.ciemat.es-condor))' \
    GlueCEInfoHostName GlueCEUniqueID \
    GlueCEInfoJobManager GlueCEImplementationName GlueCEImplementationVersion \
    GlueCEInfoLRMSType GlueCEInfoLRMSVersion \
    GlueCEAccessControlBaseRule \
    GlueCEInfoTotalCPUs \
    GlueCEStateStatus

# Querying information about the ARC CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=alex4.nipne.ro:2811/nordugrid-SLURM-dteam))'

# Limiting output for the ARC CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=alex4.nipne.ro:2811/nordugrid-SLURM-dteam))' \
    GlueCEInfoHostName GlueCEUniqueID \
    GlueCEInfoJobManager GlueCEImplementationName GlueCEImplementationVersion \
    GlueCEInfoLRMSType GlueCEInfoLRMSVersion \
    GlueCEAccessControlBaseRule \
    GlueCEInfoTotalCPUs \
    GlueCEStateStatus
```

## Step 4: submitting and managing jobs

### To an HTCondorCE Computing Element

> The [HTCondor-CE](https://htcondor.com/htcondor-ce/#what-is-htcondor-ce)
> software is a Compute Entrypoint (CE) based on
> [HTCondor](http://htcondor.org/) for sites that are part of a larger computing
> grid (e.g. [EGI](https://www.egi.eu/),
> [Open Science Grid (OSG)](https://osg-htc.org/)).

The `condor` package will install all the required dependencies.

```shell
yum install condor
```

> Condor will use the
> [VOMS proxy created earlier](#step-2-creating-a-voms-proxy).

While HTCondor provides an official
[HTCodnor Quick Start Guide](https://htcondor.readthedocs.io/en/latest/users-manual/quick-start-guide.html),
the main steps for managing a job will be highlighted below.

Create `env.sub`, the compute job to be executed on the remote Computing
Element:

```shell
executable              = /usr/bin/env
log                     = env.log
output                  = outfile.txt
error                   = errors.txt
should_transfer_files   = Yes
when_to_transfer_output = ON_EXIT
queue
```

The format of the submit description file, is documented in
[HTCondor manual](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html)
and
[`condor_submit` man page](https://htcondor.readthedocs.io/en/latest/man-pages/condor_submit.html#submit-description-file-commands).

> Submission of a job with the -spool option causes HTCondor to spool all input
> files, the job event log, and any proxy across a connection to the machine
> where the condor_schedd daemon is running. After spooling these files, the
> machine from which the job is submitted may disconnect from the network or
> modify its local copies of the spooled files.

Submit job using
[condor_submit](https://htcondor.readthedocs.io/en/latest/man-pages/condor_submit.html):

```shell
# Submitting a job, spooling input and output files to
$ condor_submit --spool --name condorce1.ciemat.es \
    --pool condorce1.ciemat.es:9619 env.sub
Submitting job(s).
1 job(s) submitted to cluster 97412.
```

Monitor the status of the job using
[condor_q](https://htcondor.readthedocs.io/en/latest/man-pages/condor_q.html):

```shell
# Checking the status of a specific job
$ condor_q --name condorce1.ciemat.es --pool condorce1.ciemat.es:9619 97412


-- Schedd: condorce1.ciemat.es : <192.101.161.188:9619?... @ 10/26/22 16:31:00
OWNER    BATCH_NAME    SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
dteam050 ID: 97412   10/26 16:21      _      _      _      1 97412.0

Total for query: 1 jobs; 1 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended
Total for all users: 884 jobs; 412 completed, 0 removed, 200 idle, 259 running, 13 held, 0 suspended


# Checking the status of all jobs running on that
$ condor_q --name condorce1.ciemat.es --pool condorce1.ciemat.es:9619


-- Schedd: condorce1.ciemat.es : <192.101.161.188:9619?... @ 10/26/22 16:25:03
OWNER    BATCH_NAME    SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
dteam050 ID: 97400   10/26 15:46      _      _      _      1 97400.0
dteam050 ID: 97412   10/26 16:21      _      _      _      1 97412.0

Total for query: 2 jobs; 2 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended
Total for dteam050: 2 jobs; 2 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended
Total for all users: 883 jobs; 411 completed, 0 removed, 200 idle, 259 running, 13 held, 0 suspended
```

It is also possible to view the output of a running job using
[condor_tail](https://htcondor.readthedocs.io/en/latest/man-pages/condor_tail.html).

Download the job output to the **UI** using
[condor_transfer_data](https://htcondor.readthedocs.io/en/latest/man-pages/condor_transfer_data.html):

```shell
# Retrieving the output of a specific job
 $ condor_transfer_data -name condorce1.ciemat.es -pool condorce1.ciemat.es:9619 97412.0
Fetching data files...
```

#### References

- [HTCondor Quick Start Guide](https://htcondor.readthedocs.io/en/latest/users-manual/quick-start-guide.html)
- [HTCondor Application Programming Interfaces (APIs)](https://htcondor.readthedocs.io/en/latest/apis/index.html)
- [OSG Site Documentation: HTCondor-CE Overview](https://osg-htc.org/docs/compute-element/htcondor-ce-overview/)

### To an ARC-CE Computing Element

> [ARC](http://www.nordugrid.org/arc) Compute Element (CE) is a Grid front-end
> on top of a conventional computing resource (e.g. a Linux cluster or a
> standalone workstation). ARC CE is sometimes also called **ARC server**.

While there is an official documentation on
[How to submit a job](http://www.nordugrid.org/arc/arc6/users/submit_job.html),
the main steps will be documented below.

You first need to generate a proxy certificate using, `arcproxy`, which is using
the same credentials as `voms-proxy-init`, so you first need to
[prepare your X.509 credentials](#preparing-the-x509-credentials).

```shell
# Generating a proxy for ARC
$ arcproxy --voms dteam
Enter pass phrase for private key:
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Jane Doe
Contacting VOMS server (named dteam): voms2.hellasgrid.gr on port: 15004
Proxy generation succeeded
Your proxy is valid until: 2022-10-27 02:23:52
```

Create `testjob.xrsl`, a test job expressed in
[xRSL](https://www.nordugrid.org/arc/arc6/users/xrsl.html), showing environment
where it will run:

```xrsl
&( executable = "/usr/bin/env" )
( jobname = "arctest" )
( stdout = "stdout" )
( join = "yes" )
( gmlog = "gmlog" )
```

Then review the ARC CE information and send the job using
[`arcsub`](https://www.nordugrid.org/arc/arc6/users/client_tools.html#arcsub):

```shell
# Getting info about the selected CE
# Example CE: alex4.nipne.ro:2811/nordugrid-SLURM-dteam
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=alex4.nipne.ro:2811/nordugrid-SLURM-dteam))'
# Submitting the job, the JOB_ID will be written on the output
$ arcsub --jobdescrfile testjob.xrsl --computing-element alex4.nipne.ro
Job submitted with jobid: gsiftp://alex4.nipne.ro:2811/jobs/....
# Export JOB_ID to be used for other commands
$ JOB_ID="gsiftp://alex4.nipne.ro:2811/jobs/...."
```

Then you can use
[`arcstat`](https://www.nordugrid.org/arc/arc6/users/client_tools.html#arcstat)
to monitor the job:

```shell
# Monitoring the status of the job
$ arcstat "$JOB_ID"

# Use -l parameter with arcstat to get more information on the status of the Job
$ arcstat -l "$JOB_ID"
```

The jobs will be in state _Finished_ once completed.

You can finally retrieve the output of a finished job using
[`arcget`](https://www.nordugrid.org/arc/arc6/users/client_tools.html#arcget):

```shell
# Retrieve output files of the finished job, removing them from the server
$ arcget "$JOB_ID"

Results stored at: Ow7KmRKv71nuvw3Vp3UrRNqABFKDmABFKDmfJKDmABFKDmoeT5zn
Jobs processed: 1, successfully retrieved: 1, successfully cleaned: 1
```

Instead of manually selecting a site, it's possible to do some automatic
selection from CE registered in a central registry, such as `nordugrid.org`.

```shell
# Automatic selection on the CE in the nordugrid.org registry
$ arcsub --jobdescrfile testjob.xrsl --registry nordugrid.org
(...)
gsiftp://vm3.tier2.hep.manchester.ac.uk:2811/jobs/...
JOB_ID="gsiftp://vm3.tier2.hep.manchester.ac.uk:2811/jobs/.."

# Use -l paramter to get more information on the status of the Job
$ arcstat -l "$JOB_ID"
```

#### References

- [ARC: submit a job](http://www.nordugrid.org/arc/arc6/users/submit_job.html)
- [ARC client tools](http://www.nordugrid.org/arc/arc6/users/client_tools.html)

### To a CREAM Computing Element

> The CREAM (Computing Resource Execution And Management) Service is a simple,
> lightweight service that implements all the operations at the Computing
> Element (CE) level.

The first step is to prepare a JDL as `testjob.jdl`. The
[CREAM JDL Guide](https://cream-guide.readthedocs.io/en/latest/JDL_Guide.html),
documents the creation of the JDL:

```jdl
[
Type = "Job";
JobType = "Normal";
Executable = "/usr/bin/env";
StdOutput = "output.txt";
StdError = "error.txt";
OutputSandbox = {"output.txt", "error.txt"};
]
```

Then you can submit, monitor and retrieve the output of the job.

> Those commands are broken on the UI installed from UMD via
> [our Ansible module](https://github.com/EGI-Federation/ansible-role-ui), but
> are provided here as a reference, and for users having access to UI maintained
> by or for their community and providing the required commands.

```shell
# Subbmiting a job, job ID would be printed to the output
$ glite-ce-job-submit 'lpsc-cream-ce.in2p3.fr:8443/cream-pbs-dteam' testjob.jdl
# Use a variable with the job ID to be reused later
JOB_ID='...'
# Monitoring the job
$ glite-ce-job-status "$JOB_ID"
# Retrieving the output of the job
$ glite-ce-job-output "$JOB_ID"
```

## References

- [CREAM User's guide](https://cream-guide.readthedocs.io/en/latest/User_Guide.html)
- [CREAM User's Guide for EMI-3](https://wiki-igi.cnaf.infn.it/twiki/bin/view/CREAM/UserGuideEMI3)

### Via the EGI Workload Manager

> The [EGI Workload Manager](https://www.egi.eu/services/workload-manager/) is a
> service provided to the EGI community to efficiently manage and distribute
> computing workloads on the EGI infrastructure.

Using the
[Workload Manger web interface](../../compute/orchestration/workload-manager/#the-egi-workload-manager-web-portal)
or the
[DIRAC command-line interface (CLI)](../../compute/orchestration/workload-manager/#the-dirac-client-tool)
is documented in the
[EGI Workload Manager](../../compute/orchestration/workload-manager).
