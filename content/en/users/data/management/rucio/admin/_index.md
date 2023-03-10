---
title: Administering Rucio
linkTitle: Administration
type: docs
weight: 30
description: >-
  Help Rucio admins understand and perform actions for their VO
---

Within Rucio there are several levels of administrators. There are the **super
admins**, which are the staff that runs Multi-VO Rucio. Then there are virtual
organisation (VO) specific admins that will look after the day-to-day operations
of their VO. Below are some of the tasks that VO admins will need to do to set
up and maintain their VO.

## Creating Accounts, Identities, and Quotas

To add new users within your VO, you will need to communicate with Rucio as the
VO admin. Then using the rucio-admin commands, create a new account and add
identities to the account. The account is a username with no permissions, or
authentication methods. The identities bind authentication methods and
permissions to the account. The account you want to create identities for is
input as an argument. Accounts will have different permissions and access (such
as how much data they can store on a particular
[RSE](https://rucio.cern.ch/documentation/rucio_storage_element)).

### CLI Example

```shell
$ rucio-admin account add \
     --type USER \
     --email jdoe@email.com jdoe

Added new account: jdoe

$ rucio-admin identity add \
     --account jdoe \
     --type USER \
     --id userjdoe \
     --email jdoe@email.com \
     --password jdoepass

Added new identity to account: userjdoe-jdoe

$ rucio-admin account set-limits jdoe storagesite1 100GB

Set account limit for account jdoe on RSE storagesite1: 100.000 GB
```

### Python Client Example

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.add_account('jdoe', 'USER', 'jdoe@email.com')
True
>>> CLIENT.add_identity('jdoe', 'USER', 'jdoe@email.com')
True
>>> CLIENT.set_account_limit('jdoe', 'storagesite1', 107374182400, 'global')
True
```

## Creating RSE(s)

[Rucio Storage Elements](https://rucio.cern.ch/documentation/rucio_storage_element)
(RSEs) are how Rucio represents the physical storage available to your VO. As
with many aspects of Rucio there are a lot of optional attributes that can be
set for an RSE, but as a minimum a protocol for transfers need to be added
before it can be used.

### Creating RSE(s) CLI Example

```shell
$ rucio-admin rse add NEW_RSE

Added new deterministic RSE: NEW_RSE

$ rucio-admin rse add-protocol \
     --hostname test.org \
     --scheme gsiftp \
     --prefix '/filepath/rucio/' \
     --port 8443 NEW_RSE \
     --domain-json '{
                    "wan": {
                         "read": 1,
                         "write": 1,
                         "third_party_copy": 0,
                         "delete": 1
                         },
                    "lan": {
                         "read": 1,
                         "write": 1,
                         "third_party_copy": 0,
                         "delete": 1
                         }
                    }'
```

### Creating RSE(s) Python Client Example

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.add_rse('NEW_RSE')
True
>>> CLIENT.add_protocol(
     'NEW_RSE', {
          'hostname': 'test.org',
          'scheme': 'gsiftp',
          'prefix': '/filepath/rucio/',
          'port': 8443,
          'impl': 'rucio.rse.protocols.gfalv2.Default',
          'domain': {
               "wan": {
                    "read": 1,
                    "write": 1,
                    "third_party_copy": 0,
                    "delete": 1
                    },
               "lan": {
                    "read": 1,
                    "write": 1,
                    "third_party_copy": 0,
                    "delete": 1
                    }
               }
          }
     )
True
```

## Updating RSE Protocols

On occasion, it may be necessary to change or update an RSE protocol. Unlike
settings (`rucio-admin rse update`) or attributes
(`rucio-admin rse set-attribute`), there isn't a direct CLI function for
changing a protocol. It would therefore be necessary to remove
(`rucio-admin rse delete-protocol`) and then add
(`rucio-admin rse add-protocol`) it again using different information.
Alternatively, the Python client has additional functionality to directly update
or swap the priority of RSE protocols. For example to update the `impl` without
changing anything else (the `data` argument is used to update the protocol, with
the other settings used to specify the protocol to change):

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.update_protocols(
     rse='NEW_RSE',
     scheme='gsiftp',
     data={
          'impl': rucio.rse.protocols.gfal.Default'
          },
     hostname='test.org',
     port=8433
     )
True
```

To swap the priority of two protocols for the third party copy operation:

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.swap_protocols(
     rse='NEW_RSE',
     domain='wan',
     operation='third_party_copy',
     scheme_a='gsiftp',
     scheme_b='root'
     )
True
```

It's also worth noting that when an RSE is deleted using
`rucio-admin rse delete`, the entry remains in the database. This "soft"
deletion means that attempting to add a new RSE with the same name as a deleted
RSE will fail. This is due to the RSE not having a unique name/VO combination.
In practice, it is therefore better to update a badly configured RSE rather than
attempting to delete and re-add it. However, if the latter method is preferred,
it is possible manually rename the deleted RSE in the database (as there are no
foreign key constraints on its name, just the ID and VO) so that the old name
can be re-used.

## Basic Usage

This section covers some of the basic Rucio functions that can be run once the
VO has accounts and RSEs set up. As with the setup, there are many options that
won't be covered here. For more information refer to either the main
documentation or the help for the function in question.

### Daemons

Most operations in Rucio (such as transfers, deletions, rule evaluation) require
one or more of the
[daemons](https://rucio.cern.ch/documentation/main_components) to be running in
order to take effect. For a multi-VO instance, these should be running for all
VOs already. However, on new VO's joining Rucio some updating of the daemons
will be necessary.

If it seems like it is not quite right please contact the Rucio team through
[GGUS](https://ggus.eu/?mode=ticket_submit).

## Uploading Data

In Rucio files and their replicas are represented by Data Identifiers
([DIDs](https://rucio.cern.ch/documentation/file_dataset_container)), which are
composed of a scope and name. Furthermore, multiple files can be attached to a
dataset, which in turn can be attached to a container (which can be attached to
another container and so on). Datasets and containers are also represented by
DIDs.

Scopes are always associated with a particular Rucio account, and must be added
to Rucio using an admin account. If no scope is provided when uploading, Rucio
will default to `user.<account>`, but this still needs to have been added by an
admin.

Once a file has been uploaded via the CLI or Python client, it can then be
attached to a dataset. It's worth noting that by default, some Rucio commands
will not list files, only datasets.

### Uploading Data CLI Example

Assuming the file `test.txt` exists locally:

```shell
$ rucio-admin scope add --account root --scope user.root

Added new scope to account: user.root-root

$ rucio upload --rse NEW_RSE test.txt

2020-08-14 15:28:15,059 INFO    Preparing upload for file test.txt
2020-08-14 15:28:15,235 INFO    Successfully added replica in Rucio catalogue at NEW_RSE
2020-08-14 15:28:15,334 INFO    Successfully added replication rule at NEW_RSE
2020-08-14 15:28:15,579 INFO    Trying upload with mock to NEW_RSE
2020-08-14 15:28:15,579 295     INFO    Trying upload with mock to NEW_RSE
2020-08-14 15:28:15,580 INFO    Successful upload of temporary file. mock://test.org:123/filepath/rucio/user/root/46/6b/test.txt.rucio.upload
2020-08-14 15:28:15,580 295     INFO    Successful upload of temporary file. mock://test.org:123/filepath/rucio/user/root/46/6b/test.txt.rucio.upload
2020-08-14 15:28:15,580 INFO    Successfully uploaded file test.txt
2020-08-14 15:28:15,580 295     INFO    Successfully uploaded file test.txt
2020-08-14 15:28:15,583 295     DEBUG   Starting new HTTPS connection (1): rucio:443
2020-08-14 15:28:15,598 295     DEBUG   https://rucio:443 "POST /traces/ HTTP/1.1" 201 7
2020-08-14 15:28:15,662 295     DEBUG   https://rucio:443 "PUT /replicas HTTP/1.1" 200 0

$ rucio list-dids user.root:test.txt --filter type=ALL
+--------------------+--------------+
| SCOPE:NAME         | [DID TYPE]   |
|--------------------+--------------|
| user.root:test.txt | FILE         |
+--------------------+--------------+

$ rucio add-dataset user.root:test_dataset

Added user.root:test_dataset

$ rucio attach user.root:test_dataset user.root:test.txt

DIDs successfully attached to user.root:test_dataset

$ rucio list-content user.root:test_dataset
+--------------------+--------------+
| SCOPE:NAME         | [DID TYPE]   |
|--------------------+--------------|
| user.root:test.txt | FILE         |
+--------------------+--------------+
```

### Uploading Data Python Client Example

Assuming the file `test.txt` exists locally:

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.add_scope('root', 'user.root')

True

>>> from rucio.client.uploadclient import UploadClient
>>> UPLOAD_CLIENT = UploadClient()
>>> UPLOAD_CLIENT.upload([{'path': 'test.txt', 'rse': 'NEW_RSE'}])

2020-08-14 14:47:31,147 8431    DEBUG   Starting new HTTPS connection (1): rucio:443
2020-08-14 14:47:31,166 8431    DEBUG   https://rucio:443 "POST /traces/ HTTP/1.1" 201 7
2020-08-14 14:47:31,224 8431    DEBUG   https://rucio:443 "PUT /replicas HTTP/1.1" 200 None
0

>>> list(CLIENT.list_dids('user.root', {}, type='all'))

[u'test.txt']
>>> CLIENT.add_dataset('user.root', 'test_dataset')

True

>>> CLIENT.attach_dids('user.root', 'test_dataset', [{'scope': 'user.root', 'name': 'test.txt'}])
>>> list(CLIENT.list_content('user.root', 'test_dataset'))

[{u'adler32': u'00000001', u'name': u'test.txt', u'bytes': 0, u'scope': u'user.root', u'type': u'FILE', u'md5': u'd41d8cd98f00b204e9800998ecf8427e'}]
```

## Adding Replication Rules

Once a DID exists within the Rucio catalogue, replicas of that file, dataset or
collection are created and maintained by
[Replication rules](https://rucio.cern.ch/documentation/replica_management). By
uploading a file to a particular RSE, a replication rule is created for that
file, however rules can also be added for existing DIDs. As a minimum an RSE and
number of copies must be specified, but further options such as lifetime of the
rule and selecting RSEs based on user set attributes are also possible.

### Adding Replication Rules CLI Example

```shell
 $ rucio list-rules --account root

ID                                ACCOUNT    SCOPE:NAME          STATE[OK/REPL/STUCK]    RSE_EXPRESSION      COPIES  EXPIRES (UTC)    CREATED (UTC)
--------------------------------  ---------  ------------------  ----------------------  ----------------  --------  ---------------  -------------------
991f9ace7ed74cad989efde90b6a23c5  root       user.root:test.txt  OK[1/0/0]               NEW_RSE                  1                   2020-08-14 15:28:15
$ rucio add-rule user.root:test_dataset 1 NEW_RSE
bd51b767ef524878bb3cc68db16d2374

 $ rucio list-rules --account root

ID                                ACCOUNT    SCOPE:NAME              STATE[OK/REPL/STUCK]    RSE_EXPRESSION      COPIES  EXPIRES (UTC)    CREATED (UTC)
--------------------------------  ---------  ----------------------  ----------------------  ----------------  --------  ---------------  -------------------
991f9ace7ed74cad989efde90b6a23c5  root       user.root:test.txt      OK[1/0/0]               NEW_RSE                  1                   2020-08-14 15:28:15
bd51b767ef524878bb3cc68db16d2374  root       user.root:test_dataset  OK[1/0/0]               NEW_RSE                  1                   2020-08-14 15:47:15
```

### Adding Replication Rules Python Client Example

<!--
// jscpd:ignore-start
-->

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> list(CLIENT.list_account_rules('root'))

[{u'locks_ok_cnt': 1, u'source_replica_expression': None, u'locks_stuck_cnt': 0, u'purge_replicas': False, u'rse_expression': u'NEW_RSE', u'updated_at': datetime.datetime(2020, 8, 14, 15, 28, 15), u'meta': None,
u'child_rule_id': None, u'id': u'991f9ace7ed74cad989efde90b6a23c5', u'ignore_account_limit': False, u'error': None, u'weight': None, u'locks_replicating_cnt': 0, u'notification': u'NO', u'copies': 1, u'comments': None,
u'split_container': False, u'priority': 3, u'state': u'OK', u'scope': u'user.root', u'subscription_id': None, u'stuck_at': None, u'ignore_availability': False, u'eol_at': None, u'expires_at': None, u'did_type': u'FILE',
u'account': u'root', u'locked': False, u'name': u'test.txt', u'created_at': datetime.datetime(2020, 8, 14, 15, 28, 15), u'activity': u'User Subscriptions', u'grouping': u'DATASET'}]

>>> CLIENT.add_replication_rule([{'scope': 'user.root', 'name': 'test_dataset'}], 1, 'NEW_RSE')

[u'76b262b45dca4e769221224e1ccf5c7a']

>>> list(CLIENT.list_account_rules('root'))

[{u'locks_ok_cnt': 1, u'source_replica_expression': None, u'locks_stuck_cnt': 0, u'purge_replicas': False, u'rse_expression': u'NEW_RSE', u'updated_at': datetime.datetime(2020, 8, 14, 15, 28, 15), u'meta': None,
u'child_rule_id': None, u'id': u'991f9ace7ed74cad989efde90b6a23c5', u'ignore_account_limit': False, u'error': None, u'weight': None, u'locks_replicating_cnt': 0, u'notification': u'NO', u'copies': 1, u'comments': None,
u'split_container': False, u'priority': 3, u'state': u'OK', u'scope': u'user.root', u'subscription_id': None, u'stuck_at': None, u'ignore_availability': False, u'eol_at': None, u'expires_at': None, u'did_type': u'FILE',
u'account': u'root', u'locked': False, u'name': u'test.txt', u'created_at': datetime.datetime(2020, 8, 14, 15, 28, 15), u'activity': u'User Subscriptions', u'grouping': u'DATASET'}, {u'locks_ok_cnt': 1,
u'source_replica_expression': None, u'locks_stuck_cnt': 0, u'purge_replicas': False, u'rse_expression': u'NEW_RSE', u'updated_at': datetime.datetime(2020, 8, 14, 15, 47, 15), u'meta': None, u'child_rule_id': None, u'id':
u'bd51b767ef524878bb3cc68db16d2374', u'ignore_account_limit': False, u'error': None, u'weight': None, u'locks_replicating_cnt': 0, u'notification': u'NO', u'copies': 1, u'comments': None, u'split_container': False, u'priority':
3, u'state': u'OK', u'scope': u'user.root', u'subscription_id': None, u'stuck_at': None, u'ignore_availability': False, u'eol_at': None, u'expires_at': None, u'did_type': u'DATASET', u'account': u'root', u'locked': False,
u'name': u'test_dataset', u'created_at': datetime.datetime(2020, 8, 14, 15, 47, 15), u'activity': u'User Subscriptions', u'grouping': u'DATASET'}]
```

<!--
// jscpd:ignore-end
-->

## Multi-VO Features

From a users perspective, whether the instance is multi or single VO should not
change any functionality. Furthermore, depending on the client setup, VO does
not need to be provided. There are however, some occasions when an optional
argument for the VO can be given in a multi-VO instance.

### Swapping VOs

Just like how an identity can be associated with (and used to authenticate
against) multiple accounts, the same identity can be used for accounts at more
than one VO. Account and identity can be retrieved from the config file if
present, and the VO set there will be used (unless the environment variable
`RUCIO_VO` is also set, in which case the latter takes precedent). Both will be
ignored however if the VO is passed as an optional argument in the CLI or Python
client. Using this optional argument allows a user to quickly run commands on a
different VO they have access to.

#### Swapping VOs CLI Example

```shell
$ rucio whoami

status     : ACTIVE
account    : jdoe_abc_account
account_type : USER
created_at : 2020-08-07T08:27:29
updated_at : 2020-08-07T08:27:29
suspended_at : None
deleted_at : None
email      : N/A

$ rucio --vo xyz whoami

status     : ACTIVE
account    : jdoe_xyz_account
account_type : USER
created_at : 2020-08-11T12:13:58
updated_at : 2020-08-11T12:13:58
suspended_at : None
deleted_at : None
email      : N/A
```

#### Swapping VOs Python Client Example

```python
>>> from rucio.client import Client
>>> CLIENT = Client()
>>> CLIENT.whoami()

{u'status': u'ACTIVE', u'account': u'jdoe_abc_account', u'account_type': u'USER', u'created_at': u'2020-08-07T08:27:29', u'updated_at': u'2020-08-07T08:27:29', u'suspended_at': None, u'deleted_at': None, u'email': u'N/A'}

>>> CLIENT_XYZ = Client(vo='xyz')
>>> CLIENT_XYZ.whoami()

{u'status': u'ACTIVE', u'account': u'jdoe_xyz_account', u'account_type': u'USER', u'created_at': u'2020-08-11T12:13:58', u'updated_at': u'2020-08-11T12:13:58', u'suspended_at': None, u'deleted_at': None, u'email': u'N/A'}
```
