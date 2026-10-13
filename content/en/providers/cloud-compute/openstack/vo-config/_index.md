---
title: "VO Configuration guide"
weight: 50
type: "docs"
description: >
  Summary of steps for configuring new VOs in OpenStack
---

In this page you can find a summary of the needed steps for supporting a new VO
in your OpenStack infrastructure.

## Local project creation

The usual method of supporting a VO is by creating a local project for it. You
should assign quotas to this project as agreed in the OLA defining the support
for the given VO.

1. Create a group where users belonging to the VO will be mapped to:

   ```shell
   group_id=$(openstack group create -f value -c id <new_group>)
   ```

1. Add that group to the desired local project:

   ```shell
   $ openstack role add member --group $group_id --project <your project>
   ```

1. Set the `egi.VO` property to the name of the VO that you are supporting:

   ```shell
   $ openstack project set --property egi.VO=<name of the VO> <your project>
   ```

## Keystone Mapping

Expand your `mapping.json` with the VO membership to the created group
(substitute `group_id` and `entitlement` as appropriate). The expected mappings
for the VOs are listed in
[`vo-mappings.yaml` of fedcloud-catchall-operations repository](https://github.com/EGI-Federation/fedcloud-catchall-operations/blob/main/vo-mappings.yaml):

```json
[
    <existing mappings>,
    {
        "local": [
            {
                "user": {
                    "name": "{0}",
                    "email": "{1}"
                },
                "group": {
                    "id": "<group_id>"
                }
            }
        ],
        "remote": [
            {
                "type": "HTTP_OIDC_SUB"
            },
            {
                "type": "HTTP_OIDC_EMAIL"
            },
            {
                "type": "HTTP_OIDC_ISS",
                "any_one_of": [
                    "https://aai.egi.eu/auth/realms/egi"
                ]
            },
            {
                "type": "OIDC-eduperson_entitlement",
                "regex": true,
                "any_one_of": [
                    "^<entitlement>$"
                ]
            }
        ]
    }
]
```

And update the mapping in your Keystone IdP:

```shell
$ openstack mapping set --rules mapping.json egi-mapping
```

You can include as many mappings as needed in the json file. Users will be
members of all the matching groups.

## Catch-all components

Update your `site.yaml` at the
<!-- cspell:disable-next-line -->
[EGI-Federation/fedcloud-catchall-operations repository](https://github.com/EGI-Federation/fedcloud-catchall-operations/)
to include the new VO by creating a PR. Once merged the new VO will be visible
for all components.


