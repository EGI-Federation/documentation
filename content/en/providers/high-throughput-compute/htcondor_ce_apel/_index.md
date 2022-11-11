---
title: APEL Accounting for HTCondor-CE
weight: 10
type: "docs"
description: "APEL Accounting for HTCondor-CE"
---

HTCondor-CE can be configured to automatically publish accounting data if
compute resources are provided by an HTCondor pool. Optionally, the HTCondor
pool can also be configured to provide per-machine performance data for
increased accounting accuracy.

## Enabling accounting records on each HTCondor-CE

Each HTCondor-CE must be configured separately to create accounting data for its
jobs and feed them to APEL. See
[MAN09](../../operations-manuals/man09_accounting_data_publishing) for general
configuration instructions of APEL.

1. Install `htcondor-ce-apel`, available from the HTCondor Yum repository.

1. Configure the APEL parser via `parser.cfg` to read the HTCondor-CE accounting
   records:

   ```lang-none
   [blah]
   enabled = true
   dir = /var/lib/condor-ce/apel/
   filename_prefix = blah

   [batch]
   enabled = true
   dir = /var/lib/condor-ce/apel/
   filename_prefix = batch
   type = HTCondor
   ```

1. Configure the APEL client via `client.cfg` section `[spec_updater]` to know
   the cluster specs:

   - `site_name` must equal your GOCDB site name.

   - `manual_spec1` must equal the CE identifier, spec type and average spec
     value of the cluster. The format is:

     ```lang-none
     manual_spec1 = <fqdn>:9619/<fqdn>-condor,<spec_type>,<spec_value>
     ```

     For example, if the CE has the fqdn `my-htcondor-ce.example.com` and
     resources averaging 12.5 HEPSPEC per core:

     ```lang-none
     manual_spec1 = my-htcondor-ce.example.com:9619/my-htcondor-ce.example.com-condor,HEPSPEC,12.5
     ```

1. Start and enable the `condor-ce-apel.timer` unit.

## Enabling per-machine performance information

By default, HTCondor-CE APEL accounting assumes that all machines in the cluster
have comparable performance. If this is not the case, accounting accuracy can be
improved by adding performance information per machine.

Performance information may be added to each HTCondor StartD. There are two
separate ways to do so:

- An _absolute_ performance spec value can be assigned to the StartD, similar to
  the average spec value assigned to the CE. HTCondor-CE APEL accounting weights
  resource usage by comparing the StartD spec value to the average spec value.

  In the StartD configuration, define `ApelSpecs` as a new-style classad mapping
  between a spec type and its value; multiple spec types are supported, but in
  practice `HEPSPEC` is currently the only one needed. Also add `ApelSpecs` to
  the attributes of the StartD.

  ```lang-none
  # The performance per core on this StartD
  ApelSpecs = [HEPSPEC=14.37; SI2K=2793]
  STARTD_ATTRS = $(STARTD_ATTRS) ApelSpecs
  ```

- A _relative_ performance spec value can be assigned to the StartD, as a factor
  to the average spec value assigned to the CE. HTCondor-CE APEL accounting
  directly weights resource usage by the relative StartD spec factor.

  In the StartD configuration, define `ApelScaling` as a number; values above 1
  means the performance is above average. Also add `ApelScaling` to the
  attributes of the StartD.

  ```lang-none
  # The performance per core on this StartD
  ApelScaling = 1.15
  STARTD_ATTRS = $(STARTD_ATTRS) ApelScaling
  ```

If both `ApelSpecs` and `ApelScaling` are defined, `ApelSpecs` takes precedence.
