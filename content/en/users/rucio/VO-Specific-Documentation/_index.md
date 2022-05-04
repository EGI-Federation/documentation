---
title: "Dteam Specific Documentation"
type: docs
linkTitle: "Rucio Dteam"
weight: 90
description: >-
  How to get set up with the dteam VO
---

## Rucio configuration setup

<<<<<<< HEAD
To start with, you need to create a rucio.cfg file, this then needs to be
lightly edited to add your account name. This will then be loaded into the Rucio
client below:
=======
To start with, you need to create a `rucio.cfg` file, this then needs to be
lightly edited to add your account name. This will then be loaded into the
Rucio client.
>>>>>>> 6dad27dd54c353aa3653278e6cc0346234b73499

```ini
[common]
logdir = /var/log/rucio
multi_vo = True
loglevel = INFO

[client]
rucio_host = https://rucio-server.gridpp.rl.ac.uk:443
auth_host = https://rucio-server.gridpp.rl.ac.uk:443
vo = dtm
account = <your_account>
ca_cert = /opt/rucio/etc/web/ca-first.pem
auth_type = x509_proxy
client_cert = /opt/rucio/etc/usercert.pem
client_key = /opt/rucio/etc/userkey.pem
client_x509_proxy = /tmp/x509up_u1000
request_retries = 5
```

## Rucio-client setup

To get the Rucio client that is set up for dteam please use this
[Rucio Client](https://hub.docker.com/repository/docker/egifedcloud/rucioclient).
This would be done by running the command:

```shell
$ docker run \
     -v <path/to/the/rucio.cfg>:/opt/rucio/etc/rucio.cfg \
     -v <path/to/your/usercert.pem>:/opt/rucio/etc/usercert \
     -v <path/to/your/userkey.pem>:/opt/rucio/etc/usercert \
     -e RUCIO_CFG_CLIENT_CERT=/opt/rucio/etc/usercert.pem \
     -e RUCIO_CFG_CLIENT_KEY=/opt/rucio/etc/userkey.pem \
     -e RUCIO_CFG_CA_CERT=/opt/rucio/etc/web/ca-first.pem \
     --name=rucio-client \
     -it \
     -d egifedcloud/rucioclient:1.23.17
```

Once the container is running you will need to copy some files, to have them
<<<<<<< HEAD
owned by the container User, rather then root, and then change the permissions
on those files so that they are appropriate for voms-proxy creation. To start
with step into the container by running:
=======
owned by the container user, rather then root, and then change the permissions
on those files so that they are appropriate for voms-proxy creation.
To start with step into the container by running:
>>>>>>> 6dad27dd54c353aa3653278e6cc0346234b73499

```shell
$ docker exec -it rucio-client bash
```

Once inside the container you can then copy and edit file permissions with the
following:

```shell
$ cp /opt/rucio/etc/usercert /opt/rucio/etc/usercert.pem
$ cp /opt/rucio/etc/userkey /opt/rucio/etc/userkey.pem
$ chmod 600 /opt/rucio/etc/usercert.pem
$ chmod 400 /opt/rucio/etc/userkey.pem
```

You should now be able to generate a VOMS proxy using the credentials loaded
into the container, this is done by running the following command within the
container:

```shell
$ voms-proxy-init --voms dteam
```

## Confirmation of Client setup

Once this is complete you should now have access to Rucio. This can be confirmed
with a ping and a whoami commands to verify one, the connection to the Rucio
host and two, that you are authenticating successfully as your user.

```shell
$ rucio ping
1.23.17
$ rucio whoami
status     : ACTIVE
account    : user
account_type : USER
created_at : YYYY-MM-DDThh:mm:ss
suspended_at : None
updated_at : YYYY-MM-DDThh:mm:ss
deleted_at : None
email      : user@email.co.uk
```

Once these messages have been displayed with the relevent information, as a user
you should now have access to the Dteam VO, and can create rules, upload and
download files from the various RSEs.

<<<<<<< HEAD
If you have any issues please do contact the Multi-VO admin / dteam VO admins at
[rucio-support@stfc365.onmicrosoft.com](mailto:rucio-support@stfc365.onmicrosoft.com)
=======
If you have any issues please do contact the
[Multi-VO admin / dteam VO admins](mailto:rucio-support@stfc365.onmicrosoft.com).
>>>>>>> 6dad27dd54c353aa3653278e6cc0346234b73499
