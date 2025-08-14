---
title: Sharing and RTC
linkTitle: Sharing
weight: 30
type: docs
aliases:
  - /users/notebooks/sharing
description: >
  User initiated sharing and Real-Time collaboration
---

User-initiated sharing is a mechanism allowing users to share access to their
Jupyter server with other users via the Jupyterhub user sharing API. EGI
Notebooks provide you this feature via user sharing menu.

{{% alert title="Warning" color="warning" %}}

By allowing other users to access your server, you also allow them to access the
files present on your Jupyter server. Do not store any secrets on your server if
you are planning to share!

{{% /alert %}}

## Inviting users

You can find the user sharing menu can be opened from the top bar, click on
**User sharing -> Open user sharing menu**

![user sharing menu](notebooks-user-sharing.png)

With the user sharing menu window opened, you can now generate invite links and
share them with other users.

![user sharing window](notebooks-user-sharing-window.png)

{{% alert title="Warning" color="warning" %}}

- Each link is valid only **1 hour**
- The link can be used by **multiple** users to get an access to your server
- Only users **with access to the EGI Notebooks service** can access your server
- Once all users you want to share access with are connected to your server, you
  can revoke the validity of the generated link by clicking on the button
  **Revoke all share links**

{{% /alert %}}

Once the invited user has accepted an invitation and authorized access, you can
start collaborating on the same server.

## Controlling access to the server

You can see IDs of all users who accepted your invitation and time when they did
from the User sharing menu. Click the Refresh button or re-open the user sharing
menu window to get an updated view.

![user sharing user list](notebooks-user-sharing-list.png)

Click on the corresponding **Revoke** button to revoke access for a concrete
user or click on **Revoke All users** to revoke access for all users.

Other users access will last until you stop your server. At the start of each new session,
all granted access will be revoked.

{{% alert title="Warning" color="warning" %}}

- Even after revoking, invited users can **still** be on your running server for
  some time before the Jupyter server prevents them from more access. Therefore,
  if you wish to see changes immediately, you have to open the topbar menu
  **File -> Hub Control Panel** and then **stop** your server.

- Also remember that generated invitation links can still be used to get access
  to your server until they expire or you revoke them. {{% /alert %}}

{{% /alert %}}

## Real-time collaboration

Real-time collaboration(RTC) allows you to leverage the power of user-initiated
sharing to see each other's edits in real time.

How do I enable RTC ? To enable RTC, you first have to open a terminal tab

Then you have to execute 2 commands to enable RTC extensions:

jupyter labextension enable @jupyter/docprovider-extension jupyter labextension
enable @jupyter/collaboration-extension

Warning!

You can also disable RTC the same way via 2 commands:

jupyter labextension disable @jupyter/docprovider-extension jupyter labextension
disable @jupyter/collaboration-extension But disabling RTC extension wlll not
revoke access to your server. You have to use the user sharing menu for that.

Once you enabled the extensions, you need to refresh your browser tab to see
changes.

When you do, you can verify your Jupyter server is in RTC mode by checking the
top-right corner.

You should be able to see your RTC icon at the top right corner.

Now you can see users collaborating with you on your server, files they are
working on and their edit in real time.
