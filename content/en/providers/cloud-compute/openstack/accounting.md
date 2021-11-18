---
title: "Accounting"
weight: 20
type: "docs"
description: >
  Accounting integration
---

There are two different processes handling the accounting integration:

- cASO, which connects to the OpenStack deployment to get the usage information,
  and,
- ssmsend, which sends that usage information to the central EGI accounting
  repository.

They should be run by cron periodically, settings below run cASO every hour and
ssmsend every six hours.

### Using the VM Appliance

[cASO configuration](http://caso.readthedocs.org/en/latest/configuration.html)
is stored at `/etc/caso/caso.conf`. Most default values should be ok, but you
must set:

- `site_name` (line 12), with the name of your site as defined in GOCDB.

- `projects` (line 20), with the list of projects you want to extract accounting
  from.

- credentials to access the accounting data (lines 28-47, more options also
  available). Check the
  [cASO documentation](http://caso.readthedocs.org/en/latest/configuration.html#openstack-configuration)
  for the expected permissions of the user configured here.

- The mapping from EGI VOs to your local projects `/etc/caso/voms.json`,
  following this format: :

  ```json
  {
    "vo name": {
      "projects": [
        "project A that accounts for the vo",
        "project B that accounts for the VO"
      ]
    },
    "another vo": {
      "projects": ["project C that accounts for the VO"]
    }
  }
  ```

cASO will write records to `/var/spool/apel` from where ssmsend will take them.

SSM configuration is available at `/etc/apel`. Defaults should be OK for most
cases. The cron file uses `/etc/grid-security` for the CAs and the host
certificate and private keys (`/etc/grid-security/hostcert.pem` and
`/etc/grid-security/hostkey.pem`).

#### Running the services

Both caso and ssmsend are run via the root user crontab. For convenience there
are two scripts `/usr/local/bin/caso-extract.sh` and
`/usr/local/bin/ssm-send.sh` that run the docker container with the proper
volumes.
