---
title: MAN07 VOMS Replication
permalink: /MAN07_VOMS_Replication/
---

[Category:Operations Manuals](/Category:Operations_Manuals "wikilink")

## Introduction

In this manual we will show you how to implement a MySQL VOMS server
replication: you need one master server, on which you can perform
writing operations, and you can have from 1 to "n" replica servers that
will work in read-only mode. In such a scenario you can do a whatever
intervention on one of the servers without breaking the service, i.e.
proxies creation and grid-mapfile downloads: just the users registration
and the usual VOs management operations might be forbidden during an
intervention on the master server (because it is the only server in
writing mode).

This failover procedure is simply based on mysql replication therefore
every mysql setting is referred to the current mysql version (5.0.77 in
this moment)

## Settings on the MASTER SERVER

In order to allow the replica server to read the master database, you
have to create an user with which the slave will connect to the master.
Suppose the replica hostname is vomsrep.cnaf.infn.it, the user is
bonjovi and the password is always: what you have to launch on the
master server is

`mysql -p -e "grant super, reload , replication slave, replication client on *.* to bonjovi@'vomsrep.cnaf.infn.it' identified by 'always'" ;`

Then for each DB (VO) you want to replicate, you have to assign the
right permissions, by launching:

`mysql -p -e "grant select, lock tables on voms_myvo.* to bonjovi@'vomsrep.cnaf.infn.it'"`

Eventually you have to modify the file */etc/my.cnf* by adding the
following lines into the section "\[mysqld\]":

`log-bin=mysql-bin`
`server-id=1`
`innodb_flush_log_at_trx_commit=1`
`sync_binlog=1`

It is important that on the master server it is set "server-id=1": it is
the identification number that distinguish a master from its several
slaves (each slave will have a unique number starting from 2)

For example, the content of my.cnf file may appear like this:

`# less /etc/my.cnf `
`[mysqld]`
`datadir=/var/lib/mysql`
`socket=/var/lib/mysql/mysql.sock`
`user=mysql`
`# Default to using old password format for compatibility with mysql 3.x`
`# clients (those using the mysqlclient10 compatibility package).`
`old_passwords=1`

`max_connections = 800`
`log-bin=mysql-bin`
`server-id=1`
`innodb_flush_log_at_trx_commit=1`
`sync_binlog=1`
`# Disabling symbolic-links is recommended to prevent assorted security risks;`
`# to do so, uncomment this line:`
`# symbolic-links=0`

`[mysqld_safe]`
`log-error=/var/log/mysqld.log`
`pid-file=/var/run/mysqld/mysqld.pid`

At this point, you have to restart mysql, by launching:

`service mysqld restart`

In order to check that on the master side the mechanism is working, you
can launch for example:

`mysql> show master status;`
`+------------------+----------+--------------+------------------+`
`| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |`
`+------------------+----------+--------------+------------------+`
`| mysql-bin.000001 |    24844 |              |                  | `
`+------------------+----------+--------------+------------------+`
`1 row in set (0.00 sec)`

Eventually, through the web interface, in the ACL section of each VO you
want to replicate, add an entry granting all the permissions to the
slave server:

  - select "a non VO member" from the menu
  - fill in the replica server DN and a reference email address
  - select "all" for the permissions and tick the "Propagate entry to
    children contexts" option

In this way, when the slave server copies the DB, it will have the
proper permissions on acting on the DB. Morover, in order to avoid the
sending of notification to the email address you filled in before,
connect to the mysql DB and do the following:

`mysql> use voms_myvo;`
`mysql> update admins set email_address=NULL where email_address="what you filled before";`

## Settings on the SLAVE SERVER

Install a VOMS server as usual, configuring the VOs you want to
replicate: keep in mind that every modification done on the slave DB
breaks the replica mechanism, so that on this server disable the users
registration, by setting the yaim variable

`VOMS_ADMIN_WEB_REGISTRATION_DISABLE=true`

and therefore ask the VO managers to not perform any action on the slave
server web interface.

Then launch the following scripts:

  - [first_replica.sh](/VOMS_Replication_first_replica "wikilink") for
    the first database you want to replicate or in the case it is the
    only one
  - [next_replicas.sh](/VOMS_Replication_next_replicas "wikilink") for
    the next databases (one database for each launch)

For both the scripts, set the following variables:

  - master_host, master_mysql_user, master_mysql_pwd that refers to
    the master server and to the user created on it
  - mysql_username_admin e mysql_password_admin that refers to the
    slave

EXAMPLE:

`voms_database=""                                    # VOMS database (leave unset)`
`master_host="voms.cnaf.infn.it"                     # Master hostname`
`master_mysql_user="bonjovi"                         # Master MySQL admin user for replication`
`master_mysql_pwd="always"                           # Master MySQL admin pass for replication user`
`master_log_file=""                                  # Master LOG file (leave unset)`
`master_log_pos=""                                   # Master LOG file (leave unset)`
`mysql_username_admin="root"                         # Slave MySQL admin username`
`mysql_password_admin="secret"                       # Slave MySQL admin pass`

with the launch of first-replica.sh, the file /etc/my.cnf will be
properly written; if you need to replicate further databases, modify
/etc/my.cnf adding the following lines related to the db you are
replicating (similar to the first db you've replicated):

`replicate-do-db=`<master_vo_db_name>
`replicate-ignore-table=`<master_vo_db_name>`.seqnumber`
`replicate-ignore-table=`<master_vo_db_name>`.realtime`
`replicate-ignore-table=`<master_vo_db_name>`.transactions`
`replicate-ignore-table=`<slave_vo_db_name>`.seqnumber`
`replicate-ignore-table=`<slave_vo_db_name>`.realtime`
`replicate-ignore-table=`<slave_vo_db_name>`.transactions`

Having set the variables in the way shown above, for replicating the
first database the scripts launch syntax is the following:

`./first_replica.sh --master-db=voms_myvo --db=voms_myvo`

In your /etc/my.cnf file you will find lines like the following:

`# Connection with master`
`server-id=2`
`master-host=voms.cnaf.infn.it`
`master-user=bonjovi`
`master-password=always`

`# Replicas settings`
`replicate-do-db=voms_myvo`
`replicate-ignore-table=voms_myvo.seqnumber`
`replicate-ignore-table=voms_myvo.realtime`
`replicate-ignore-table=voms_myvo.transactions`
`replicate-ignore-table=voms_myvo.seqnumber`
`replicate-ignore-table=voms_myvo.realtime`
`replicate-ignore-table=voms_myvo.transactions`

now you may want to replicate a second database, let's say voms_hervo:
therefore in my.cnf file add the following lines:

`replicate-do-db=voms_hervo`
`replicate-ignore-table=voms_hervo.seqnumber`
`replicate-ignore-table=voms_hervo.realtime`
`replicate-ignore-table=voms_hervo.transactions`
`replicate-ignore-table=voms_hervo.seqnumber`
`replicate-ignore-table=voms_hervo.realtime`
`replicate-ignore-table=voms_hervo.transactions`

modify the script next_replicas.sh in according to the VO parameters
and launch it:

`./next_replicas.sh --master-db=voms_hervo --db=voms_hervo`

when you finished to replicate all the desired VOs, in order to make
active the database modifications, restart voms and voms-admin:

`/etc/init.d/voms-admin stop`
`/etc/init.d/voms stop`
`/etc/init.d/voms start`
`/etc/init.d/voms-admin start`

Keep in mind that every modification done on the slave DB breaks the
replica mechanism, so that on this server disable the users
registration, by setting the yaim variable:

`VOMS_ADMIN_WEB_REGISTRATION_DISABLE=true`

and ask the VO managers to not perform any action on the slave server
web interface

## Revision History

| Version | Authors            | Date           | Comments                                    |
| ------- | ------------------ | -------------- | ------------------------------------------- |
| 1.0     | Alessandro Paolini | 2011-10-14     | First Draft                                 |
|         | M. Krakowian       | 19 August 2014 | Change contact group -\> Operations support |