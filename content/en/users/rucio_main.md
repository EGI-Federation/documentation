---
title: "Multi-VO Rucio for data management"
linkTitle: "Rucio"
weight: 100
description: >-
     Multi-VO Rucio Documentation for new users to follow to get access to, and use Rucio.
---

## Multi-VO Rucio

### Getting Started

#### Getting Started as a new user

Contact our support email[mailto:Rucio-Support@stfc365.onmicrosoft.com] with your:

* Desired Username (usually initials and surname e.g. John Doe would have jdoe)
* The subject of your eScience certificate
* Your email
* Name of the experiment / VO you are part of

In Terms of testing you can join the test VO to try Rucio as a service and its capabilities.

Please note that we are working on allowing Rucio accounts to be created and accessed with IAM services, and EGI check-in, but currently only support x509 and passworded access.


* Once our team has this information we will create you a Rucio account.

* You will then need to install a containerised client on your computer

* Install Docker to run the container
* https://www.docker.com/get-started (for windows users I would recommend using WSL2 rather than Hyper-V as I have had success there)
* Follow the docker instructions to ensure it is running correctly.
* Using openSSL you will need to split your grid certificate bundle into the certificate and key:

`openssl pkcs12 -in <*.pfx> -out /sensible/path/usercert.pem -clcerts -nokeys`

`openssl pkcs12 -in <*.pfx> -out /sensible/path/userkey.pem -nocerts -nodes`


## Run THe Docker container using the following command:

`run \
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
-it -d rucio/rucio-clients`

The UK escience CA 2B can be obtained here[https://ca.grid-support.ac.uk/]
The 3 character VO name will be provided to you when you sign up for a Rucio account

### Run the following commands inside the docker container to finalise set up:

cd /opt/rucio/etc/
cp userkey userkey.pem
chmod 400 userkey.pem
cp usercert usercert.pem


### You should now have a fully set up Containerised Client for your Rucio Account and VO which you can start in docker and use whenever you need it.

- If not please contact Rucio support

## Getting started as a new VO

* Contact our support email[mailto:Rucio-Support@stfc365.onmicrosoft.com]

* We will set up a meeting to discuss Rucio, your needs, sites, and current set up to ensure that Rucio can work for you.

## Official Rucio Pages

- Rucio Homepage[https://rucio.cern.ch/]
- Rucio Documentation[https://rucio.cern.ch/documentation/]

