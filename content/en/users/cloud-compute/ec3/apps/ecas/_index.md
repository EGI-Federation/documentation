---
title: "ECAS"
type: docs
weight: 10
description: >
  Using Elastic Cloud Computing Cluster (EC3) platform to create an ECAS
  environment.
---

The following guide is intended for researchers who want to use ECAS, a complete
environment enabling data analysis experiments, in the EGI cloud.

ECAS (ENES Climate Analytics Service) is part of the EOSC-hub service catalog
and aims to:

1. provide server-based computation,
1. avoid data transfer, and
1. improve reusability of data and workflows.

It relies on [Ophidia](http://ophidia.cmcc.it/), a data analytics framework for
eScience, which provides declarative, server-side, and parallel data analysis,
jointly with an internal storage model able to efficiently deal with
multidimensional data and a hierarchical data organization to manage large data
volumes ("datacubes"), and on JupyterHub, to give users access to ready-to-use
computational environments and resources.

Thanks to the Elastic Cloud Compute Cluster (EC3) platform, operated by the
[Polytechnic University of Valencia (UPV)](http://www.upv.es/index-en.html),
researchers will be able to rely on the EGI Cloud Compute service to scale up to
larger simulations without being worried about the complexity of the underlying
infrastructure.

This guide will show how to:

- deploy an ECAS elastic cluster of VMs in order to automatically install and
  configure the whole ECAS environment services, i.e. JupyterHub, PyOphidia,
  several Python libraries such as numpy, matplotlib and Basemap;
- perform data intensive analysis using the Ophidia HPDA framework;
- access the ECAS JupyterHub interface to create and share documents containing
  live code, equations, visualizations and explanatory text.

## Deploy an ECAS cluster with EC3

In the latest release of the EC3 platform, tailored to support the EGI
[Applications on Demand (AoD) service](../../../applications-on-demand), a new
Ansible receipt is now available for researchers interested to deploy ECAS
cluster on the EGI Infrastuctrure. Additional details on how to configure and
deploy an ECAS cluster on EGI resources are provided in the next sections.

ECAS in now available in the latest release of the EC3 platform supporting the
EGI Applications on Demand (AoD). The next sections provide details on how to
configure and deploy an ECAS cluster on EGI resources.

### Configure and deploy the cluster

To configure and deploy a Virtual Elastic Cluster using EC3, access the
[EC3 platform front page](https://servproject.i3m.upv.es/ec3-ltos/index.php) and
click on the **\"Deploy your cluster\"** link as shown in the figure below:

![EC3 front page.](ecas-front.png)

A wizard will guide you through the cluster configuration process. Specifically,
the general wizard steps include:

- **LRMS selection**: choose **ECAS** from the list of LRMSs (Local Resource
  Management System) that can be automatically installed and configured by EC3.

![LRMS selection.](ecas-lrms.png)

- **Endpoint**: the endpoints of the providers where to deploy the ECAS elastic
  cluster. The endpoints serving the `vo.access.egi.eu` VO are dynamically
  retrieved from the [EGI Application DataBase](https://appdb.egi.eu/) using
  REST APIs.

![Endpoint selection.](ecas-endpoint.png)

- **Operating System**: choose EGI CentOS7 as cluster OS.

![Operating System selection.](ecas-os.png)

- **Instance details**, in terms of CPU and RAM to allocate for the front-end
  and the working nodes.

![Instance details.](ecas-instance.png)

- **Cluster's size and name**: the name of the cluster and the maximum number of
  nodes of the cluster, without including the front-end. This value indicates
  the maximum number of working nodes that the cluster can scale to. Initially,
  the cluster is created with the front-end and only one working node: the other
  working nodes will be powered on on-demand.

![Cluster size and name.](ecas-size.png)

- **Resume and Launch**: a summary of the chosen cluster configuration. To start
  the deployment process, click the Submit button.

![Resume and Launch.](ecas-summary.png)

When the front-end node of the cluster has been successfully deployed, you will
be notified with the credentials to access via SSH.

![ECAS cluster connection details.](ecas-end.png)

The cluster details are available by clicking on the \"Manage your deployed
clusters\" link on the front page:

![Manage your clusters.](ecas-manage.png)

{{% alert title="Note" color="primary" %}} The configuration of the cluster may
take some time. Please wait for its completion before starting to start using
the cluster. {{% /alert %}}

### Accessing the cluster

To access the front-end of the cluster:

- download the SSH private key provided by the EC3 portal;
- change its permissions to `600`;
- access via SSH providing the key as identity file for public key
  authentication.

```shell
[fabrizio@MBP EC3]$ ssh -i key.pem cloudadm@134.158.151.218
Last login: Mon Nov 18 11:37:29 2019 from torito.i3m.upv.es
[cloudadm@oph-server ~]$ sudo su -
[root@oph-server ~]#
```

Both the front-end and the working node are configured by Ansible. This process
usually takes some time. You can monitor the status of the cluster configuration
using the `is_cluster_ready` command-line tool:

```shell
[root@oph-server ~]# is_cluster_ready
Cluster is still configuring.
```

The cluster is successfully configured when the command returns the following
message:

```shell
[root@oph-server ~]# is_cluster_ready
Cluster configured!
```

As SLURM is used as workload manager, it is possible to check the status of the
working nodes by using the sinfo command, which provides information about Slurm
nodes and partitions.

```shell
[root@oph-server ~]# sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite   1  down* oph-io2
debug*       up   infinite   1   idle oph-io1
```

### Accessing the scientific eco-system

ECAS provides two different ways to get access to its scientific eco-system:
Ophidia client (`oph_term`) and JupyterHub.

#### Perform some basic operations with Ophidia

Run the Ophidia terminal as `ophuser` user.

![Ophidia terminal.](ecas-oph_term.png)

The default parameters are already defined as environmental variables inside the
`.bashrc` file:

```shell
export OPH_SERVER_HOST="127.0.0.1"
export OPH_SERVER_PORT="11732"
export OPH_PASSWD="abcd"
export OPH_USER="oph-test"
```

Create an empty container and a new datacube with random data and dimensions.

![Create container (1).](ecas-container-1.png)

![Create container (2).](ecas-container-2.png)

Now, you can submit your first operation of data transformation: let's reduce
the whole datacube in a single value for grid point using the average along the
time:

![Reduce datacube.](ecas-reduce.png)

Let's have a look at the environment by listing the datacubes and containers in
the session:

![List objects in session.](ecas-list.png)

By default, the Ophidia terminal will use the last output datacube PID. So, you
can use the `oph_explorecube` operator to visualize the first 100 values.

![Explorecube operator.](ecas-explore.png)

For further details about the Ophidia operators, please refer to the official
[documentation](http://ophidia.cmcc.it/).

#### Accessing the Jupyter interface

To access the Jupyter interface, open the browser at
`https://<YOUR_CLUSTER_IP>:443/jupyter` and log in to the system using the
username and password specified in the `jupyterhub_config.pyp` configuration
file (see the `c.Authenticator.whitelist` and `c.DummyAuthenticator.password`
lines) located at the `/root` folder.

![JupyterHub login.](ecas-jupyterhub.png)

From JupyterHub in ECAS you can do several things such as:

- create and run a Jupyter Notebook exploiting PyOphidia and Python libraries
  for visualization and plotting (e.g. matplotlib, basemap, NumPy);
- browse the directories, download and update the files in the home folder;
- execute operators and workflows directly from the Ophidia Terminal.

To get started with the ECAS environment capabilities, open the
`ECAS_Basics.ipynb` notebook available under the `notebooks/` folder in the home
directory.

![Jupyter.](ecas-jupyter.png)

## References

- <https://ecaslab.cmcc.it/web/home.html>
- <https://ecaslab.dkrz.de/home.html>
- <http://ophidia.cmcc.it/>
- <https://github.com/ECAS-Lab>
- <https://github.com/OphidiaBigData/ansible-role-ophidia-cluster>
- <http://www.grycap.upv.es/ec3>
- <http://www.github.com/grycap/ec3>
