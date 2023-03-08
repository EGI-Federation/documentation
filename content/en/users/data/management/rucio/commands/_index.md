---
title: Rucio Command-Line Interface
linkTitle: Command Line
type: docs
weight: 20
description: >-
  The most common Rucio commands
---

## Introduction to Rucio commands

There are many commands found within Rucio CLI that you may want to become
familiar with. In this guide I will provide a few of the common commands wanted
by new users.

To find more of the commands that you may want to use type `rucio` into the
containerised client will provide all of the arguments for Rucio. Typing in the
command followed by `-h`, or `--help` will provide you with all the options that
are available as well as some explanation for each.

### ping

Is the simplest command that a user can use to ask the Rucio server which
version it is using.

```shell
$ rucio ping
```

This checks that there is a connection between the containerised client and the
server.

### whoami

Another simple command, which asks the server for the information Rucio has on
the current user.

```shell
$ rucio whoami
```

This will return output like the following:

```shell
status     : ACTIVE
account    : user1
account_type : USER
created_at : YYYY-MM-DDTHH:MM:SS
updated_at : YYYY-MM-DDTHH:MM:SS
suspended_at : None
deleted_at : None
email      : myemail@domail.country
```

This ensures that you know which user you are interacting with Rucio as, this is
very important if you get multiple accounts. But also verifies that the client
is set up correctly.

### upload

A Rucio command that allows you to upload files from your current environment to
any RSE within your VO.

```shell
$ rucio upload [-h] --rse RSE [--lifetime LIFETIME] [--scope SCOPE]
                    [--impl IMPL] [--register-after-upload] [--summary]
                    [--guid GUID] [--protocol PROTOCOL] [--pfn PFN]
                    [--name NAME] [--transfer-timeout TRANSFER_TIMEOUT]
                    [--recursive]
                    args [args ...]
```

Several of the options you will not need to use as they will be set by the Rucio
VO Admins when they set up the RSEs. Below are a list of options that you may
find useful:

- `RSE` is the Rucio Storage Element or site that you wish to store the data at,
  the list of available RSEs can be seen for your VO with the command
  `rucio list-rses`.
- `Lifetime` is how long you wish the file to exist, not specifying will make
  the file permanent until rucio is told to delete it.
- `Scope` can be used in many ways, but often can be an experiment name, or a
  user space, all users have their own scope assigned to them `user.<username>`.
- `Register-after-upload` allows for files to be uploaded to the destination,
  and then registered with Rucio, rather than the other way around. This can be
  useful if your connection is intermittent.
- `Name` is the name of the file that it will be registered to Rucio with, if
  this is not set it will be the name of the file or files provided.
- `Recursive` Allows you to set the argument to a directory, and all files within
  that directory and any subdirectories will be uploaded.
- `Args` is the path to the file, or files you wish to upload, this can be a
  single file, directory (with recursive set), or a list of files separated with
  a space e.g.

```shell
rucio upload --rse main-rse file1 file2 file3 file4
```

### get

A Rucio command to download files from any RSE in your VO to your local
environment.

```shell
$ rucio get [-h] [--dir DIR] [--allow-tape] [--rse RSE] [--rses RSES]
                 [--impl IMPL] [--protocol PROTOCOL] [--nrandom NRANDOM]
                 [--ndownloader NDOWNLOADER] [--no-subdir] [--pfn PFN]
                 [--archive-did ARCHIVE_DID] [--no-resolve-archives]
                 [--ignore-checksum] [--transfer-timeout TRANSFER_TIMEOUT]
                 [--transfer-speed-timeout TRANSFER_SPEED_TIMEOUT] [--aria]
                 [--filter FILTER] [--scope SCOPE] [--metalink METALINK_FILE]
                 [--deactivate-file-download-exceptions]
                 [dids [dids ...]]
```

- `Dir` is the location within the container you wish for the files to be
  downloaded (if you wish to move these files outside of the container, you may
  want to mount a volume in the container to allow the files to persist).
- `RSE(s)` specifying which RSE(s) you wish to download the files from, leaving
  this blank will allow Rucio to decide which RSE(s) are best.
- `nrandom` allows you to specify a number and if the target is a dataset or
  container will download n files from that DID. This allows you to check are
  correct before committing to download the entire dataset or container.
- `dids` is the data identifier for the file, dataset or container you wish to
  download.

### add-rule

Create a rule which Rucio will work to make true. These are often how files are
moved from site to site. Creating a rule that says file x (which is currently at
storagesite1), needs to be at storagesite2. Upon creation of the rule, Rucio
will ensure that the file is moved from where is closest to the new site.

```shell
$ rucio add-rule [-h] [--weight WEIGHT] [--lifetime LIFETIME]
                      [--grouping {DATASET,ALL,NONE}] [--locked]
                      [--source-replica-expression SOURCE_REPLICA_EXPRESSION]
                      [--notify NOTIFY] [--activity ACTIVITY]
                      [--comment COMMENT] [--ask-approval] [--asynchronous]
                      [--delay-injection DELAY_INJECTION]
                      [--account RULE_ACCOUNT] [--skip-duplicates]
                      dids [dids ...] copies rse_expression
```

- `lifetime` How long you want the file to persist before it can be deleted by
  Rucio.
- `locked` sets the dataset or container to a locked state, that prevents other
  files from being added or removed.
- `dids` the files within Rucio you wish to be replicates.
- `copies` How many copies of the data you want to make.
- `rse_expression` can either be a specific RSE, or can be a filter. Expression,
  such as `tape=True` or `country=UK` and Rucio will place as many copies as was
  requested in different sites (when possible), to fulfil the rule.

### delete-rule

A command to delete a rule which you have created. Just because you have deleted
a rule does not mean the file will be deleted. But it will adjust your quota
accordingly. Other people within your VO may also have a rule that states the
file needs to be at the same site.

```shell
$ rucio delete-rule [-h] [--purge-replicas] [--all]
                         [--rse_expression RSE_EXPRESSION] [--rses RSES]
                         [--account RULE_ACCOUNT]
                         rule_id
```

- `all` should not be used by users it it will attempt to delete all rules.
- `rse_expression` which RSE expression encapsulates the rules you wish to
  delete, either rse_expression, or RSE needs to be specified.
- `RSES` exactly which RSE is the target of the rule deletion.
- `account` which account requires the rule to be deleted, this is generally only
  needed by Rucio Admins and does not need to be specified if you are deleting
  your own rules.
- `rule_id` is a Rucio specific ID for the file that you wish to be deleted, a
  list of the rules, and their rule_ids that are within your account can be
  retrieved by running `rucio list-rules --account youraccountname`.

### list-rules

A command to list all the rules related to an account, a DID, or a file.

```shell
$ rucio list-rules [-h] [--id RULE_ID] [--traverse] [--csv] [--file FILE]
                        [--account RULE_ACCOUNT]
                        [--subscription ACCOUNT SUBSCRIPTION]
                        [did]
```

Provide a full list of the files IDs, account, scope, state, RSE/expression
copies and expiry.

- `account` specify which account you wish to see the replication rules.
- `file` If you know the name of a specific file, this allows you to see all the
  rules are associated with the file.
- `did` If a dataset or container are listed, all rules associated with the
  specific DID will be displayed.
