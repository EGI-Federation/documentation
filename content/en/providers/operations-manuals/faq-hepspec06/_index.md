---
title: "FAQ HEP SPEC 06"
weight: 140
type: "docs"
description: >-
  Questions about Transition to HEP SPEC, a new CPU benchmark.
---

## Transition to HEP SPEC, a new CPU benchmark

### Q1: Why adopting HEP SPEC 06?

The traditional si2k CPU benchmark is now obsolete and it is time to move to HEP
SPEC, a new CPU benchmark that will replace si2k and will become the reference
benchmark for accounting purposes.

Detailed description of the reasons are provided on the
[transition to a new CPU benchmarking unit for the WLCG](https://indico.cern.ch/getFile.py/access?contribId=3&sessionId=0&resId=0&materialId=0&confId=49388).

### Q2: What is HEP SPEC 06?

The **HEP-SPEC06 benchmark** is designed to scale with the performances of the
high-energy physics codes on similar machines. The goal was to have an accuracy
of ± 5% but for the moment the agreement is significantly higher.

The measurement of HEP-SPEC repeated on identical machines varies less than 1%.
If the computing machines are similar, i.e. same processors and at least 2 GB
per core, the results obtained are very close, within some percent, so that it
is unnecessary to perform measures on all computing hosts. It is enough to do
the measurement for one type of processor and consider it valid for all the
machines with the same processor.

If you are using different OS and specially different compilers, the data will
change.

### Q3: Where can I find information about HEP SPEC 06 measurements?

Some example results are available on the
[HEPIX group-page](https://w3.hepix.org/benchmarking.html), where one can see the
differences between gcc3.4.x and gcc4.1.x.

Additional results tables are available from various EGI partners:

- [GRIDPP](https://www.gridpp.ac.uk/wiki/HEPSPEC06)

If you don't find your computing machine in that table, then it is better to try
to do the measurement because extrapolating the results increases further the
error.

### Q4: How can I run the HEP SPEC 06 benchmark?

If you want to make HEP-SPEC06 on your own own, detailed instructions are
available at
[CERN wiki](https://twiki.cern.ch/twiki/bin/view/FIOgroup/TsiBenchHEPSPECWlcg).

In Short you need the following:

1. A machine with any version of Linux compatible with Scientific Linux (RHEL,
   SL, SLC, CentOS)
2. The gcc compiler should be installed
3. Configuration files and run script (available as a gzipped tar archive from
   the CERN Wiki). The archive's md5sum is 9fed92b8d515b88904705f76809c4028
4. A tar ball of the SPECcpu2006 DVD called `SPEC2006_v11.tar.bz2` that should
   be in the same directory as the run script

### Q5: My site already adopted HEP SPEC 06. Do I still need to publish SpecInt2000?

The transition to HEP-SPEC does not eliminate the need to publish the computing
power in SpecInt2000 (due to backward compatibility with sites not publishing
yet HEP-SPEC). In this case you may calculate the value SpecInt2000 starting
from HEP-SPEC through the following relation:

- value_kSI2K = value_HEP-SPEC / 4 (or value_HEP-SPEC = 4 \* value_kSI2K)

For the `GlueHostBenchmarkSI00` attribute in the GLUE v1.3 schema the following
relation is easier to use:

- value_SI00 = value_HEP-SPEC \* 250 rounded to the nearest integer

### Q6: How are HEP SPEC 06 results set in YAIM?

The YAIM variable `CE_OTHERDESCR` is used to set the
`GlueHostProcessorOtherDescription` attribute. The value of this variable MUST
be defined in your `site-info.def` file as:

```shell
Cores=<CE_LOGCPU/CE_PHYSICALCPU> [, Benchmark=<value>-HEP-SPEC06]
```

where the ratio `CE_LOGCPU` / `CE_PHYSICALCPU` means the average number of cores
per physical CPU in a sub-cluster; in the case of (slightly) heterogeneous
sub-clusters it could be non-integer. The second value of this attribute MUST be
published only in the case the CPU power of the sub-cluster has been computed
using the HEP-SPEC06 benchmark. The Benchmark value must be the average
HEP_SPEC06 result per core, in the sub-cluster.

These variables are set in your `site-info.def` file. After this, the variables
need to be published by the CE's resource BDII, configured e.g. by standard YAIM
commands.

The total CPU capacity of the cluster is computed as Benchmark \* `CE_LOGCPU`.
