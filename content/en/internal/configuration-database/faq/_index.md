---
title: "FAQ"
weight: 100
type: "docs"
description: "Frequently Asked Questions"
---

## I have lost access to my account, what should I do?

If you were registered but are not recognised anymore (e.g. because your
certificate DN changed), do not register again!

Instead, follow the steps
[Lost access to your Configuration Database account](../users-roles/managing-accounts#lost-access-to-your-account)
section.

## I am responsible for a site that has recently entered the EGI infrastructure. How do I register it?

Only registered users with an approved role on an NGI can add a new site. If you
are the site administrator, the first thing to do is to contact your NGI staff
and ask them to add the site for you. Then, register to EGI Configuration
Database (see the user account section) and ask for a site admin role for your
site (see the requesting a role section). Once your role approved, you will be
able to edit and change your site information.

## How do I extend a declared schedule downtime?

Because of EGI policies it is not possible to extend a downtime. Recommended
good practice for any downtime extension is to declare a new unscheduled
downtime, starting just when the first one finishes. Please refer to the
downtimes section of this documentation for more information, especially the
"downtime extension" paragraph.

## I have declared a downtime "at risk", and it turns out to be an outage. How can I declare this properly?

If you have declared the downtime as being at risk and an outage actually
happens half way through, you need to update the Configuration Database to
reflect the fact that your site is now down. There is currently no way of doing
this by updating the downtime on the fly without having the system considering
the whole downtime as being an outage. The best way to proceed is:

- Modify end date of your "at risk" downtime, so that it ends in a few minutes
- Enter a new "outage" downtime, starting when the other ends

## How do I switch monitoring on/off for my nodes?

Monitoring status in Configuration Database cannot always be switched off. If a
node is declared as delivering a production service, rules apply and the node
has to be monitored. If you are running a test node and want to switch
monitoring off, set both "monitoring" and "production" to "N".

## Why nobody has approved my role request yet?

Someone has to approve any request you make, in order to ensure nobody is trying
to get inappropriate roles. If yours is not getting approved, this can either be
because your request was not legitimate, or most likely because the people that
are supposed to do it forgot about it. Please refer to the Roles permissions
definitions section of this documentation to determine who should validate your
role, and try to get in touch with them. If you are requesting a site admin
role, they are likely to be your fellow site admins or your NGI operators.

## I am not an EGI user but need access to the backend to retrieve information for my project. What can I do?

Accessing the backend through another way than the
[Configuration Database web interface](https://goc.egi.eu) is out of the scope
of this documentation. Please refer to the technical documentation instead,
which is available from GOCDB Documentation.
