---
title: Querying the Information System
type: docs
weight: 30
description: "Querying the Information System"
---

## About the information system

Information about resources is documented according to the
[GLUE Schema](https://gridinfo-documentation.readthedocs.io/en/latest/glue.html).

Information in the Top BDII is provided for two GLUE schema versions:

- [GLUE 1.3](https://redmine.ogf.org/dmsf_files/61): the legacy version of the
  specification, under the LDAP base `Mds-Vo-Name=local,o=grid`.
- [GLUE 2.0](https://www.ogf.org/documents/GFD.147.pdf): the most recent version
  of the specification, under the LDAP base `GLUE2GroupID=grid,o=glue`.

> Some resources may not yet be exposed via GLUE 2.0, and it may be required to
> use GLUE 1.3 for those ones.

{{% alert title="Tip" color="info" %}} You can use `-o ldif-wrap=no` to disable
wrapping the results. {{% /alert %}}

> Those examples are relying on the Top BDII service maintained by EGI
> Foundation: `ldap://lcg-bdii.egi.eu:2170`.

```shell
# Dumping all the information from GLUE 2.0
$ ldapsearch -x -H ldap://lcg-bdii.egi.eu:2170 -b "GLUE2GroupID=grid,o=glue"
```

- In order to retrieve information required to contact a given CE, you can look
  for `GLUE2EndpointURL` objects.
- In order to retrieve information about the batch systems, you can look for
  `GLUE2Manager` objects.
- In order to look for information about a specific CE, you can look into
  `GLUE2Service`.
- In order to look for information about the resources available to VOs, you can
  look into `GLUE2Share` and `GLUE2Policy`.

The following queries can be used to retrieve information about **all** the
Computing Elements of a given type. You will likely be able to use only a subset
of them, only the ones supporting the Virtual Organisation you are a member of,
and for which you have a valid VOMS proxy.

## Computing Elements

Nowadays mainly two Computing Element (CE) "flavours" are used in production:

- [HTCondorCE](https://htcondor.org/htcondor-ce/overview/), a Compute Entrypoint
  (CE) based on [HTCondor](http://htcondor.org/).
- [ARC-CE](http://www.nordugrid.org/arc/ce/), the
  [ARC](http://www.nordugrid.org/arc/) Compute Element (CE).

The [CREAM CE](https://cream-guide.readthedocs.io/en/latest/) is a legacy and no
more supported middleware.

### Querying for HTCondorCE compute resources

Most, if not all the HTCondorCE Computing Elements should be discoverable via
GLUE 2.0.

```shell
# Querying GLUE2EndpointURL for all HTCondorCE compute endpoints
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Endpoint)(GLUE2EndpointImplementationName=HTCondor))' \
    GLUE2EndpointInterfaceName \
    GLUE2EndpointImplementationVersion \
    GLUE2EndpointURL

# Querying GLUE2Manager for the batch systems' versions and number of CPUs
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
   '(&(objectClass=GLUE2Manager)(GLUE2ManagerProductName=HTCondor))' \
   GLUE2ManagerProductName \
   GLUE2ManagerProductVersion \
   GLUE2ComputingManagerTotalLogicalCPUs \
   GLUE2ComputingManagerComputingServiceForeignKey
```

Once you have selected a given CE, you can look into getting more information
about this one.

```shell
# Querying GLUE2Service for information about a specific CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Service)(GLUE2ServiceID=*condorce1.ciemat.es*))'

# Querying GLUE2Share for a specific CE, filtering for details on the queues
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Share)(GLUE2ShareID=*condorce1.ciemat.es*))' \
    GLUE2ComputingShareMappingQueue \
    GLUE2ShareIDGLUE2ComputingShareMaxWallTime \
    GLUE2ComputingShareMaxVirtualMemory \
    GLUE2ComputingShareMaxUserRunningJobs \
    GLUE2ComputingShareMaxRunningJobs \
    GLUE2ComputingShareMaxCPUTime \
    GLUE2ComputingShareWaitingJobs \
    GLUE2ComputingShareUsedSlots \
    GLUE2ComputingShareTotalJobsGLUE2ComputingShareRunningJobs

# Querying GLUE2Policy for a specific CE, filtering for supported VOs
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Policy)(GLUE2PolicyID=*condorce1.ciemat.es*))' \
    GLUE2PolicyRule \
    GLUE2PolicyID \
    GLUE2MappingPolicyShareForeignKey
```

It's also possible to look into [GLUE 1.3](#using-glue-13).

### Querying for ARC-CE compute resources

Most, if not all the ARC-CE should be discoverable via GLUE 2.0.

```shell
# Querying for all ARC-CE compute resources
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Endpoint)(GLUE2EndpointImplementationName=nordugrid-arc))' \
    GLUE2EndpointInterfaceName \
    GLUE2EndpointImplementationVersion \
    GLUE2EndpointURL

# Querying GLUE2Manager for the batch systems' versions and number of CPUs
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
   '(&(objectClass=GLUE2Manager)(GLUE2ComputingManagerComputingServiceForeignKey=*urn:ogf:ComputingService*))' \
   GLUE2ManagerProductName \
   GLUE2ManagerProductVersion \
   GLUE2ComputingManagerTotalLogicalCPUs \
   GLUE2ComputingManagerComputingServiceForeignKey
```

Once you have selected a given CE, you can look into getting more information
about this one.

```shell
# Querying GLUE2Service for information about a specific CE
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Service)(GLUE2ServiceID=*alex4.nipne.ro*))'

# Querying GLUE2Share for a specific CE, filtering for details on the queues
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Share)(GLUE2ShareID=*alex4.nipne.ro*))' \
    GLUE2ComputingShareMappingQueue \
    GLUE2ShareIDGLUE2ComputingShareMaxWallTime \
    GLUE2ComputingShareMaxVirtualMemory \
    GLUE2ComputingShareMaxUserRunningJobs \
    GLUE2ComputingShareMaxRunningJobs \
    GLUE2ComputingShareMaxCPUTime \
    GLUE2ComputingShareWaitingJobs \
    GLUE2ComputingShareUsedSlots \
    GLUE2ComputingShareTotalJobsGLUE2ComputingShareRunningJobs

# Querying GLUE2Policy for a specific CE, filtering for supported VOs
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Policy)(GLUE2PolicyID=*alex4.nipne.ro*))' \
    GLUE2PolicyRule \
    GLUE2PolicyID \
    GLUE2MappingPolicyShareForeignKey
```

It's also possible to look into [GLUE 1.3](#using-glue-13).

### Using GLUE 1.3

> **GLUE 1.3** is legacy.

Querying for information about HTCondor CE using GLUE 1.3.

```shell
# Querying for all HTCondorCE compute resources, using GLUE 1.3
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEInfoJobManager=HTCondorCE))' \
    GlueCEImplementationVersion GlueCEImplementationName \
    GlueCEStateStatus GlueCEUniqueID GlueServiceEndpoint GlueServiceType

# Querying information about the HTCondor CE via GLUE 1.3
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=condorce1.ciemat.es:9619/condorce1.ciemat.es-condor))'

# Limiting output for the Condor CE via GLUE 1.3
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=condorce1.ciemat.es:9619/condorce1.ciemat.es-condor))' \
    GlueCEInfoHostName GlueCEUniqueID \
    GlueCEInfoJobManager GlueCEImplementationName GlueCEImplementationVersion \
    GlueCEInfoLRMSType GlueCEInfoLRMSVersion \
    GlueCEAccessControlBaseRule \
    GlueCEInfoTotalCPUs \
    GlueCEStateStatus
```

Querying for information about ARC-CE using GLUE 1.3.

```shell
# Querying for all ARC CE compute resources, using GLUE 1.3
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEInfoJobManager=arc))' \
    GlueCEImplementationVersion GlueCEImplementationName \
    GlueCEStateStatus GlueCEUniqueID GlueServiceEndpoint GlueServiceType

# Querying information about the ARC CE via GLUE 1.3
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "Mds-Vo-Name=local,o=grid" \
    '(&(objectClass=GlueCE)(GlueCEUniqueID=alex4.nipne.ro:2811/nordugrid-SLURM-dteam))'

# Limiting output for the ARC CE via GLUE 1.3
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

#### Using legacy tools for GLUE 1.3

Using `lcg-info` it's possible to easily do more targeted queries, like focusing
on a specific VO.

> `lcg-info` and `lcg-infosites` are only taking into account the **GLUE 1.3**
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

## Identifying all the resources accessible by a given VO

In **GLUE 2.0**, the access granted to a given VO to a compute or storage
resource, is published using the `GLUE2Share` and `GLUE2Policy` objects. There
are also `GLUE2ComputingShare` and `GLUE2StorageShare` to specifically document
sharing of compute or storage resources.

```shell
# Querying GLUE2Share for all the resources available to dteam VO
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2Share)(GLUE2ShareID=*dteam*))'

# Querying GLUE2ComputingShare for all the computing resources available to dteam VO
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2ComputingShare)(GLUE2ShareID=*dteam*))'

# Querying GLUE2StorageShare for all the storage resources available to dteam VO
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2StorageShare)(GLUE2ShareID=*dteam*))'
```

It is possible to filter for the different types of Computing Element, and
select only specific attributes.

### Looking for a HTCondorCE for dteam

```shell
# Information about the HTCondorCE supporting dteam VO
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2ComputingShare)(GLUE2ShareID=*dteam*)(GLUE2ComputingShareComputingEndpointForeignKey=*HTCondorCE*))' \
    GLUE2ShareEndpointForeignKey \
    GLUE2ShareID \
    GLUE2ComputingShareTotalJobs \
    GLUE2ComputingShareRunningJobs \
    GLUE2ComputingShareWaitingJobs
```

Assuming it was decided, based on the site location, available resources, prior
experience, or any other reason, to go for `condorce1.ciemat.es`, the
information about the CE can be requested using the following request, filtering
on the `GLUE2ShareID` from the previous query:
`grid_dteam_condorce1.ciemat.es_ComputingElement`.

```shell
# condor_submit needs CE (condorce1.ciemat.es) and pool (condorce1.ciemat.es:9619)
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2ComputingShare)(GLUE2ShareID=*grid_dteam_condorce1.ciemat.es_ComputingElement*))' \
    GLUE2ShareID \
    GLUE2ShareDescription \
    GLUE2ComputingShareExecutionEnvironmentForeignKey \
    GLUE2EntityOtherInfo
```

### Looking for an ARC-CE for dteam

// jscpd:ignore-start

```shell
# Information about the ARC-CE supporting dteam VO
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2ComputingShare)(GLUE2ShareID=*dteam*)(GLUE2ComputingShareComputingEndpointForeignKey=*urn:ogf*))' \
    GLUE2ComputingShareComputingEndpointForeignKey \
    GLUE2ShareEndpointForeignKey \
    GLUE2ComputingShareTotalJobs \
    GLUE2ComputingShareRunningJobs \
    GLUE2ComputingShareWaitingJobs
```

Assuming it was decided, based on the site location, available resources, prior
experience, or any other reason, to go for `condorce1.ciemat.es`, the
information about the CE can be requested using the following request, filtering
on the `GLUE2ShareID` from the previous query:
`grid_dteam_condorce1.ciemat.es_ComputingElement`.

```shell
# arcsub needs CE name (alex4.nipne.ro)
$ ldapsearch -x -LLL -H ldap://lcg-bdii.egi.eu:2170 \
    -b "GLUE2GroupID=grid,o=glue" \
    '(&(objectClass=GLUE2ComputingShare)(GLUE2ShareID=*urn:ogf:ComputingShare:alex4.nipne.ro:dteam_dteam*))' \
    GLUE2ShareID \
    GLUE2ShareDescription \
    GLUE2ComputingShareComputingServiceForeignKey \
    GLUE2ComputingShareExecutionEnvironmentForeignKey
```

// jscpd:ignore-end
