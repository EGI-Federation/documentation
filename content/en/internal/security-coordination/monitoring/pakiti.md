---
title: "Pakiti client"
description: "Using Pakiti client"
weight: 30
type: "docs"
---

The `pakiti-client` can be used to send package informations to
[pakiti.egi.eu](https://pakiti.egi.eu).

If you have the proper credentials in the
[Configuration Database](../../configuration-database) and submit your report
with the correct `SITE_NAME`, you, your _NGI-CSIRT_ and the _EGI-CSIRT_ will be
able to monitor the packages installed on your hosts and potentially
vulnerabilities. The results can be accessed on the
[EGI Pakiti central instance](https://pakiti.egi.eu).

## Running the Pakiti client from CVMFS for EGI

If you have CVMFS installed and configured to mount grid.cern.ch, you can run
pakiti by simply running:

```shell
$ /cvmfs/grid.cern.ch/pakiti/bin/pakiti-client \
    --url "https://pakiti.egi.eu/feed/" \
    --site SITE_NAME
```

> Please remember to replace SITE_NAME by your actual site name

## Manual installation

### Installing the Pakiti client

The `pakiti-client` is now available from EPEL. If your machine already has EPEL
enabled, the following command is enough to install it:

```shell
$ yum install pakiti-client
```

### Running the Pakiti client for EGI

With the package and the configuration, the following commands will run the

`pakiti-client` and transmit all its data to the EGI CSIRT pakiti instance!

```shell
$ pakiti-client --url "https://pakiti.egi.eu/feed/" --site SITE_NAME
```

> Please remember to replace SITE_NAME by your actual site name

## Puppet Installation

The simplest way to configure and run the `pakiti-client` on a cluster is to use
puppet: You just need to create a file and a manifest.

```puppet
package { 'pakiti-client':
  ensure => 'present',
}
cron { 'pakiti-egi':
  ensure  => 'present',
  command => 'pakiti-client --url "https://pakiti.egi.eu/feed/" --site SITE_NAME',
  user    => 'nobody',
  hour    => fqdn_rand(24),
  minute  => fqdn_rand(60),
}
```
