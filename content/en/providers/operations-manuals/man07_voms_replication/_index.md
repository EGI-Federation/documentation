---
title: MAN07 VOMS Replication
weight: 60
type: "docs"
description: "How to implement a MySQL VOMS server replication"
---

## Document control

| Property            | Value                                            |
| ------------------- | ------------------------------------------------ |
| Title               | MAN07 VOMS Replication                           |
| Policy Group        | Operations Management Board (OMB)                |
| Document status     | Approved                                         |
| Procedure Statement | How to implement a MySQL VOMS server replication |
| Owner               | SDIS team                                        |

## Introduction

In this manual we will show you how to implement a MySQL VOMS server
replication: you need one master server, on which you can perform writing
operations, and you can have from 1 to "n" replica servers that will work in
read-only mode. In such a scenario you can do a whatever intervention on one of
the servers without breaking the service, i.e. proxies creation and
`grid-mapfile` downloads: just the users registration and the usual VOs
management operations might be forbidden during an intervention on the master
server (because it is the only server in writing mode).

This failover procedure is simply based on MySQL replication therefore every
MySQL setting is referred to the current MySQL version (5.0.77 in this moment)

## Settings on the MASTER SERVER

In order to allow the replica server to read the master database, you have to
create an user with which the slave will connect to the master. Suppose the
replica hostname is `vomsrep.cnaf.infn.it`, the user is `janedoe` and the
password is `always`. What you have to launch on the master server is:

```shell
$ mysql -p -e "grant super, reload, replication slave, replication client \
  on *.* to janedoe@'vomsrep.cnaf.infn.it' identified by 'always'" ;
```

Then for each DB (VO) you want to replicate, you have to assign the right
permissions, by launching:

```shell
mysql -p -e "grant select, lock tables on voms_myvo.* to \
  janedoe@'vomsrep.cnaf.infn.it'"
```

Eventually you have to modify the file `/etc/my.cnf` by adding the following
lines into the section `[mysqld]`:

```ini
log-bin=mysql-bin
server-id=1
innodb_flush_log_at_trx_commit=1
sync_binlog=1
```

It is important that on the master server it is set `server-id=1`: it is the
identification number that distinguish a master from its several slaves (each
slave will have a unique number starting from 2)

For example, the content of `my.cnf` file may appear like this:

```shell
# less /etc/my.cnf

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql

# Default to using old password format for compatibility with mysql 3.x
# clients (those using the mysqlclient10 compatibility package).
old_passwords=1

max_connections = 800
log-bin=mysql-bin server-id=1
innodb_flush_log_at_trx_commit=1
sync_binlog=1
# Disabling symbolic-links is recommended to prevent assorted security risks;
# to do so, uncomment this line: # symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```

At this point, you have to restart MySQL, by launching:

```shell
$ service mysqld restart
```

In order to check that on the master side the mechanism is working, you can
launch for example:

```sh
mysql> show master status;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 | 24844    |              |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
```

Eventually, through the web interface, in the ACL section of each VO you want to
replicate, add an entry granting all the permissions to the slave server:

- select "a non VO member" from the menu
- fill in the replica server DN and a reference email address
- select "all" for the permissions and tick the "Propagate entry to children
  contexts" option

In this way, when the slave server copies the DB, it will have the proper
permissions on acting on the DB. Moreover, in order to avoid the sending of
notification to the email address you filled in before, connect to the MySQL
database and do the following:

```shell
mysql> use voms_myvo;
mysql> update admins set email_address=NULL where \
  email_address="what you filled before";
```

## Settings on the SLAVE SERVER

Install a VOMS server as usual, configuring the VOs you want to replicate: keep
in mind that every modification done on the slave DB breaks the replica
mechanism, so that on this server disable the users registration, by setting the
yaim variable:

```shell
VOMS_ADMIN_WEB_REGISTRATION_DISABLE=true
```

Then ask the VO managers to not perform any action on the slave server web
interface.

Then launch the following scripts:

- [first_replica.sh](first_replica.sh) for the first database you want to
  replicate or in the case it is the only one
- [next_replicas.sh](next_replicas.sh) for the next databases (one database for
  each launch)

For both the scripts, set the following variables:

- `master_host`, `master_mysql_user`, `master_mysql_pwd` that refers to the
  master server and to the user created on it
- `mysql_username_admin` and `mysql_password_admin` that refers to the slave

Example:

```shell
voms_database="" # VOMS database (leave unset)
master_host="voms.cnaf.infn.it" # Master hostname
master_mysql_user="janedoe" # Master MySQL admin user for replication
master_mysql_pwd="always" # Master MySQL admin pass for replication user
master_log_file="" # Master LOG file (leave unset)
master_log_pos="" # Master LOG file (leave unset)
mysql_username_admin="root" # Slave MySQL admin username
mysql_password_admin="secret" # Slave MySQL admin pass
```

With the launch of `first-replica.sh`, the file `/etc/my.cnf` will be properly
written; if you need to replicate further databases, modify `/etc/my.cnf` adding
the following lines related to the db you are replicating (similar to the first
db you've replicated):

```shell
replicate-do-db=<master_vo_db_name>
replicate-ignore-table=<master_vo_db_name>.seqnumber
replicate-ignore-table=<master_vo_db_name>.realtime
replicate-ignore-table=<master_vo_db_name>.transactions
replicate-ignore-table=<slave_vo_db_name>.seqnumber
replicate-ignore-table=<slave_vo_db_name>.realtime
replicate-ignore-table=<slave_vo_db_name>.transactions
```

Having set the variables in the way shown above, for replicating the first
database the scripts launch syntax is the following:

```shell
$ ./first_replica.sh --master-db=voms_myvo --db=voms_myvo
```

In your `/etc/my.cnf` file you will find lines like the following:

```shell
# Connection with master
server-id=2
master-host=voms.cnaf.infn.it
master-user=janedoe
master-password=always

# Replicas settings
replicate-do-db=voms_myvo
replicate-ignore-table=voms_myvo.seqnumber
replicate-ignore-table=voms_myvo.realtime
replicate-ignore-table=voms_myvo.transactions
replicate-ignore-table=voms_myvo.seqnumber
replicate-ignore-table=voms_myvo.realtime
replicate-ignore-table=voms_myvo.transactions
```

Now you may want to replicate a second database, let's say `voms_hervo`:
therefore in `my.cnf` file add the following lines:

```shell
replicate-do-db=voms_hervo
replicate-ignore-table=voms_hervo.seqnumber
replicate-ignore-table=voms_hervo.realtime
replicate-ignore-table=voms_hervo.transactions
replicate-ignore-table=voms_hervo.seqnumber
replicate-ignore-table=voms_hervo.realtime
replicate-ignore-table=voms_hervo.transactions
```

Modify the script `next_replicas.sh` in according to the VO parameters and
launch it:

```shell
$ ./next_replicas.sh --master-db=voms_hervo --db=voms_hervo
```

When you finished to replicate all the desired VOs, in order to make active the
database modifications, restart voms and voms-admin:

```shell
$ /etc/init.d/voms-admin stop
$ /etc/init.d/voms stop
$ /etc/init.d/voms start
$ /etc/init.d/voms-admin start
```

Keep in mind that every modification done on the slave DB breaks the replica
mechanism, so that on this server disable the users registration, by setting the
yaim variable:

```shell
VOMS_ADMIN_WEB_REGISTRATION_DISABLE=true
```

And ask the VO managers to not perform any action on the slave server web
interface.
