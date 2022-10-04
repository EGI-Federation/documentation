---
title: "Handling alarms and tickets"
weight: 1
type: docs
description: >-
  How the ROD should deal with alarms and tickets using the dashboard.
---

## Alarms

Alarms are automatically generated notifications created by the
[Service Monitoring](../../../internal/) and are handled from within the
[Operations Portal dashboard](../../../internal/operations-portal).

### Handling alarms

When an alarm is generated, the site administrators have 24 hours to start
acting on the issue. If ROD spots an alarm, he can notify the site's
administrators about the problem.

- If the problem is fixed within 24 hours and the solution is tested by the
  Service Monitoring (the alarm's color turns green in the Dashboard), then ROD
  has to make sure that the results are not flapping and can close alarm without
  any other action.
- If the problem cannot be fixed within 24 hours, and the site administrators
  put the service into an unscheduled downtime, ROD should just wait until the
  problem is fixed or until the downtime is over. No other action is necessary.
- If the problem cannot be fixed within 24 hours and the administrators don't
  put the service into a downtime, then a ticket must be issued. The procedure
  is described below in the Tickets section.
- If the service is in downtime and the problem is fixed (as verified by the
  Service Monitoring), then ROD can close the alarm.
- If the downtime is over and the problem is still present (e.g. if the
  administrators forgot to extend the downtime), then a ticket must be issued.
- If an alarm is raised for a service that has its monitoring status set to OFF
  in EGI Configuration Database (also visible in the Dashboard in the Nodes box
  or in the alarm row as Node status) then ROD should not open a ticket.
- The alarm can be cleared even if it is marked red by pressing the lightning
  icon and giving an explanation.

For handling tickets during public holidays, see below. There is also a video
tutorial on handling alarms available.

## Tickets

In contrast with alarms, which are mere notifications, tickets are created
manually. They are used to report problems to the responsible support units.
Additionally, they allow to track the actions taken in order to resolve the
issue.

### Creating tickets

Ticket creation occurs when the age of an alarm in an error state has passed 24
hours, whether or not a site has already made some action on the alarm. A ticket
has to be created from the Operations Portal. In order to actually create a
ticket, click on the double arrow in the upper left corner next to the NGI name.
That opens the drop down box with information on the site. Then, open the New
NAGIOS alarms drop down box. Click the "T+" icon to create the ticket.

Refer to the
[Dashboard How-to](https://documents.egi.eu/public/ShowDocument?docid=301) if
you need a more detailed guide.

If more than one alarm should be handled by the same ticket, proceed as follows:

1. Create a ticket for one of the alarms.
2. Open the Assigned Alarms drop-down box. Click on the mask icon next to the
   alarm identifier.
3. A window will open in which you can select the alarms to be masked.

If an alarm, which is masked by another alarm, remains in "critical" condition
because of another (unrelated) problem, you can unmask it by clicking on the
mask icon again and close the ticket for the solved alarms.

1. Fill in the relevant information in the ticket section. If there was
   information in the site notepad, ensure that the ticket information reflects
   that information. Also ensure that the TO: select boxes, and FROM: and
   SUBJECT: fields are all correct. Generally, a ticket should go to all of
   site, NGI and ROD.
2. Press the Submit button and a pop up window will appear confirming that the
   ticket was correctly submitted. Your ticket has now been assigned a Helpdesk
   ID, but also an internal (hidden) Dashboard ID, which means that if you
   create a ticket through Dashboard, you have to close it through Dashboard as
   well. If you close a ticket opened through Dashboard in the Helpdesk, it will
   remain open in Dashboard!

### Creating tickets without an alarm

It is also possible to create a ticket for a site without an alarm. This can
happen if there is an issue with one of the tools that does not create an alarm
in Dashboard. In this case, click on the "T+" icon in the upper right corner of
the site box - the one with "Create a ticket (without an alarm)" tooltip, and
fill in the appropriate fields as when creating a ticket for an alarm.

### Ticket content templates

The email is addressed to the corresponding NGI, together with the site and ROD.
To view the list of NGI email addresses, click the Regional List link in the
Dashboard menu.

Generally, you should not remove any content from the template, but you are free
to add any information you think the site might find helpful in any of the three
editing fields (Header content, Main content, and Footer content).

### Changing the state of and closing a ticket

1. When the state of an alarm for a site with an open ticket changes to OK, then
   the ticket associated with that alarm can be updated in the Dashboard. Do
   this by clicking Update for the ticket in the Tickets drop down. Now change
   Escalate to Problem solved and fill in any information about how the problem
   has been solved. Clicking Update will then close the ticket in both the
   Helpdesk and the Dashboard.
2. If the Nagios alarm is in an unstable state, and the site has not responded
   to the problem in 3 days then a 2nd email can be sent to the site by updating
   the Escalate field to 2nd step.
3. If a new failure is detected for the site, the existing ticket should not be
   modified (though the deadline can be extended) but a new ticket should be
   submitted for this new problem.
4. If the site's problem can not be fixed in 3 days from the 2nd step of the
   escalation procedure then escalate the ticket to Political procedure. This
   means that the NGI manager will contact both EGI Operations and the site to
   negotiate about suspending the site.

### Sites with multiple tickets open

When opening a ticket against a site with existing tickets ROD should consider
that these problems may be linked or dependant on pending solutions. If the
problem is different but maybe linked the expiry dates for each ticket should be
synchronized to the latest date.

Also consider masking new problems with an old ticket.

## Handling alarms and tickets during weekends and public holidays

Due to the fact that weekends are not considered working days, it is noted that
ROD teams do not have any responsibilities during weekends and that RODs should
ensure that tickets do not expire during weekends. The alarm age does not
increase during the weekend.

Currently there is no automatic mechanism for handling ticket expiration over
public holiday periods, because they differ among countries. If some of the
sites the ROD team is in charge of are located in another country, the ROD is
encouraged to get them to announce their public holidays, so that ticket
expiration can be set accordingly. (Correspondingly, ROD operators also have no
duties when they are on public holidays.) The ROD can edit the ticket's
expiration day by clicking the "T+" (Edit Ticket) icon. The value is set to 3
days by default.

Please note that ROD is not requested to announce their national holidays to the
EGI Operations team. However, the last day before a public holiday, ROD is
requested to check

- if there are any tickets that are to be expired during the holiday and change
  their expiration date;
- if there are any alarms that will pass the 72 hour period during the holidays
  and handle them properly in advance.

## Workflow and escalation procedure

The workflow and escalation procedures are documented in more detail at
[PROC01 Infrastructure Oversight escalation](https://confluence.egi.eu/x/SiAmBg).
