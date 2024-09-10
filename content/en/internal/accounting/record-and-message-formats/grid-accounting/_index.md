---
title: "Grid Accounting"
weight: 20
type: "docs"
description: "EGI Grid Accounting record and message formats"
---

## Individual Job Records and Messages

### Header

`APEL-individual-job-message: v0.3`

The header only appears once at the top of each message (that is once at the
top of each file). It defines the type of record and the schema version.

### Record Fields

The table shows the equivalent field in the CAR, under the container element
`urf:UsageRecord`. If not specified, it refers to the text value of urf:Key,
where the element is a direct child of `urf:UsageRecord`.

<!-- markdownlint-disable line-length -->

| Key | Value | Description | Mandatory | CAR equivalent (if different) |
| - | - | - | - | - |
| Site | String | GOCDB sitename | Yes |
| SubmitHost | String | The CE-ID (see example) | Yes |
| MachineName | String | LRMS hostname | | |
| Queue | String | Batch system queue | | |
| LocalJobId | String | Batch System Job ID | Yes | urf:JobIdentity/urf:LocalJobId |
| LocalUserId | String | Local username | | urf:UserIdentity/urf:LocalUserId |
| GlobalUserName | String | User's X509 DN | | urf:UserIdentity/urf:GlobalUserName |
| FQAN | String | User's VOMS attributes | | urf:UserIdentity/urf:GroupAttribute[@type="FQAN"] |
| WallDuration | int | Wallclock time for the job (seconds) | Yes | CAR has ISO 8601 time duration |
| CpuDuration | int | CPU time for the job (seconds) | Yes | CAR has ISO 8601 time duration |
| Processors | int | Number of processors | | urf:Processors[@metric="max"] |
| NodeCount | int | Number of nodes | | |
| StartTime | int | Start time of the job (epoch time) | Yes | CAR has ISO 8601 datetime |
| EndTime | int | Stop time of the job (epoch time) | Yes | CAR has ISO 8601 datetime |
| InfrastructureDescription | String | \<accounting client\>-\<CE type\>-\<batch system type\> eg. "APEL-CREAM-PBS" | | |
| InfrastructureType | String | grid OR local | | |
| MemoryReal | int | Memory consumed by job (kbytes) | | urf:Memory[@metric="max" and @type="Physical" and @storageUnit="KB"] |
| MemoryVirtual | int | Virtual memory consumed by job (kbytes) | | urf:Memory[@metric="max" and @type="Shared" and @storageUnit="KB"] |
| ServiceLevelType | String | Si2k OR HEPSPEC | Yes | urf:ServiceLevel[@type] |
| ServiceLevel | double | Value of either HepSpec06 or SpecInt2000 | Yes | urf:ServiceLevel |

<!-- markdownlint-enable line-length -->

### Message

#### End of record

%%

#### Example Message

```text
APEL-individual-job-message: v0.2
Site: ExampleSite
SubmitHost: host.domain:port/queue
LocalJobId: 11111111
LocalUserId: User1
GlobalUserName: /C=whatever/D=someDN
FQAN: /voname/Role=NULL/Capability=NULL
WallDuration: 234256
CpuDuration: 2345
Processors: 2
NodeCount: 2
StartTime: 1234567890
EndTime: 1234567899
MemoryReal: 1000
MemoryVirtual: 2000
ServiceLevelType: Si2k
ServiceLevel: 1000
%%
...another job record...
%%
...
%%
```

### Notes

If GlobalUserName or UserFQAN is not published, the value for these fields on
the server will be set to 'None'.

Jobs are assumed to be grid jobs. To specify local jobs, use:

- InfrastructureType: local
- SubmitHostType: LRMS
- SubmitHost: LRMS-hostname

The Group value specified for local jobs must be different to equivalent grid
jobs, or you will not be able to differentiate them in the accounting portal.
Suggestion:

- Group: ExampleVO - grid job
- Group: local-ExampleVO - local job

### Changes since version 0.2

- InfrastructureType field (optional)
- InfrastructureDescription field (optional)
- SubmitHostType field (optional)

### Changes from version 0.1 to version 0.2

- LocalJobID has changed to LocalJobId
- LocalUserID has changed to LocalUserId
- UserFQAN has changed to FQAN
- ScalingFactorUnit has changed to ServiceLevelType
- The possible values of ScalingFactorType have changed from
  ["SpecInt2000", "HepSpec06", "custom"] to ["Si2k"], ["HEPSPEC"]
- ScalingFactor has changed to ServiceLevel

## Summary Job Records and Messages

### Header

`APEL-summary-job-message: v0.3`

The header only appears once at the top of each message. It defines the type
of record and the schema version.

### Record Fields

The table shows the equivalent field in the AUR, under the container element
`aur:SummaryRecord`. If not specified, it refers to the text value of
`urf:Key`, where the element is a direct child of `aur:SummaryRecord`.

<!-- markdownlint-disable line-length -->

| Key | Value | Description | Mandatory | AUR equivalent |
| - | - | - | - | - |
| Site | String | GOCDB sitename | Yes | |
| Month | int | Month of summary (see notes) | Yes | |
| Year | int | Year of summary (see notes) | Yes | |
| GlobalUserName | String | User's X509 DN | | aur:UserIdentity/urf:GlobalUserName |
| VO | String | User's VO | | aur:UserIdentity/urf:Group |
| VOGroup | String | User's VOMS group | | aur:UserIdentity/urf:GroupAttribute[@type="vo-group"] |
| VORole | String | User's VOMS role | | aur:UserIdentity/urf:GroupAttribute[@type="vo-role"] |
| SubmitHost | String | The CE-ID or LRMS hostname | | |
| Infrastructure | String | grid OR local | | |
| Processors | int | Number of processors | | |
| NodeCount | int | Number of nodes | | |
| EarliestEndTime | int | End time of the first job in the month (epoch time) | | AUR has dates in ISO 8601 format |
| LatestEndTime | int | End time of the last job in the month (epoch time) | | AUR has dates in ISO 8601 format |
| WallDuration | int | Sum of wall clock times for all jobs in the month (in seconds) | Yes | AUR has durations in ISO 8601 format |
| CpuDuration | int | Sum of CPU time for all jobs in the month (in seconds) | Yes | AUR has durations in ISO 8601 format |
| NormalisedWallDuration | int | Sum of normalised wall clock time for all jobs (in seconds; normalised by HEPSPEC06) | Yes | AUR has durations in ISO 8601 format |
| NormalisedCpuDuration | int | Sum of normalised CPU times for all jobs (in seconds; normalised by HEPSPEC06) | Yes | AUR has durations in ISO 8601 format |
| NumberOfJobs | int | Total number of jobs | Yes | |

<!-- markdownlint-enable line-length -->

### Message

#### End of record

%%

#### Example Message

```text
APEL-summary-job-message: v0.3
Site: ExampleSite
Month: 3
Year: 2010
GlobalUserName: /C=whatever/D=someDN
VO: ExampleVO
VOGroup: /ExampleVO
VORole: Role=production
SubmitHost: host.domain:port/queue
Infrastructure: grid
Processors: 1
NodeCount: 1
EarliestEndTime: 1267527463
LatestEndTime: 1269773863
WallDuration: 23425
CpuDuration: 2345
NormalisedWallDuration: 244435
NormalisedCpuDuration: 2500
NumberOfJobs: 100
%%
...another summary job record...
%%
...
%%
```

### Notes

If GlobalUserName, VO, Group or Role are not published, the value for these
fields on the server will be set to 'None'.

The job records are included in months according to the month and year of
their EndTime. The month and year should be in UTC. Only completed jobs are
accounted for by APEL.

All durations are in hours. Normalised durations should be multiplied by
HEPSPEC06. All figures should be rounded to the nearest integer.

## Summary Sync Records and Messages

The Summary Sync records are used for the creation of the "APEL Pub/Sync"
tests. It is a mechanism for the central APEL server to know the number of
records that each site is storing locally. It is in general only used by
sites which publish via the standard APEL client.

### Header

`APEL-sync-message: v0.1`

### Record Fields

| Key | Value | Description | Mandatory |
| - | - | - | - |
| Site | String | GOCDB sitename | Yes |
| SubmitHost | String | CE ID | Yes |
| NumberOfJobs | int | Total number of jobs for that month | Yes |
| Month | int | Month | Yes |
| Year | int | Year | Yes |

### Message

#### End of record

%%

#### Example Message

```text
APEL-sync-message: v0.1
Site: ExampleSite
SubmitHost: host.domain:port/queue
NumberOfJobs: 3479
Month: 1
Year: 2010
%%
...another sync record...
%%
...
%%
```
