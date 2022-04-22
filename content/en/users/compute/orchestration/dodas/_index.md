---
title: Dynamic On-Demand Analysis Software
linkTitle: Dynamic On-Demand Analysis Software
type: docs
weight: 40
description: >
  Instantiate on-demand customizable infrastructures for data analysis
---

## What is it?

[Dynamic On-Demand Analysis Software (DODAS)](https://dodas-iam.cloud.cnaf.infn.it/login) 
enables the execution of user analysis code both in batch mode and
interactively via the Jupyter interface. DODAS is highly customizable and offers
several building blocks that can be combined together in order to create the
best service composition for a given use case. The currently available blocks
allow to combine Jupyter and HTCondor as well as Jupyter and Spark or simply a
jupyter interface. In addition, they allow the management of data via caches to
optimize the processing of remote data. This can be done either via XCache or
MinIO S3 object storage capabilities. DODAS is based on docker containers and
the related orchestration relies on Kubernetes that enables the possibility to
compose the building blocks via a web-based user interface thanks to Kubeapps.

In order to deploy it services over various backend, DODAS relies on
[Infrastructure Manager](../im) and [INDIGO PaaS](../indigo-paas)

{{% alert title="Tip" color="info" %}} If you want to give it a try and deploy
your cluster in the EGI Federation:
[DODAS](https://dodas-iam.cloud.cnaf.infn.it/login). {{% /alert %}}

{{% alert title="Note" color="info" %}} For detailed information about DODAS
please see its [documentation](https://web.infn.it/dodas/index.php/en/). It was
also presented in one of the [EGI Webinars](https://www.egi.eu/webinars/), more
details are available on the [indico page](https://indico.egi.eu/event/5695/)
and the video recording is available on
[YouTube](https://www.youtube.com/watch?v=bcURl4ESRW8&ab_channel=EGI).
{{% /alert %}}
