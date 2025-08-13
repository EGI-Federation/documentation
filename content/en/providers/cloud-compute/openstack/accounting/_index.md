---
title: "Accounting"
weight: 20
type: "docs"
description: >
  Accounting integration
---

There are two different processes handling the accounting integration:

- [cASO](https://github.com/IFCA-Advanced-Computing/caso/), which connects
  to the OpenStack services to get the usage information, and,
- [ssmsend](https://github.com/apel/ssm), which sends that usage information
  to the central EGI accounting repository.


### Installation

You can get cASO from the
[releases page](https://github.com/IFCA-Advanced-Computing/caso/releases),
alternatively a container image is available in the
[fedcloud-caso](https://github.com/EGI-Federation/fedcloud-catchall-operations/pkgs/container/fedcloud-caso)
repository.

SSM is also available in the [releases](https://github.com/apel/ssm/releases)
or as a container in the [ssm](https://github.com/apel/ssm/releases) repository

### Configuration

[cASO configuration](https://caso.readthedocs.org/en/latest/configuration.html)
is stored at `/etc/caso/caso.conf`. Most default values should be OK, but you
must set:

- `site_name` (line 12), with the name of your site as defined in GOCDB.

- credentials to access the OpenStack services to extract accounting data.
  Check
  [cASO documentation](https://caso.readthedocs.org/en/latest/configuration.html#openstack-configuration)
  for the expected permissions of the user configured here.

- cASO will discover the projects from OpenStack using tags and properties.
  You can set specific tags and properties as needed as described in the
  [Documentaion](https://caso.readthedocs.io/en/stable/configuration.html#selecting-projects-to-get-usages).

cASO will write records to `/var/spool/apel` from where ssmsend will take them.

SSM configuration is available at `/etc/apel`. Defaults should be OK for most
cases. SSM will use `/etc/grid-security` for the certificate CAs and the host
certificate and private keys (`/etc/grid-security/hostcert.pem` and
`/etc/grid-security/hostkey.pem`).

#### Running the services

Both caso and ssmsend should run periodically, e.g. with a cron job, at least
once a day.  We recommend running them every 4 hours.
