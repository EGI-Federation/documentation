---
title: "Information System"
weight: 30
type: "docs"
description: >
  cloud info provider configuration
---

Information discovery provides a real-time view about the actual images and
flavors available at the OpenStack for the federation users. It runs as a single
python application
[cloud-info-provider](https://github.com/EGI-Federation/cloud-info-provider)
that pushes information through the
[Messaging Service](../../../../internal/messaging).

{{% alert title="BDII is deprecated" color="info" %}} Cloud providers no longer
need to provide BDII as the Argo Messaging Service is used instead for
transferring information {{% /alert %}}

You can either run the service by yourself or rely on central operations of the
cloud-info-provider. In both cases you must register your host DN in the GOCDB
entry for the `org.openstack.nova`.

## Catch-all operations

EGI can manage the operation of the `cloud-info-provider` for the site so you
don't need to do it. In order for your site to be included in the centrally
operated `cloud-info-provider`, you need to create a Pull Request at the
[EGI-Federation/fedcloud-catchall-operations repository](https://github.com/EGI-Federation/fedcloud-catchall-operations/)
adding your site configuration in the `sites` directory with a file like this:

```yaml
endpoint: <your endpoint as declared in GOCDB>
gocdb: <your site name as declared in GOCDB>
vos:
  # a list of VOs you support in your deployment as follows
  - auth:
      project_id: <local OpenStack project identifier>
    name: <name of the vo>
  - auth:
      project_id: <local OpenStack project identifier for second VO>
    name: <name of another vo>
```

Once PR is merged, the service will be reconfigured and your site should start
publishing information.

## Local operations

You can operate by yourself the `cloud-info-provider`. The software can be
obtained as RPMs, debs and python packages from the
[GitHub releases page](https://github.com/EGI-Federation/cloud-info-provider/releases).

The `cloud-info-provider` needs a configuration file where your site is
described, see the
[sample OpenStack configuration](https://github.com/EGI-Federation/cloud-info-provider/blob/master/etc/sample.openstack.yaml)
for the required information. The authentication parameters for your local
OpenStack and the AMS are passed as command-line options:

```shell
cloud-info-provider-service --yaml-file <your site description.yaml> \
                            --middleware openstack \
                            --os-auth-url <your keystone URL> \
                            [ any other options for authentication ]
                            --format glue21 \
                            --publisher ams \
                            --ams-cert <your host certificate> \
                            --ams-key <your host secret key> \
                            --ams-topic <your endpoint topic>
```

For authentication, you should be able to use any authentication method
supported by [keystoneauth](https://opendev.org/openstack/keystoneauth), for
username and password use: `--os-password` and `--os-username`. Check the
complete list of options with `cloud-info-provider-service --help`.

The AMS topic has the format: `SITE_<SITE_NAME>_ENDPOINT_<GOCDB_ID>`, where
`<SITE_NAME>` is the name of the site as declared in GOCDB and `<GOCDB_ID>` is
the ID of the endpoint in GOCDB. For example,
[this endpoint](https://goc.egi.eu/portal/index.php?Page_Type=Service&id=7513)
would have a topic like: `SITE_IFCA-LCG2_ENDPOINT_7513G0`.

You should periodically run the cloud-info-provider (e.g. with a cron every 5
minutes) to push the information for consumption by clients.

### Using the EGI FedCloud Appliance

The appliance provides a ready-to-use cloud-info-provider configuration if you
want to operate it by yourself. Once you have downloaded the appliance check the
following files:

- `/etc/cloud-info-provider/openstack.rc`: the configuration of the account used
  to log into your OpenStack and the location of the host certificate that will
  be used to authenticate to the AMS.

- `/etc/cloud-info-provider/openstack.yaml`: the cloud-info-provider
  configuration. You need to enter the details about the VOs/projects that the
  site is supporting.

The appliance has a cron job that will connect to the configured OpenStack API
and send messages every 5 minutes.
