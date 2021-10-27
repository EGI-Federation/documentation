---
title: "VM Image synchronisation"
weight: 40
type: "docs"
description: >
  cloudkeeper and AppDB integration
---

VM Images are replicated using `cloudkeeper`, which has two
components:

- fronted (cloudkeeper-core) dealing the with image lists and downloading the
  needed images, run periodically with cron
- backend (cloudkeeper-os) dealing with your glance catalogue, running
  permanently.

### Using the VM Appliance

Every 4 hours, the appliance will perform the following actions:

- download the configured lists in `/etc/cloudkeeper/image-lists.conf` and
  verify its signature
- check any changes in the lists and download new images
- synchronise this information to the configured glance endpoint

First you need to configure and start the backend. Edit
`/etc/cloudkeeper-os/cloudkeeper-os.conf` and add the authentication parameters
from line 117 to 136.

Then add as many image lists (one per line) as you would like to subscribe to
`/etc/cloudkeeper/image-lists.conf`. Use URLs with your AppDB token for
authentication, check the following guides for getting such token and URLs:

- [how to access to VO-wide image lists](https://wiki.appdb.egi.eu/main:faq:how_to_get_access_to_vo-wide_image_lists),
  and
- [how to subscribe to a private image list](https://wiki.appdb.egi.eu/main:faq:how_to_subscribe_to_a_private_image_list_using_the_vmcatcher).

Finally, you need to provide a `/etc/cloudkeeper-os/mapping.json` that
configures the mapping of VOs supported in your OpenStack. The file should
contain a json document that follows this format:

```json
{
        "<VO_NAME>": {
            "project": "<id of project in OpenStack for VO_NAME>"
        },
        "<VO_NAME_2>": {
            "project": "<local name of project in OpenStack for VO_NAME_2>",
            "domain": "<domain name for project in OpenStack>"
        }
}
```

Note that you can either specify a project id or the project name with the
domain name in the mapping. Add as many VOs as you are supporting.

#### Running the services

cloudkeeper-os should run permanently, there is a `cloudkeeper-os.service` for
systemd in the appliance. Manage as usual:

```shell
systemctl <start|stop|status> cloudkeeper-os
```

cloudkeeper core is run every 4 hours with a cron script.
