---
title: MAN06 Failover for MySQL grid based services
permalink: /MAN06_Failover_for_MySQL_grid_based_services/
---

[Category:Operations Manuals](/Category:Operations_Manuals "wikilink")

` `

# Introduction

  - Several critical grid services such as the Logical File Catalogue
    (LFC) or the VO Management Service (VOMS) server represent single
    points of failure in a grid infrastructure. When unavailable, a user
    can no longer access to the infrastructure since it is prevented
    from issuing new proxies, or is no longer able to access to the
    physical location of his data.

<!-- end list -->

  - However, those services rely on MySQL backends which opens a window
    to replicate the relevant databases to different / backup services
    which could be used when the primary instances are unavailable. The
    MySQL DB replication process is one of the ways to get scability and
    higher availability.



# Architecture

In this document we propose to follow a Master-Slave architecture for
the MySQL replication, consisting in keeping DB copies of a main host
(MASTER) in a secondary host (SLAVE). The slave host will only have read
access to the Database entries.



# Security

  - For better availability, it is preferable to deploy the Master and
    the Slave services in different geographical locations, which
    normally means exposing the generated traffic to the internet. In
    that case, you will have to find a mechanims to encrypt the
    communication between the two hosts.

<!-- end list -->

  - In this document, we propose to use **Stunnel**:

<!-- end list -->

1.  Stunnel is a free multi-platform computer program, used to provide
    universal TLS/SSL tunneling service.
2.  Stunnel can be used to provide secure encrypted connections for
    clients or servers that do not speak TLS or SSL natively. It runs on
    a variety of operating systems, including most Unix-like operating
    systems and Windows.
3.  Stunnel relies on a separate library such as OpenSSL or SSLeay to
    implement the underlying TLS or SSL protocol.
4.  Stunnel uses Public-key cryptography with X.509 digital certificates
    to secure the SSL connection. Clients can optionally be
    authenticated via a certificate too
5.  For more references, please check
    [www.stunnel.org](http://www.stunnel.org/)

<!-- end list -->

  - There are other possibilities for encryption, like enabling SSL
    Support directly in MySQL, but these approach was not tested.
    Details can be obtained
    [here](http://www.howtoforge.com/how-to-set-up-mysql-database-replication-with-ssl-encryption-on-centos-5.4).



# MySQL replication

## Assumptions

We are assuming that both grid services instances were previously
installed and configured (manually or via YAIM) so that they support the
same VOs.



## Generic information

<center>

| Description                   | Value              |
| ----------------------------- | ------------------ |
| MASTER hostname               | server1.domain.one |
| MASTER username               | root               |
| MASTER mysql superuser        | root               |
| MASTER mysql replication user | db_rep            |
| SLAVE hostname                | server2.domain.two |
| SLAVE username                | root               |
| SLAVE mysql superuser         | root               |
| DB to replicate               | DB_1 DB_2 ...    |

</center>



## Setup the MySQL MASTER for replication

  - **Step 1**: Install stunnel. It is available in the SL5
    repositories.

`$ yum install stunnel`
`(...)`

`$ date; rpm -qa | grep stunnel`
`Wed Jun 15 16:00:23 WEST 2011`
`stunnel-4.15-2.el5.1`

  - **Step 2**: Configure stunnel (via /etc/stunnel/stunnel.conf) to:

<!-- end list -->

1.  Accept incoming connections on port 3307, and allow to connect to
    port 3306
2.  Use the server X509 certificates to encrypt data

`$ cat  /etc/stunnel/stunnel.conf`
`# Authentication stuff`
`verify = 2`
`CApath = /etc/grid-security/certificates`
`cert = /etc/grid-security/hostcert.pem`
`key = /etc/grid-security/hostkey.pem`

`# Auth fails in chroot because CApath is not accessible`
`#chroot = /var/run/stunnel`
`#debug = 7`
`output = /var/log/stunnel.log`
`pid = /var/run/stunnel/master.pid`

`setuid = nobody`
`setgid = nobody`

`# Service-level configuration`
`[mysql]`
`accept  = 3307`
`connect = 127.0.0.1:3306`

  - **Step 3**: Start the stunnel service and add it to rc.local

`$ mkdir /var/run/stunnel`
`$ chown nobody:nobody /var/run/stunnel`
`$ stunnel /etc/stunnel.conf`
`$ echo 'stunnel /etc/stunnel.conf' >> /etc/rc.local`

  - **Step 4**: Setup the firewall to allow connections from the SLAVE
    instance (server2.domain.two with IP XXX.XXX.XXX.XXX) on port 3307
    TCP

`# MySQL replication`
`-A INPUT -s XXX.XXX.XXX.XXX -m state --state NEW -m tcp -p tcp --dport 3307 -j ACCEPT`

  - **Step 5**: Configure MySQL (via /etc/my.cnf) setting up the Master
    server-id (usually 1), and declaring the path for the MySQL binary
    log and the DBs to be replicated. Please make sure that the path
    declared under log-bin has the mysql:mysql ownerships, and that the
    binary log exists.

`$ cat /etc/my.cnf`
`(...)`
`[mysqld]`
`server-id=1`
`log-bin = /path_to_log_file/log_file.index`
`binlog-do-db=DB_2`
`binlog-do-db=DB_1`

  - **Step 6**: Restart MySQL

`$ /etc/init.d/mysqld restart`

  - **Step 7**: Add a specific user for the MySQL replication

`mysql > GRANT REPLICATION SLAVE ON *.* TO 'db_rep'@'127.0.0.1' IDENTIFIED BY '16_char_password';`

  - **Step 8**: Backup the databases using the following command. Please
    note tha the option "--master-data=2" writes a comment on dump.sql
    that shows the log file and the ID to be used on the Slave setup.
    This option also locks all the tables while they are beeing copied,
    avoiding problems.

`$ mysqldump -u root -p --default-character-set=latin1 --master-data=2 --databases DB_1 DB_2 > dump.sql`



## Setup the MySQL SLAVE for replication

**Step 1**: Configure stunnel (via /etc/stunnel/stunnel.conf) to:

1.  Accept incoming SSL connections on port 3307, and allow to connect
    to server1.domain.one on port 3307
2.  Use the server X509 certificates to encrypt data

`$ cat /etc/stunnel/stunnel.conf`
`# Authentication stuff`
`verify = 2`
`CApath = /etc/grid-security/certificates`
`cert = /etc/grid-security/hostcert.pem`
`key = /etc/grid-security/hostkey.pem`

`# Auth fails in chroot because CApath is not accessible`
`#chroot = /var/run/stunnel`
`#debug = 7`
`output = /var/log/stunnel.log`
`pid = /var/run/stunnel/master.pid`

`setuid = nobody`
`setgid = nobody`

`# Use it for client mode`
`client = yes`

`# Service-level configuration`
`[mysql]`
`accept  = 127.0.0.1:3307`
`connect = server1.domain.one:3307`

  - **Step 2**: Start stunnel and add it to rc.local

`$ mkdir /var/run/stunnel`
`$ chown nobody:nobody /var/run/stunnel`
`$ stunnel /etc/stunnel.conf`
`$ echo 'stunnel /etc/stunnel.conf' >> /etc/rc.local`

  - **Step 3**: Configure MySQL to include the SLAVE server-id
    (typically 2) and the replicated databases

`$ cat /etc/my.cnf`
`(...)`
`[mysqld]`
`server-id=2`
`replicate-do-db=DB_1`
`replicate-do-db=DB_2`

  - **Step 4**: Restart MySQL and insert the dump.sql created on the
    Master

`$ /etc/init.d/mysql restart`
`$ mysql -u root -p < dump.sql`

  - **Step 5**: Start the Slave loging in the mysql of slave, and
    running the following queries, changing the values xxxxx and yyyyy
    by the values on top of dump.sql file:

`mysql > CHANGE MASTER TO MASTER_HOST='127.0.0.1', MASTER_PORT=3307, MASTER_USER='db_rep', MASTER_PASSWORD='16_char_password',`
`        MASTER_LOG_FILE='xxxxx', MASTER_LOG_POS=yyyyy;`
`mysql > SLAVE START;`

  - **Step 6**: Your replication should be up and running. In case of
    troubles, check the Troubleshooting section.



## Troubleshooting

### On the Slave

  - Check if you can connect to the Master on port 3307 from the Slave

`[root@server2.domain.two]$ telnet server1.domain.one 3307`

  - Check the /var/log/stunnel.log on the Slave to see if stunnel is
    working. For established connections, you should find a message
    like:

`2011.05.30 11:57:45 LOG5[9000:1076156736]: mysql connected from XXX.XXX.XXX.XXX:PORTY`
`2011.05.30 11:57:45 LOG5[9000:1076156736]: VERIFY OK: depth=1, /DC=COUNTRY/DC=CA/CN=NAME`
`2011.05.30 11:57:45 LOG5[9000:1076156736]: VERIFY OK: depth=0, /DC=COUNTRY/DC=CA/O=INSTITUTE/CN=host/HOSTNAME`

  - Check the MySQL process list. You should get an answer like the one
    bellow:

`mysql> SHOW PROCESSLIST;`
`+--------+-------------+-----------+------+---------+---------+-----------------------------------------------------------------------------+------------------+`
`| Id     | User        | Host      | db   | Command | Time    | State                                                                       | Info             |`
`+--------+-------------+-----------+------+---------+---------+-----------------------------------------------------------------------------+------------------+`
`|      1 | system user |           | NULL | Connect | 1236539 | Waiting for master to send event                                            | NULL             |`
`|      2 | system user |           | NULL | Connect |   90804 | Slave has read all relay log; waiting for the slave I/O thread to update it | NULL             | `
`+--------+-------------+-----------+------+---------+---------+-----------------------------------------------------------------------------+------------------+`

  - Check the status of the slave

`mysql> SHOW SLAVE STATUS;`
`+----------------------------------+-------------+------------------+---------------------+`
`| Slave_IO_State                   | Master_Port | Master_Log_File  | Read_Master_Log_Pos |`
`+----------------------------------+-------------+------------------+---------------------+`
`| Waiting for master to send event |        3307 | mysql-bin.000001 |          126167682  |  `
`+----------------------------------+-------------+------------------+---------------------+`

### On the Master

  - Check the /var/log/stunnel.log on the Slave to see if stunnel is
    working. For established connections, you should find a message
    like:

`2011.05.30 11:57:45 LOG5[9000:1076156736]: mysql connected from XXX.XXX.XXX.XXX:PORTY`
`2011.05.30 11:57:45 LOG5[9000:1076156736]: VERIFY OK: depth=1, /DC=COUNTRY/DC=CA/CN=NAME`
`2011.05.30 11:57:45 LOG5[9000:1076156736]: VERIFY OK: depth=0, /DC=COUNTRY/DC=CA/O=INSTITUTE/CN=host/HOSTNAME`

  - Check if you have established connections from the Slave on port
    3307

`$ netstat -tapn | grep 3307`
`tcp        0      0 0.0.0.0:3307                0.0.0.0:*                   LISTEN      9000/stunnel        `
`tcp        0      0 XXX.XXX.XXX.XXX:3307        YYY.YYY.YYY.YYY:34378       ESTABLISHED 9000/stunnel        `

  - Check the Master status on MySQL. You should get an answer like:

`mysql> SHOW MASTER STATUS;`
`+------------------+-----------+--------------+------------------+`
`| File             | Position  | Binlog_Do_DB | Binlog_Ignore_DB |`
`+------------------+-----------+--------------+------------------+`
`| mysql-bin.000001 | 126167682 | DB_1         |                  | `
`+------------------+-----------+--------------+------------------+`
`1 row in set (0.00 sec)`

  - Check the MySQL process list. You should get an answer like the one
    bellow:

`mysql> SHOW PROCESSLIST;`
`+------+-----------+--------------------+--------+-------------+---------+----------------------------------------------------------------+------------------+`
`| Id   | User      | Host               | db     | Command     | Time    | State                                                          | Info             |`
`+------+-----------+--------------------+--------+-------------+---------+----------------------------------------------------------------+------------------+                                                | NULL             | `
`| 2778 | ibrepifca | localhost:42281    | NULL   | Binlog Dump | 1400477 | Has sent all binlog to slave; waiting for binlog to be updated | NULL             | `
`+------+-----------+--------------------+--------+-------------+---------+----------------------------------------------------------------+------------------+`

## The LFC case

### An working example

Using the MySQL replication mechanism, you can setup a read-only LFC
which can start to operate if the primary LFC is unavailable. The
following workflow tries to demonstrate how the mechanism is working:

  - Only the primary LFC is available in the information system

`$ lcg-infosites --vo ict.vo.ibergrid.eu lfc`
`lfc01.ncg.ingrid.pt`

  - If LFC_HOST env variable is not defined, lcg_utils will query the
    information system to get the VO LFC

`06/15/11-18:19:53 --> unset LFC_HOST env variable`
`06/15/11-18:19:53 --> copy data to SE and register it on the catalogue`
`06/15/11-18:19:53 --> running command: lcg-cr -v --vo ict.vo.ibergrid.eu -d se01-tic.ciemat.es -l lfn:/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl>
`Using grid catalog type: lfc`
`Using grid catalog : lfc01.ncg.ingrid.pt`
`Checksum type: None`
`SE type: SRMv2`
`Destination SURL : srm://se01-tic.ciemat.es/dpm/ciemat.es/home/ict.vo.ibergrid.eu/generated/2011-06-15/filea0e24e4a-4caf-4d31-a871-da0138bca1b6`
`Source SRM Request Token: da0f6de5-3dad-4d14-bd17-a5ae601043ec`
`Source URL: `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl>
`File size: 565`
`VO name: ict.vo.ibergrid.eu`
`Destination specified: se01-tic.ciemat.es`
`Destination URL for copy: gsiftp://se01-tic.ciemat.es/se01-tic.ciemat.es:/storage10/ict.vo.ibergrid.eu/2011-06-15/filea0e24e4a-4caf-4d31-a871-da0138bca1b6.1488163.0`
`# streams: 1`
`         565 bytes      1.19 KB/sec avg      1.19 KB/sec inst`
`Transfer took 1020 ms`
`Using LFN: lfn:/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt`
`Using GUID: guid:f602407d-bc36-4c0b-8346-219fb14f830b`
`Registering LFN: /grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt (f602407d-bc36-4c0b-8346-219fb14f830b)`
`Registering SURL: srm://se01-tic.ciemat.es/dpm/ciemat.es/home/ict.vo.ibergrid.eu/generated/2011-06-15/filea0e24e4a-4caf-4d31-a871-da0138bca1b6 (f602407d-bc36-4c0b-8346-219fb14f830b)`
`guid:f602407d-bc36-4c0b-8346-219fb14f830b`

  - We now explicitly switch to the backup LFC (not being published in
    the information system), and we do see that the file already appears
    there registered.

`06/15/11-18:20:01 --> export LFC_HOST to backup LFC`
`06/15/11-18:20:01 --> running command: export LFC_HOST=ibergrid-lfc.ifca.es`
`06/15/11-18:20:01 --> list the backup LFC`
`06/15/11-18:20:01 --> running command: lfc-ls /grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt`
`/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt`

  - We can copy data around reading entries from the backup LFC

`06/15/11-18:20:01 --> Copy data using the backup LFC`
`06/15/11-18:20:01 --> running command: lcg-cp -v --vo ict.vo.ibergrid.eu lfn:/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl2>
`Using grid catalog type: LFC`
`Using grid catalog : ibergrid-lfc.ifca.es`
`VO name: ict.vo.ibergrid.eu`
`Checksum type: None`
`Trying SURL srm://se01-tic.ciemat.es/dpm/ciemat.es/home/ict.vo.ibergrid.eu/generated/2011-06-15/filea0e24e4a-4caf-4d31-a871-da0138bca1b6 ...`
`Source SE type: SRMv2`
`Source SRM Request Token: 3e0be4f1-f9e9-40f4-8f9f-321a115840ba`
`Source URL: /grid/ict.vo.ibergrid.eu/goncalo_borges/mytest.txt`
`File size: 565`
`Source URL for copy: gsiftp://se01-tic.ciemat.es/se01-tic.ciemat.es:/storage10/ict.vo.ibergrid.eu/2011-06-15/filea0e24e4a-4caf-4d31-a871-da0138bca1b6.1488163.0`
`Destination URL: `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl2>
`# streams: 1`
`           0 bytes      0.00 KB/sec avg      0.00 KB/sec inst`
`Transfer took 1030 ms`

  - However, we can not register new files in the backup LFC

`06/15/11-18:30:10 --> copy data to SE and register it on the catalogue`
`06/15/11-18:30:10 --> running command: lcg-cr -v --vo ict.vo.ibergrid.eu -d se01-tic.ciemat.es -l lfn:/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest2.txt `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl>
`Using grid catalog type: lfc`
`Using grid catalog : ibergrid-lfc.ifca.es`
`Checksum type: None`
`SE type: SRMv2`
`Destination SURL : srm://se01-tic.ciemat.es/dpm/ciemat.es/home/ict.vo.ibergrid.eu/generated/2011-06-15/file8a30add9-b247-4037-9d42-981728ae3e76`
`Source SRM Request Token: 4029fcc2-281f-4e9a-a843-e8a3a67623ff`
`Source URL: `<file:/home/ingrid/csys/goncalo/scriptInputData.jdl>
`File size: 565`
`VO name: ict.vo.ibergrid.eu`
`Destination specified: se01-tic.ciemat.es`
`Destination URL for copy: gsiftp://se01-tic.ciemat.es/se01-tic.ciemat.es:/storage17/ict.vo.ibergrid.eu/2011-06-15/file8a30add9-b247-4037-9d42-981728ae3e76.1488174.0`
`# streams: 1`
`         565 bytes      1.28 KB/sec avg      1.28 KB/sec inst`
`Transfer took 1020 ms`
`Using LFN: lfn:/grid/ict.vo.ibergrid.eu/goncalo_borges/mytest2.txt`
`Using GUID: guid:e1b977c7-290a-410f-ad31-be4feeb67b11`
`Registering LFN: /grid/ict.vo.ibergrid.eu/goncalo_borges/mytest2.txt (e1b977c7-290a-410f-ad31-be4feeb67b11)`
`[LFC][lfc_creatg][] ibergrid-lfc.ifca.es: guid:e1b977c7-290a-410f-ad31-be4feeb67b11: Read-only file system`
`srm://se01-tic.ciemat.es/dpm/ciemat.es/home/ict.vo.ibergrid.eu/generated/2011-06-15/file8a30add9-b247-4037-9d42-981728ae3e76: Registration failed, please register it by hand, when the problem will be solved`
`guid:e1b977c7-290a-410f-ad31-be4feeb67b11`
`lcg_cr: Communication error on send`

### Swapping between LFCs

  - Unfortunately the middleware does not offer an automatic way to swap
    to the backup LFC in case the primary fails. Therefore, it is up to
    the user (or to the application) to determine if a given LFC is
    available or not.

<!-- end list -->

  - In the previous example, we have followed the approach where only
    the primary LFC is available through the information system. One can
    assume that, if the primary LFC is not available in the information
    system, it means that either it is down or unreachable. In that
    case, the user or application could switch to the backup LFC.

`` $ export LFC_HOST=`lcg-infosites --vo ict.vo.ibergrid.eu lfc` ``
`$ if [ "X$LFC_HOST" == "X" ]; then export LFC_HOST=`<backup LFC FQDN>`; fi`

## The VOMS case

### A working example

  - It is also possible to deploy a backup VOMS server with a MySQL
    replica of the main VOMS server. This will enable users to still
    start proxies even if the main VOMS server is down.

<!-- end list -->

  - The VOMS Admin interface of the backup VOMS server should be
    switched off so that new users can only request registration via the
    main VOMS Admin Web interface.

<!-- end list -->

  - User interfaces should be configured to use both VOMS servers

`$ voms-proxy-init --voms ict.vo.ibergrid.eu`
`Enter GRID pass phrase:`
`Your identity: /C=PT/O=LIPCA/O=LIP/OU=Lisboa/CN=Goncalo Borges`
`Creating temporary proxy .............................................................. Done`
`Contacting  voms01.ncg.ingrid.pt:40008 [/C=PT/O=LIPCA/O=LIP/OU=Lisboa/CN=voms01.ncg.ingrid.pt] "ict.vo.ibergrid.eu" Done`
`Creating proxy .......................................................................................................................................................... Done`
`Your proxy is valid until Thu Jun 16 07:27:31 2011`

`$ voms-proxy-init --voms ict.vo.ibergrid.eu`
`Enter GRID pass phrase:`
`Your identity: /C=PT/O=LIPCA/O=LIP/OU=Lisboa/CN=Goncalo Borges`
`Creating temporary proxy ............................................................. Done`
`Contacting  ibergrid-voms.ifca.es:40008 [/DC=es/DC=irisgrid/O=ifca/CN=host/ibergrid-voms.ifca.es] "ict.vo.ibergrid.eu" Done`
`Creating proxy ............................................................................ Done`
`Your proxy is valid until Thu Jun 16 07:27:37 2011`

# Revision history

| Version | Authors        | Date           | Comments                                    |
| ------- | -------------- | -------------- | ------------------------------------------- |
| 1.0     | Goncalo Borges | 2011-06-16     | first draft                                 |
|         | M. Krakowian   | 19 August 2014 | Change contact group -\> Operations support |