---
title: MAN05 top-BDII and site-BDII High Availability
permalink: /MAN05_top-BDII_and_site-BDII_High_Availability/
---

[Category:Operations Manuals](/Category:Operations_Manuals "wikilink")

# (EMI.gLite) top-BDII and site-BDII High Availability

This document objective is to provide guidelines to improve the
availability of the information system, addressing three main areas:

1.  Requirements to deploy a TopBDII (siteBDII) service
2.  High Availability from a client perspective
3.  Configuration of a High Availability TopBDII (siteBDII) service



# Requirements to deploy a TopBDII (siteBDII) service

## Hardware

  - dual core CPU
  - 10GB of hard disk space
  - 2-3 GB RAM. If you decide to set BDII_RAM_DISK=yes in your YAIM
    configuration, it's advisable to have 4GB of RAM.

## Co-hosting

  - Due to the critical nature of the information system with respect to
    the operation of the grid, the TopBDII (siteBDII) should be
    installed as a stand-alone service to ensure that problems with
    other services do not affect the BDII. In no circumstances should
    the BDII be co-hosted with a service which has the potential to
    generate a high load.

## Physical vs Virtual Machines

  - There is no clear vision on this topic. Some managers complain that
    there are performance issues related to deploying a TopBDII
    (siteBDII) service under a virtual machine. Others argue that such
    performance issues are related to the configuration of the service
    itself. The only agreed feature is that the management and disaster
    recovery of any service deployed under a virtual machine is more
    flexible and easier. This could be an important point to take into
    account considering the critical importance of the TopBDII
    (siteBDII) service.

# Best practices from a client perspective for top-BDII

  - In gLite 3.2 and EMI you can set up redundancy of TopBDIIs for the
    clients (WNs and UIs) setting up a list of TopBDII instances to
    support the automatic failover in the GFAL clients. If the first Top
    level BDII fails to be contacted, the second will be used in its
    place, and so on. This mechanism is implemented defining the
    **BDII_LIST** YAIM variable according to the following syntax:

`BDII_LIST=topbdii.domain.one:2170[,topbdii.domain.two:2170[...]]. `

  - After running YAIM, the client enviroment should contain the
    following definition:

`LCG_GFAL_INFOSYS=topbdii.domain.one:2170,topbdii.domain.two:2170 `

  - The data management tools (lcg_utils) contact the information
    system for every operation (lcg-cr, lcg-cp, ...). So, if you have
    your client properly configured with redundancy for the information
    system, the lcg_utils tools will use that mechanism in a
    transparent way. Be aware that lcg-infosites doesn't work with
    multiple BDIIs. Only gfal, lcg_utils, lcg-info and glite-sd-query.

<!-- end list -->

  - Site administrators should configure their services with this
    failover mechanism where the first TopBDII of the list should be the
    default TopBDII provided by their NGI.



# Best practices for a TopBDII (siteBDII) High Availability service

  - The best practice proposal to provide a high availability TopBDII
    (siteBDII) service is based on two mechanisms working as main
    building blocks:

<!-- end list -->

1.  <big>**DNS round robin load balacing**</big>
2.  <big>**A fault tolerance DNS Updater**</big>

We will provide a short introduction to some of these DNS mechanisms but
for further information on specific implementations, please contact your
DNS administrator.

## DNS round robin load balacing

  - [Load balancing](http://en.wikipedia.org/wiki/Load_distribution) is
    a technique to distribute workload evenly across two or more
    resources. A load balancing method, which does not necessarily
    require a dedicated software or hardware node, is called [round
    robin DNS](http://en.wikipedia.org/wiki/Round-robin_DNS).

<!-- end list -->

  - We can assume that all transactions (queries to top-bdii (siteBDII))
    generate the same resource load. For an effective load balancing,
    all top-bdii (siteBDII) instances should have the same hardware
    configurations. In other case, a load balancing arbiter is needed.

<!-- end list -->

  - Simple round robin DNS load balancing is easy to deploy. Assuming
    that there is a primary DNS server (dns.top.domain) where the DNS
    load balancing will be implemented, one simply has to add multiple A
    records mapping the same hostname to multiple IP addresses under the
    core.top.domain [DNS zone](http://en.wikipedia.org/wiki/DNS_zone).
    It is equally applicable to site BDII.

`# In dns.top.domain: Add multiple A records mapping the same hostname to multiple IP addresses`
`Zone core.top.domain`
`topbdii.core.top.domain IN A x.x.x.x`
`topbdii.core.top.domain IN A y.y.y.y`
`topbdii.core.top.domain IN A z.z.z.z`

  - The 3 records are always served as answer but the order of the
    records will rotate in each DNS query

<!-- end list -->

  - **This does NOT provide fault tolerance against problems in the
    TopBDIIs (siteBDIIs) themselves**

<!-- end list -->

1.  if one TopBDII (siteBDII) fails its DNS “A” record will still be
    served
2.  one in each three DNS queries will provide the failed TopBDII
    (siteBDII) first answer

## Fault tolerance DNS Updater

  - The DNS Updater is a mechanism (to be implemented by you) which
    tests the different TopBDIIs (siteBDII) and decides to remove or add
    DNS entries through DNS dynamic updates. The fault tolerance is
    implemented by dynamically removing the DNS “A” records of
    unavailable TopBDII(s) (siteBDIIs).
    [nsupdate](http://linux.yyz.us/nsupdate/) introduced in bind V8
    offers the possibility of changing DNS records dynamically:

<!-- end list -->

1.  The nsupdate tool connects to a bind server on port 53 (TCP or UDP)
    and can update zone records
2.  Updates are authorized based on keys
3.  Updates can only be performed on the DNS primary server
4.  In the DNS bind implementation, the entire zone is rewritten by the
    DNS server upon “stop” to reflect the changes. Thefore, the zone
    should not be managed manually; and the changes are kept in a zone
    journal file until a “stop” happens.

### Implementation

  - There are several alternatives to implement the DNS Updater:

<!-- end list -->

1.  NAGIOS based tests
2.  a demonized service
3.  scripts running as crons

### What to test: BDII metrics

  - Status information about the BDII is available by querying the
    o=infosys root for the UpdateStats object. This entry contains a
    number of metrics relating to the latest update such as the time to
    update the database and the total number of entries. And example of
    such entry is shown below.

`$ ldapsearch -x -h `<TopBDII/siteBDII>` -p 2170 -b "o=infosys" `
`(...)`
`dn: Hostname=localhost,o=infosys`
`objectClass: UpdateStats`
`Hostname: lxbra2510.cern.ch`
`FailedDeletes: 0`
`ModifiedEntries: 4950`
`DeletedEntries: 1318`
`UpdateTime: 150`
`FailedAdds: 603`
`FailedModifies: 0`
`TotalEntries: 52702`
`QueryTime: 8`
`NewEntries: 603`
`DBUpdateTime: 11`
`ReadTime: 0`
`PluginsTime: 4`
`ProvidersTime: 113`

  - More extensive information can be obtained
    (modifyTimestamp,createTimestamp) adding the *+*:

`$ ldapsearch -x -h `<TopBDII/siteBDII>` -p 2170 -b "o=infosys" +`
`(...)`
`# localhost, infosys`
`dn: Hostname=localhost,o=infosys`
`structuralObjectClass: UpdateStats`
`entryUUID: 09bf40e0-7b23-4992-af55-fd74f036a454`
`creatorsName: o=infosys`
`createTimestamp: 20110612223435Z`
`entryCSN: 20110615120723.216201Z#000000#000#000000`
`modifiersName: o=infosys`
`modifyTimestamp: 20110615120723Z`
`entryDN: Hostname=localhost,o=infosys`
`subschemaSubentry: cn=Subschema`
`hasSubordinates: FALSE`

  - The following table shows the meaning of the most relevant metrics:

<center>

| Metric          | Desciption                                                 |
| --------------- | ---------------------------------------------------------- |
| ModifiedEntries | The number of objects to modify                            |
| DeletedEntries  | The number of objects to delete                            |
| UpdateTime      | To total update time in seconds                            |
| FailedAdds      | The number of add statements which failed                  |
| FailedModifies  | The number of modify statements which failed               |
| TotalEntries    | The total number of entries in the database                |
| QueryTime       | The time taken to query the database                       |
| NewEntries      | The number of new objects                                  |
| DBUpdateTime    | The time taken to update the database in seconds           |
| ReadTime        | The time taken to read the LDIF sources in seconds         |
| PluginsTime     | The time taken to run the plugins in seconds               |
| ProvidersTime   | The time taken to run the information providers in seconds |

</center>

  - Previous BDII metrics can be checked to take a decision regarding
    the reliability and availability of a TopBDII (siteBDII) instance.

<!-- end list -->

  - More information is available in [gLite-BDII_top
    Monitoring](https://twiki.cern.ch/twiki/bin/view/EGEE/BDII#Monitoring_the_BDII_Instance).



### DNS caching

  - DNS records obtained in queries are cached by the DNS servers
    (usually during 24 hours). Therefore to propagate DNS changes fast
    enough it is important to have very short TTL lifetimes.
  - DNS has not been built to have very short TTL values and these may
    increase highly the number of queries and as result increase the
    load of the DNS server
  - The TTL lifetime to be used will have to be tested.
  - If the top BDII are only used by sites in the region and if queries
    are only from the DNS servers of these few sites then the number of
    queries may be low enough to allow for a very small TTL
  - This value should not be lower than 30s - 60s

### Example 1: The IGI Nagios based mechanism

  - In IGI, the DNS update of the number of instances participating in
    the DNS round robin mechanism depends on the results provided by a
    Nagios instance.

<!-- end list -->

  - When Nagios needs to check the status of a service it will execute a
    plugin and pass information about what needs to be checked. The
    plugin verifies the operational state of the service and reports the
    results back to the Nagios daemon.

<!-- end list -->

  - Nagios will process the results of the service check and take
    appropriate action as necessary (e.g. send notifications, run event
    handlers, etc).

<!-- end list -->

  - Each instance is checked every 5 minutes. If a failure occurs,
    Nagios runs the event handler to restart the BDII service AND remove
    the instance from the DNS round robin set using dnsupdate:

<!-- end list -->

1.  an email is sent as notification;
2.  If 4 (out of 5) instances are failing, a SMS message is sent as
    notification;

<!-- end list -->

  - If a failed instance appears to be restored, nagios will re-add it
    to the DNS round robin mechanism.

[center|800px](/File:DNSUpdater@IGI.png "wikilink")

  - This approach has some single points of failures:

<!-- end list -->

1.  The Nagios instance can fail
2.  The master DNS where the DNS entries are updated can fail

### Example 2: The IBERGRID scripting based mechanism

  - In IBERGRID, an application (developed by LIP) verifies the health
    of each TopBDII. The application can connect to the DNS servers and
    remove the “A” records of TopBDIIs that become unavailable (non
    responsive to tests).

<!-- end list -->

  - The monitoring application (nsupdater) is a simple program that
    performs tests, and based on their result acts upon DNS entries

<!-- end list -->

1.  Written in perl
2.  Can be run as daemon or at the command prompt
3.  The tests are programs that are forked
4.  Tests are added in a "module" fashion way
5.  Can be used to manage several DNS round robin scenarios
6.  Can manage multiple DNS servers

[center|800px](/File:nsupdater@IBERGRID.png "wikilink")

  - To remove the DNS single point of failure as in previous example,
    one could configure all DNS servers serving the core.ibergrid.eu
    domain as primary

<!-- end list -->

1.  Three primary servers would then exist for core.ibergrid.eu
2.  All three DNS servers could be dynamically updated independently
3.  The monitoring application should also have three instances, one
    running at each site
4.  The downside is that DNS information can become incoherent. It would
    be up to the monitoring application to manage the three DNS servers
    content and their cohe

[center|800px](/File:nsupdater@IBERGRID2.png "wikilink")

# Revision history

| Version | Authors                                     | Date           | Comments                                                                   |
| ------- | ------------------------------------------- | -------------- | -------------------------------------------------------------------------- |
| 1.0     | Goncalo Borges, Jorge Gomes, Paolo Veronesi | 2011-06-15     | first draft                                                                |
| 1.1     | Paolo Veronesi                              | 2012-06-21     | This manual is equally applicable to site BDII, added some notes about it. |
|         | M. Krakowian                                | 19 August 2014 | Change contact group -\> Operations support                                |