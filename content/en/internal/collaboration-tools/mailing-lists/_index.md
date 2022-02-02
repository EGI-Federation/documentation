---
title: "Mailing lists"
type: docs
weight: 20
description: >
  Mailing lists usage
---

Mailing lists are managed by software called Mailman.

The software provides a web interface and a
[public list of mailing lists](https://mailman.egi.eu/mailman/listinfo) is
available.

## Requesting the creation of a new mailing list

> By default all mailing lists are managed using groups in EGI SSO. Only for
> very specific they may be managed directly in mailman.

Open a ticket to Collaboration Tools SU in [EGI Helpdesk](../../helpdesk),
providing:

- List name
- List Description
- List administrator contact

After validation of those information the list will be created.

Name and description of the mailing list will be validated, you may be
recommended to change name or description to follow already existing best
practices for naming, or to improve description.

## List administrators

EGI mailing lists are usually managed by EGI SSO, with some exceptions for lists
that include members without SSO accounts.

List administrators of every SSO-managed list are set to the owners of the
corresponding EGI SSO group when a new list is created.

{{% alert title="Note" color="info" %}} For SSO managed-lists: a change to the
list of list administrators through the Mailman interface will not be permanent.
{{% /alert %}}

Only the EGI IT support can change who are the owners of an SSO group, please
[contact us](mailto:it-support@egi.eu) if you want to add a new list
administrator.

Each list can be administered over the web interface by following its link from
the page Admin links. You can use your EGI SSO password to access the
administration pages of the lists for which you are the administrator.

## List members

Members of lists are synchronized with members of same named groups in the EGI
SSO system.

{{% alert title="Note" color="info" %}} For SSO managed-lists: Changes made to
list membership through the Mailman interface will not be permanent.
{{% /alert %}}

Managing list members must be done by managing members of corresponding groups
in EGI SSO. Log into your EGI SSO account, and you will see a list of groups of
which you are the owner. Click on the "»manage" link, it will display a page
where you can

- remove members from the group
- add existing users as members of thew group
- invite new users to the group

If you manage more then one list, and you need to add many new users to several
lists at once, it may be helpful to follow the link titled "»Create new users in
groups". It directs to a page where you can enter many addresses at once, and
specify the groups to which they should be added. Existing users will be added
immediately, non-existing users will be invited to create an account and they
will be assigned to the groups when they create the account.

## Documentation

- [Mailman documentation](http://www.gnu.org/software/mailman/docs.html)
- [Mailman Frequently Asked Questions](https://wiki.list.org/DOC/Frequently%20Asked%20Questions)
- [List administrator tasks](https://wiki.list.org/DOC/3%20List%20administrator%20tasks)
