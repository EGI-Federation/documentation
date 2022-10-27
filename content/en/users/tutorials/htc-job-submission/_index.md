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

1. Obtain an X.509 certificate. The certificates are issued by Certification
   Authorities (CAs) part of the
   [European Policy Management Authority for Grid Authentication](https://www.eugridpma.org)
   (EUGridPMA), which is also part of the
   [International Global Trust Federation](https://www.igtf.net) (IGTF).
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
  and configure access for your VOMS server, using the proper `.vomses` and
  `.lsc` files, based on the information available on the VOMS server of the
  specific VO.
  - as an example with `dteam`, look at
    [dteam VOMS configuration](https://voms2.hellasgrid.gr:8443/voms/dteam/configuration/configuration.action),
    and create `/etc/vomses/dteam-voms2.hellasgrid.gr` with the **VOMSES
    string** and `/etc/grid-security/vomsdir/dteam/voms2.hellasgrid.gr.lsc`
    with the **LSC configuration** info found on that page.
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

Creating a VOMS proxy for `dteam` VO

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

## Step 3: identifying available resources

Nowadays two Computing Element (CE) "flavours" are mainly used:

- HTCondorCE
- ARC-CE

The CREAM CE is a legacy and no more supported middleware.

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

The `condor` package will install all the required dependencies.

```shell
# XXX probably to be added to the UI ansible role
yum install condor
```

> Condor will use the
> [VOMS proxy created earlier](#step-2-creating-a-voms-proxy).

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

> Submission of a job with the -spool option causes HTCondor to spool all input
> files, the job event log, and any proxy across a connection to the machine
> where the condor_schedd daemon is running. After spooling these files, the
> machine from which the job is submitted may disconnect from the network or
> modify its local copies of the spooled files.

Submit job:

```shell
# Submitting a job, spooling input and output files to
$ condor_submit --spool --name condorce1.ciemat.es \
    --pool condorce1.ciemat.es:9619 env.sub
Submitting job(s).
1 job(s) submitted to cluster 97412.

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

# Retrieving the output of a specific job
 $ condor_transfer_data -name condorce1.ciemat.es -pool condorce1.ciemat.es:9619 97412.0
Fetching data files...
```

#### References

- [HTCondor Quick Start Guide](https://htcondor.readthedocs.io/en/latest/users-manual/quick-start-guide.html)
- [HTCondor: condor_submit](https://htcondor.readthedocs.io/en/latest/man-pages/condor_submit.html)
- [HTCondor: condor_transfer_data](https://htcondor.readthedocs.io/en/latest/man-pages/condor_transfer_data.html)

### To an ARC-CE Computing Element

Test job showing env where it run

```xrsl
&( executable = "/usr/bin/env" )
( jobname = "arctest" )
( stdout = "stdout" )
( join = "yes" )
( gmlog = "gmlog" )
```

```shell
# Generating a proxy for ARC
$ arcproxy --voms dteam
Enter pass phrase for private key:
Your identity: /DC=org/DC=terena/DC=tcs/C=NL/O=Stichting EGI/CN=Jane Doe
Contacting VOMS server (named dteam): voms2.hellasgrid.gr on port: 15004
Proxy generation succeeded
Your proxy is valid until: 2022-10-27 02:23:52
```

```shell
# Sending a job using ARC
# Select a CE
$ lcg-info --list-ce --vo dteam --bdii ldap://lcg-bdii.egi.eu:2170 \
    --attrs CEImpl --query 'CEImpl=*ARC-CE'
# Example: arc01.grid.cyfronet.pl:2811/nordugrid-SLURM-grid-dteam
# Get info about the selected CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=alex4.nipne.ro*))'
# Submitting the job, the JOB_ID will be written on the output
$ arcsub --jobdescrfile testjob.xrsl --computing-element alex4.nipne.ro
Job submitted with jobid: gsiftp://alex4.nipne.ro:2811/jobs/....
# Export JOB_ID to be used for other commands
$ JOB_ID="gsiftp://alex4.nipne.ro:2811/jobs/...."
# Monitoring the status of the job
# Jobs will be in state Finished once completed
$ arcstat "$JOB_ID"

# Use -l parameter with arcstat to get more information on the status of the Job
$ arcstat -l "$JOB_ID"

# Retrieve output of finished job
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

> Broken on the UI installed from UMD via our Ansible module

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

```shell
$ glite-ce-job-submit 'lpsc-cream-ce.in2p3.fr:8443/cream-pbs-dteam' testjob.jdl
glite-ce-job-submit: error while loading shared libraries: libclassad.so.7: cannot open shared object file: No such file or directory
```

### Via the EGI Workload Manager

> FIXME: To be documented.

- In the webportal: using EGI Check-in
