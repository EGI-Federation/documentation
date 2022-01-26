---
title: "Getting Started"
type: docs
linkTitle: "Rucio Getting started"
weight: 10
description: >-
  How to get started with Rucio as a new user or VO.
---

## Getting Started

### Rucio terms

- [**RSE**](https://rucio.readthedocs.io/en/latest/overview_Rucio_Storage_Element.html) -
  An acronym which stands for 'Rucio Storage Element'. Another name for an
  endpoint, or storage solution.
- [**Rule**](https://rucio.readthedocs.io/en/latest/replication_rules_examples.html) -
  A Rucio rule is an instruction to Rucio to do a certain thing. This can be
  ensure file x has at least 1 copy at storagesite1, or ensure file y is on
  tape, or even on tape at more than 1 location, or even file z has 2 copies at
  any site within a selection of sites. How you set up the RSE and the
  attributes you give them allows for many different ways to create and use
  rules. Once a rule is created Rucio will get to work to ensure that the rule
  is True at all times.
- **File** - Within Rucio is a single file.
- **Dataset** - Is a collection of files, which may be a collection or related
  results, or data.
- **Container** - A collection of Datasets which may build a larger subset of a
  whole experiment.
- **Scope** - This is a collection in which files, datasets, and containers are
  placed. Users will have their own scope, often user.username. But also
  experiments, sub-experiments, or however you wish to orgaise the data can also
  have scopes. Accounts can be given access to scopes by VO admins.
- **DID** - A DID is an acronym that stands for 'Data IDentifier'. This is made
  up from the scope, and the filename within Rucio seperated by a colon. e.g.
  experiment1:file1.

### Getting Started as a new user

1.  To get set up with a Rucio account please create a ticket on
    [GGUS](https://ggus.eu/?mode=ticket_submit). Please fill in the form with a
    subject, description, ticket catagory - service request, priority - less
    urgent, and under routing information please select Assign to support unit -
    Rucio). Within the ticket description please include:

        - Desired Username (usually initials and surname e.g. John Doe would have jdoe)
        - Your email
        - Name of the experiment / VO you are part of
        - Either:
            The subject of your eScience certificate

**If you want password access we can organise a video call to explain or take
sensitive information if you prefer**  
In Terms of testing you can join the test VO (dteam) to try Rucio as a service
and its capabilities.  
**Please note that we are working on allowing Rucio accounts to be created and
accessed with IAM services,** **and
[EGI Check-in](https://docs.egi.eu/users/check-in/), but currently only support
x509 and password access.**

1. Once our team has this information we will create you a Rucio account.

1. You will then need to install a containerised client on your computer.

   - Install Docker to run the container
   - <https://www.docker.com/get-started> (for windows users I would recommend
     using WSL2)
   - Follow the docker instructions to ensure it is running correctly.
   - Using openSSL you will need to split your grid certificate bundle into the
     certificate and key:

   ```shell
   $ openssl pkcs12 -in <*.pfx> -out /sensible/path/usercert.pem -clcerts -nokeys
   $ openssl pkcs12 -in <*.pfx> -out /sensible/path/userkey.pem -nocerts -nodes
   ```

1. Run the Docker container using the following command:

When running the block of code below please replaces all items within `<>` with
the relevent information.

```shell
$ run \
    -e RUCIO_CFG_RUCIO_HOST=https://rucio-server.gridpp.rl.ac.uk:443 \
    -e RUCIO_CFG_AUTH_HOST=https://rucio-server.gridpp.rl.ac.uk:443 \
    -e RUCIO_CFG_AUTH_TYPE=x509 \
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
    -d rucio/rucio-clients
```

This block of code may look large but it is configuring Rucio to connect to the
Multi-VO Rucio at RAL, your account and VO details, where you are loading them
into the container, and mounting the authentication details into the container.

The UK escience CA 2B can be [obtained here](https://ca.grid-support.ac.uk/) The
3 character VO name will be provided to you when you sign up for a Rucio
account.

1. Run the following commands inside the docker container to finalise set up:

```shell
$ cd /opt/rucio/etc/
$ cp userkey userkey.pem
$ chmod 400 userkey.pem
$ cp usercert usercert.pem
```

**You should now have a fully set up Containerised Client for your Rucio
Account** **and VO which you can start in docker and use whenever you need it.**

- If not please contact Rucio support

### Getting started as a new VO

- To get set up with a new VO on Multi-VO Rucio account please create a ticket
  on [ggus](https://ggus.eu/?mode=ticket_submit). Please fill in the form with a
  subject, description, ticket catagory - service request, priortiy - less
  urgent, and under routing information please select 'assign to support unit' -
  Rucio).

- We will set up a meeting to discuss Rucio, your needs, sites, and current set
  up to ensure that Rucio can work for you, and will track progress with the
  ticket.
