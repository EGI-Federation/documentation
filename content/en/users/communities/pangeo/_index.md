---
title: "Pangeo"
linkTitle: "Pangeo"
type: docs
weight: 20
description: >
  How to to use the EGI infrastructure with Pangeo
---

This is the documentation to support the Pangeo community.

## How to get access

Getting access to the EGI infrastructure consists of the following steps:

1. [Sign-up](../../aai/check-in/signup/) for an EGI Check-In account.
1. Request to join the `vo.pangeo.eu`
   [Virtual Organisation (VO)](https://confluence.egi.eu/display/EGIG/Virtual+organisation)
   by visiting the [enrollment URL](https://aai.egi.eu/registry/co_petitions/start/coef:386)
   with your EGI Check-In account. The subscription requires approval from the
   VO Managers. For further information, please check the
   [VO ID card](https://operations-portal.egi.eu/vo/view/voname/vo.pangeo.eu).
1. Use [Infrastructure Manager](../../compute/orchestration/im/) or directly
   access the cloud-based resources at CESNET-MCC:
   * [Horizon OpenStack dashboard](https://dashboard.cloud.muni.cz/)
   * Project name: `vo.pangeo.eu`
   * Project ID: `05e0ff6e03774082aadacc75bfc1d783`
   * Network ID: `group-project-network`
   * Security Group: ingress traffic to port 22 (SSH) is enabled

## How to deploy Pangeo

A few considerations before we start:

* You need to be a member of the `vo.pangeo.eu` VO. Please
see steps [above](#how-to-get-access).
* We will be using the DaskHub and Pangeo interchangeably along this document.
See the history [here](https://blog.dask.org/2020/08/31/helm_daskhub).

Here is an overview of the steps that we will follow:

1. Configure a DNS name for Pangeo using the
[Dynamic DNS](../../compute/cloud-compute/dynamic-dns/) service.
1. Deploy a Kubernetes cluster on top of OpenStack, and install
the [DaskHub helm chart](https://helm.dask.org/).
[Infrastructure Manager Dashboard](../../compute/orchestration/im/dashboard/)
(or simply IM Dashboard) will do this all for us automatically.
1. Configure JupyterHub with [EGI Check-In](../../aai/check-in/) to allow
access to all members of the `vo.pangeo.eu` Virtual Organization.

### Step 1) DNS name

Log into the [Dynamic DNS web GUI portal](https://nsupdate.fedcloud.eu/)
with your EGI Check-In account to configure a domain name of your choice.
The web portal is intuitive, and there is also the associated
[documentation](../../compute/cloud-compute/dynamic-dns/) so we will not
go into more details here.

For the rest of this tutorial, let us consider the `pangeo.vm.fedcloud.eu`
domain name.

### Step 2) Deploy Pangeo

Log into the [IM Dashboard](https://im.egi.eu/im-dashboard/)
with your EGI Check-In account, and configure your
[credentials](../../compute/orchestration/im/dashboard/#cloud-credentials)
with the `vo.pangeo.eu` VO. Then click on the
[kubernetes template](https://im.egi.eu/im-dashboard/configure?selected_tosca=kubernetes.yaml)
and add `Dask`. Out of all the configuration options, please pay special
attention to the following:

* `Kubernetes Data` tab:
    * `Flag to install Cert-Manager` must be set to `True`
    * `Email to be used in the Let's Encrypt issuer`: add your preferred email.
    * `DNS name of the public interface of the FE node to generate the certificate`
       must be set to the one configure in [Step 1](#step-1-dns-name).
* `Dask Data` tab:
    * `Password for the Simple auth method in the Gateway`: please configure a
       secure password.
    * `Jupyterhub auth token`: please configure an auth token (e.g.
      with `openssl rand -hex 32` on Linux)
    * Use `Jupyterhub singleuser image` and `Jupyterhub singleuser image version`
      to configure the default user environment in JupyterHub with a container
      image of your choice.
* `Cloud Provider Selection` tab:
    * Select the [credentials](../../compute/orchestration/im/dashboard/#cloud-credentials)
      configured earlier.

Please review all configuration options and click `Submit` and wait for the
deployment to finish with status `configured`. Then click on `Outputs` and
take a note of the IP address assigned. See the
[documentation](../../compute/orchestration/im/dashboard/#infrastructures)
for IM Dashboard to learn more.

#### HTTPS

Please go to the [Dynamic DNS web GUI portal](https://nsupdate.fedcloud.eu/)
and update the public IP for the DNS name with the one shown in the `Outputs`
button of the IM Dashboard. Now `Reconfigure` the deployment so `https` is
correctly configured with Let's Encrypt.

You also need to update the nginx ingress for `https` to work. Here is
a template yaml file that should help:

```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: daskhub
  name: jupyterhub
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    kubernetes.io/ingress.class: nginx
spec:
  tls:
  - hosts:
    - pangeo.vm.fedcloud.eu
    secretName: pangeo.vm.fedcloud.eu
  rules:
  - host: pangeo.vm.fedcloud.eu
    http:
      paths:
      - backend:
          service:
            name: proxy-public
            port:
              name: http
        path: /jupyterhub/
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: <internal-ip-master>
```

Get the internal IP address of the master node with:

```bash
sudo kubectl get nodes -o wide
```

And update the ingress with:

```bash
sudo kubectl apply -f ingress.yaml -n daskhub
```

If all went well, JupyterHub will be available at
[https://pangeo.vm.fedcloud.eu/jupyterhub/](https://pangeo.vm.fedcloud.eu/jupyterhub/)

### Configure EGI Check-In

