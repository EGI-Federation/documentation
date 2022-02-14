---
title: "IM Dashboard"
type: docs
weight: 30
description: >
  How to run use the IM Dashboard graphical interface
---


The IM Dashboard is a graphical interface for the IM Server specially developed
for EOSC users to access EGI Cloud Compute resources.

Functionalities:

- OIDC authentication
- Display user's infrastructures
- Display infrastructure details, template and log
- Delete infrastructure
- Create new infrastructure
- Add nodes to an infrastructure
- Resize VMs

More details about installation and configuration in the
[IM Dashboard documentation page](https://imdocs.readthedocs.io/en/latest/dashboard.html).

## Usage

The dashboard of the IM enables non advanced users to manage their
infrastructures by launching a set of predefined TOSCA templates on top of EGI
Cloud Compute resources. The dashboard does not provide all the features
provided by the IM service. In case you need more advanced features use the
[IM Web interface](https://imdocs.readthedocs.io/en/latest/web.html) or the
[IM-CLI](../cli).

![Landing page](dash_login.png)

### Login

The user will use the [EGI Check-in Service](../../check-in) to log into the
dashboard. Once authenticated, the user will be redirected to the portfolio
of available TOSCA templates.

![Portfolio page](dash_configure.png)

### Main menu bar

The main menu bar is located at the top of the pages:

- The first button `IM Dashboard` enables the user to go to the the portfolio of
  available TOSCA templates.
- Second item `Infrastructures` redirects to the list of current user deployed
  infrastructures.
- In the `Advanced` item the `Settings` subitem displays some
  configuration settings as the URL of the IM service or the OIDC issuer.
- `External Links` show a set of configurables information links (documentation,
  video tutorials, etc.)
- Finally, on the right top corner, appears the `User` menu item. This item shows
  the full name of the logged user, and an avatar obtained from
  [Gravatar](https://www.gravatar.com/). In this menu the user can access their
  `Cloud Credentials` with the cloud providers or log out from the application.

### Cloud Credentials

This page allows the user to specify the credentials for accessing any cloud
provider. In the list the user can edit, delete and enable or disable the
selected cloud credentials.

![List of Cloud Credentials](dash_cred_list.png)

Editing or adding the credentials will show a modal form where the user has the
ability to specify all the parameters needed to access the supported cloud providers.
In particular, for [EGI Cloud Compute](../../cloud-compute) sites the
user has only to select one of the VOs he is member and one of sites that
supports that VO. These dropdown fields are generated using the information
available from the sites and the list of VOs the user is member of.

![Edit/Add a Crecential](dash_edit_cred.png)

### TOSCA Templates

The list of available TOSCA templates enables the user to select the required
topology to deploy. Each TOSCA template can be labelled by the TOSCA developer
with any tag that will show a ribbon displayed on the right bottom corner.
The special `elastic` tag is used to mark templates that are configured to
automatically manage the elasticity of the deployed cluster.

The user must click on the `Configure` button to set the input values of the
TOSCA template and select the VO, Site and Image to use for deploying the
infrastructure.

Initially the user can set a name to describe the infrastructure to be deployed.
It will simplify identifying infrastructures. In the firsts tabs, the user can
introduce the set of input values of the topology. By default there is only one
tab called `Input Values`, but the TOSCA developer can add or rename them to
simplify the selection of input values.

![TOSCA input values.](dash_inputs.png)

The final tab will be the `Cloud Provider Selection`. In this tab the user first
has to select one of the Cloud providers that has been previously added (and
not disabled) in the `Cloud Credentials` page, then has to select the base
image used to deploy the VMs. In case of EGI Cloud Compute sites, the user has
two options: he can select an image from the list of images provided by the
[EGI AppDB information system](https://appdb.egi.eu/) or from the list provided
directly by the Cloud site.

Other providers will only show a dropdown list with the available images.
Only in the case of AWS Cloud provider the user has to specify manually the AMI
ID of the image.

![Select Cloud Provider and Image](dash_site.png)

### Infrastructures

This page lists the infrastructures deployed by the user.
The first column shows the name set by the user on infrastructure creation,
then shows the ID assigned by the IM service, the third column shows the current
status of the infrastructure, the fourth show the list of VMs with their IDs and
finally appears a button with a set of actions.

![List of infrastructures.](dash_inf_list.png)

#### List of Actions

The following figure shows the list of actions available to manage the existing
infrastructures:

![List of infrastructure Actions](dash_inf_actions.png)

- Add nodes: The Add nodes action enables to add new VMs to the users'
  deployment. It will show the list of the different types of nodes
  currently deployed in the infrastructure and the user must set the number
  of nodes of each type he wants to deploy.

   ![Add nodes page](dash_add_nodes.png)

- Show template: This action shows the original TOSCA template submitted to
  create the infrastructure.

- Log: Shows the error/contextualization log of the infrastructure.

- Stop: Stops/Suspends all the VMs of the infrastructure.

- Start: Starts/Resumes a previously stopped infrastructure.

- Outputs: Shows the outputs of the TOSCA template. Private key of
  credentials can be downloaded as a file or copied to the clipboard.

   ![TOSCA outputs](dash_outputs.png)

- Delete: Delete this infrastructure and all the asociated resources. It also
  has the option to force the deletion. In this case the infrastructure will
  be removed from the IM service even if some cloud resources cannot be deleted.
  **Only use this option if you know what you are doing**.

- Delete & Recreate: Delete this infrastructure as the previous option, but
  once it is deleted it will redirect to the infrastructure creation form, with
  all the input fields filled with the same set of values used to create the
  deleted infrastructure.

- Reconfigure: Starts the reconfiguration of the infrastructure.

### VM Info page

The VM Info page shows all the information about the selected VM and
enables to manage the lifecycle of it. On the top right corner the `Manage VM`
dropdown menu allows to Stop/Start, Reboot, Resize, Reconfigure and Terminate
the VM. Furthermore the user can check the error or contextualisation log of this
particular VM.

The VM infomation is splitted in two dofferent tables, the first one with the
main information: State, IPs, HW features and the SSH credentials needed to
access it. The second table shows additional fields.

![VM Info page](dash_vm_info.png)

When resizing the VM the user must provide the new size of the VM in terms
of number of CPUs and amount of memory as shown in the figure below:

![VM Resize modal form.](dash_vm_resize.png)
