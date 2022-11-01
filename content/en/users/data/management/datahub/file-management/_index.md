---
title: DataHub File Management
linkTitle: DataHub-File-Management
weight: 30
type: docs
aliases:
  - /users/datahub/datahub-file-management
description: >
  File Management in DataHub
---

## Web interface

All files in Onedata are organized in spaces. The Web User interface allows for
uploading new files as well as opening existing files.

In order to upload a file simply open the directory in which the file should be
placed and drag the file into the browser window:

![drag the file into the browser window](datahub-drag-file.png)

Opening or downloading a file simply requires double clicking on the file in the
file window. \*Make sure that the popups for this browser window are not
blocked, and unblock them if necessary.\*\*

## Direct access via POSIX

Files can also be accessed directly via POSIX protocol, using Oneclient tool.
Details on how to use are described
[here](https://onedata.org/#/home/documentation/doc/using_onedata/oneclient.html).

## CDMI (Cloud Data Management Interface)

For more advanced use cases, files can be managed using
[CDMI](http://www.snia.org/cdmi) protocol, as described in details
[here](https://onedata.org/#/home/documentation/doc/advanced/cdmi.html).

## File Permissions

You can control access to your data with a combination of:

- classical (POSIX) file permissions
- access control lists

## POSIX Permissions

Onedata allows you to control access to your data in a POSIX-like fashion for
users, group and others in terms of read, write and executable permissions.

An important nuance regarding file permissions is that all space members are
treated as a virtual group which is the group owner of all files in the space.
That means that whenever a file is accessed by a space member who is not the
owner of the file, the group permissions are taken into consideration.
Permissions for "others" are considered when accessing
[shares](https://onedata.org/#/home/documentation/doc/using_onedata/shares.html).

Consider the following example of file's POSIX permissions:

```shell
rwx r-- ---
 |   |   |
 |   |   guests
 |   |
 |   space members
 |
 owner user
```

In the above case, the creator of the file (its owner user) has a full access to
the file. All space members have read access to the file. Users (guests) who try
to access the file through a share will fail to do so as all permissions are
declined for "others".

In order to edit permissions:

1. Navigate to **Oneprovider** page
1. Click on **Data** on the left menubar
2. Select the Space you want to access and the **Data** option
1. Select a **file** or a **directory** and right clicking on it
1. Click on the **Permissions** option
1. Select **POSIX** type of permissions radio button at the top
1. Enter privileges in octal form (e.g. 770)
1. Click **OK** in order to save changes

![DataHub POSIX](datahub-posix.png)

## Access Control Lists

You can also setup permissions using more advanced Access Control Lists option
to control permissions for individual users and groups.

In order to edit ACL's:

1. Navigate to **Data** tab
1. Select a **file** or a **directory** by right clicking on it
1. Click on the **Permissions** option
1. Click on the **ACL** radio button
1. Edit permissions by clicking on the appropriate **checkbox**
1. Click **OK** in order to save changes

_Note, that access lists take precedence over POSIX permissions. If access list
is set, POSIX are set to octal value of 000._

The order in which permissions take precedence is indicated with an arrow.

![DataHub ACL](datahub-acl.png)
