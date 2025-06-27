---
title: "Catch-all components"
weight: 30
type: "docs"
description: >
    Configuration of the catch-all components
---

EGI manages the operations of two components for the sites so you don't need
to do it:
  - the information discovery provides a view about the actual images and
    flavors available at the OpenStack for the federation users.
    It runs as a single python application
    [cloud-info-provider](https://github.com/EGI-Federation/cloud-info-provider)
    that pushes information through the
    [Messaging Service](../../../../internal/messaging/).

    {{% alert title="BDII is deprecated" color="info" %}} Cloud providers no longer
    need to provide BDII as the Argo Messaging Service is used instead for
    transferring information {{% /alert %}}

  - the `image-sync` makes sure that images available in [EGI's Artefact Registry](https://registry.egi.eu)
    are avalable for your users in glance.

The deployment and configuration of these components is managed a the
<!-- cspell:disable-next-line -->
[EGI-Federation/fedcloud-catchall-operations repository](https://github.com/EGI-Federation/fedcloud-catchall-operations/).
Every provider should have a single `yaml` file that describes its configuration
as follows:

```yaml
endpoint: <your endpoint as declared in GOCDB>
gocdb: <your site name as declared in GOCDB>
images:
  sync: true
  # optionally list the formats that your site supports/prefers (as supported by qemu)
  # if not specificed, the sync will assume all formats are supported
  formats:
    - qcow2
    - raw
vos:
  # a list of VOs you support in your deployment as follows
  - auth:
      project_id: <local OpenStack project identifier>
    name: <name of the vo>
  - auth:
      project_id: <local OpenStack project identifier for second VO>
    name: <name of another vo>
```

You can create
[pull requests](https://github.com/EGI-Federation/fedcloud-catchall-operations/pulls)
for adding and maintaining your site configuration to the catch-all operations. As
soon as the pull request is merged, a new deployment will be triggered and your site
should start publishing information and syncing images.

The catch-all operations uses a service account user, this user is member of the `ops` VO
and should be enabled to manage VM images in glance.

## Opting out of catch-all operations

You can completely opt-out from the catch-all operations by removing your site
configuration from the repository. However, this will make your site not discoverable
by fedcloudclient or Infrastructure Manager.

You can also disable the image sync by setting `images.sync` to `false` or by completely
removing the `images` configuration. In that case, monitoring probes may fall as they rely
on the images being present at the site.

Individual components are available in GitHub if you want to operate them by your own:
- [`cloud-info-provider`](https://github.com/EGI-Federation/cloud-info-provider)
- [`atrope`](https://github.com/EGI-Federation/atrope)
