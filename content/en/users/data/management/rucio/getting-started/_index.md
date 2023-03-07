---
title: Getting Started with Rucio
linkTitle: Getting Started
type: docs
weight: 10
description: >-
  How to get started with Rucio
---

## Rucio terms

- [**Rucio Storage Element**](https://rucio.cern.ch/documentation/rucio_storage_element)
  (RSE) is another name for an endpoint, or storage solution.
- [**Rules**](https://rucio.cern.ch/documentation/replica_management) are an
  instruction to Rucio to do a certain thing. This can be to ensure file _x_ has
  at least 1 copy at _storagesite1_, or ensure file _y_ is on tape, or even on
  tape at more than one location, or even file _z_ has 2 copies at any site
  within a selection of sites. How you set up the RSE and the attributes you
  give them allows for many different strategies to transfer and organise data.
  Once a rule is created, Rucio will get to work to ensure that the rule is
  satisfied at all times.
- **File** is single file within Rucio.
- **Dataset** is a collection of files, which may be a collection or related
  results, or data.
- **Container** is a collection of Datasets which may build a larger subset of a
  whole experiment.
- **Scope** is a collection in which files, datasets, and containers are placed.
  Users will have their own scope, often user.username. But also experiments,
  sub-experiments, or however you wish to organise the data can also have scopes.
  Accounts can be given access to scopes by VO admins.
- **Data Identifier** (DID) uniquely identifies data in Rucio. It is made up
  from the scope and the filename, separated by a colon (e.g.
  _experiment1:file1_).

## Getting started as a new user

### Account creation

1. To get set up with a Rucio account please create a ticket on
   [GGUS](https://ggus.eu/?mode=ticket_submit). Please fill in the form with a
   subject, description, ticket category - service request, priority - less
   urgent, and under routing information please select Assign to support unit -
   Rucio). Within the ticket description please include:

   - Desired Username (usually initials and surname e.g. John Doe would have
     jdoe)
   - Your email
   - Name of the experiment / VO you are part of
   - The subject of your eScience certificate

**If you want password access we can organise a video call to explain or take
sensitive information if you prefer**  
In Terms of testing you can join the test VO (dteam) to try Rucio as a service
and its capabilities.  
**Please note that we are working on allowing Rucio accounts to be created and
accessed with IAM services,** **and
[EGI Check-in](https://docs.egi.eu/users/check-in/), but currently only support
x509 and password access.**

1. Once our team has this information we will create you a Rucio account.

### Docker container setup

1. You will then need to install a containerised client on your computer.

   - Install Docker to run the container
   - <https://www.docker.com/get-started> (for Windows users I would recommend
     using WSL2)
   - Follow the docker instructions to ensure it is running correctly.
   - Using OpenSSL you will need to split your grid certificate bundle into the
     certificate and key:

   ```shell
   $ openssl pkcs12 -in <*.pfx> -out /sensible/path/usercert.pem -clcerts -nokeys
   $ openssl pkcs12 -in <*.pfx> -out /sensible/path/userkey.pem -nocerts -nodes
   ```

1. Run the Docker container using the following command:

When running the block of code below, please replace all items within `<>` with
the relevant information. This uses a Rucio container that was set up for the EGI
communities.

```shell
$ run \
    -e RUCIO_CFG_RUCIO_HOST=https://rucio-server.gridpp.rl.ac.uk:443 \
    -e RUCIO_CFG_AUTH_HOST=https://rucio-server.gridpp.rl.ac.uk:443 \
    -e RUCIO_CFG_AUTH_TYPE=x509_proxy \
    -e RUCIO_CFG_CLIENT_VO=<3 CHAR VO NAME LOWERCASE> \
    -e RUCIO_CFG_CLIENT_CERT=/opt/rucio/etc/usercert.pem \
    -e RUCIO_CFG_CLIENT_KEY=/opt/rucio/etc/userkey.pem \
    -e RUCIO_CFG_ACCOUNT=<Rucio Username> \
    -e RUCIO_CFG_CA_CERT=/opt/rucio/etc/web/ca-first.pem \
    -v <PATH/TO/e-Science CA 2B>:/opt/rucio/etc/web/ca-first.pem \
    -v <PATH/TO/YOUR/USERCERT>:/opt/rucio/etc/usercert \
    -v <PATH/TO/YOUR/USERKEY>:/opt/rucio/etc/userkey \
    --name=rucio-client \
    -it \
    -d egifedcloud/rucioclient:1.23.17
```

This block of code may look large but it is configuring Rucio to connect to the
Multi-VO Rucio at RAL, your account and VO details, where you are loading them
into the container, and mounting the authentication details into the container.

**The UK eScience CA 2B can be [obtained here](https://ca.grid-support.ac.uk/).
The 3 characters VO name will be provided to you when you sign up for a Rucio
account.**

1. Run the following commands inside the docker container to finalise set up:

```shell
$ cp /opt/rucio/etc/usercert /opt/rucio/etc/usercert.pem
$ cp /opt/rucio/etc/userkey /opt/rucio/etc/userkey.pem
$ chmod 600 /opt/rucio/etc/usercert.pem
$ chmod 400 /opt/rucio/etc/userkey.pem
```

### Rucio configuration setup

You need to edit the `/opt/rucio/etc/rucio.cfg` file, this then needs to be
lightly edited to add your account name. This will then be loaded into the Rucio
client.

```ini
[common]
logdir = /var/log/rucio
multi_vo = True
loglevel = INFO
[client]
rucio_host = https://rucio-server.gridpp.rl.ac.uk:443
auth_host = https://rucio-server.gridpp.rl.ac.uk:443
vo = <3 character VO name>
account = <your_account>
ca_cert = /opt/rucio/etc/web/ca-first.pem
auth_type = x509_proxy
client_cert = /opt/rucio/etc/usercert.pem
client_key = /opt/rucio/etc/userkey.pem
client_x509_proxy = /tmp/x509up_u1000
request_retries = 5
```

**You should now have a fully set up Containerised Client for your Rucio
Account** **and VO which you can start in docker and use whenever you need it.**

- If not please contact Rucio support

## Getting started as a new VO

- To get set up with a new VO on Multi-VO Rucio account please create a ticket
  on [GGUS](https://ggus.eu/?mode=ticket_submit). Please fill in the form with a
  subject, description, ticket category - service request, priority - less
  urgent, and under routing information please select 'assign to support unit' -
  Rucio.

- We will set up a meeting to discuss Rucio, your needs, sites, and current set
  up to ensure that Rucio can work for you, and will track progress with the
  ticket.
