---
title: Accounting
linkTitle: Accounting
type: docs
weight: 30
description: >
  Accounting Portal for the EGI Federation.
---

## Overview

The EGI Accounting Portal provides the accounting data for Compute and Cloud
services gathered from the data centres of the
[EGI Federation](https://www.egi.eu/egi-federation/). Users can employ custom
filtering by selecting resource centres, VOs and defining a time period etc.
Accounting data gathered by the Open Science Grid (OSG) is also included.

## Accounting data

Data for a given month is mapped to the first of the month at midnight, i.e.
all usage for July 2026 is stored at '2026-07-01T00:00:00Z'.

Usage for the current month will update daily.

### Programmatic access

Access to the entirety of the accounting data is provided at the following endpoints, in the following formats.

- [https://accounting.egi.eu/csv](https://accounting.egi.eu/csv), CSV
- [https://accounting.egi.eu/json](https://accounting.egi.eu/json), JSON

#### JSON format explained

The JSON format contains one or more result sets, each consisting of a named
series with column definitions and corresponding data rows.

##### High-level structure

```text
root
└── results[]         # Array of result sets
    └── series[]      # Array of series returned for this result
        ├── name      # Series name ("summary")
        ├── columns[] # Column definitions
        ├── values[]  # Data rows
        └── partial   # Optional flag indicating this series is partial
                      # and more data follows in the next series.
```

To obtain the full dataset, in a representation of the data where each record
is stored as a self-contained object with named fields, concatenate all rows
from all series.

```python
all_records = []

for result in data["results"]:
    for series in result.get("series", []):
        cols = series["columns"]

        for row in series["values"]:
            all_records.append(dict(zip(cols, row)))
```

##### Datapoints explained

Each entry in values represents a summary accounting record containing:

| Column | Description |
| --- | --- |
| time | Timestamp associated with the record |
| benchmark | Benchmark identifier or value |
| ce | Computing Element |
| country | Country in which the resource is located |
| federation | Federation to which the resource belongs |
| infrastructure | `Grid`, `Grid-Local` (local jobs) or `Cloud` |
| site | Site name |
| tier | Site tier classification within WLCG |
| vo | Virtual Organisation |
| ngi | The national grouping of shared computing resources |
| number_of_jobs | Number of jobs represented by the record |
| raw_cpu_eff | CPU efficiency metric |
| raw_cpu_time | Total CPU time consumed |
| raw_cpu_work | Total CPU work performed |
| raw_wc_time | Total wall-clock time |
| raw_wc_work | Total wall-clock work performed |

##### Example

```text
{
  "results": [
    {
      "series": [
        {
          "name": "summary",
          "columns": [
            "time",
            "benchmark",
            "ce",
            "country",
            "federation",
            "infrastructure",
            "site",
            "tier",
            "vo",
            "number_of_jobs",
            "raw_cpu_eff",
            "raw_cpu_time",
            "raw_cpu_work",
            "raw_wc_time",
            "raw_wc_work"
          ],
          "values": [
            [Datapoint 1],
            [Datapoint 2]
            # etc
          ],
          "partial": true
        }
      ]
    },
    {
      "series": [
        {
          "name": "summary",
          "columns": [
            "time",
            "benchmark",
            "ce",
            "country",
            "federation",
            "infrastructure",
            "site",
            "tier",
            "vo",
            "number_of_jobs",
            "raw_cpu_eff",
            "raw_cpu_time",
            "raw_cpu_work",
            "raw_wc_time",
            "raw_wc_work"
          ],
          "values": [
            [Datapoint 99],
            [Datapoint 100]
          ]
        }
      ]
    }
  ]
}
```
