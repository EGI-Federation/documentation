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

1. Create a group where users belonging to the VO will be mapped to: :

   ```shell
   group_id=$(openstack group create -f value -c id <new_group>)
   ```

1. Add that group to the desired local project: :

   ```shell
   $ openstack role add member --group $group_id --project <your project>
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
                    "name": "{0}"
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

## Accounting

Add the project supporting the VO to cASO:

1. In the `projects` field of `/etc/caso/caso.conf` :

   ```ini
   projects = vo_project1, vo_project2, <your_new_vo_project>
   ```

1. and as a new mapping in `/etc/caso/voms.json` :

   ```json
   {
     "<your new vo>": {
       "projects": ["<your new vo project>"]
     }
   }
   ```

Be sure to include the user running cASO as member of the project if it does not
have admin privileges:

```shell
openstack role add member --user <your caso user> --project <your new vo project>
```

## Information system

Add the mapping to your site configuration with a new Pull Request to the
[fedcloud-catchall-operations repository](https://github.com/EGI-Federation/fedcloud-catchall-operations)

```yaml
---
vos:
  - name: <vo name>
    auth:
      project_id: <your new vo project>
```

## VM Image Management

### cloudkeeper-core

Add the new image list to the `cloudkeeper` configuration in
`/etc/cloudkeeper/cloudkeeper.yml` (or `/etc/cloudkeeper/image-lists.conf` if
using the appliance), new entry should look similar to:

`https://<APPDB_TOKEN>:x-oauth-basic@vmcaster.appdb.egi.eu/store/vo/<your new vo>/image.list`

### cloudkeeper-os

Add the user configured in cloudkeeper-os as member of the new project:

```shell
$ openstack role add member \
            --user <your cloudkeeper-os user> \
            --project <your new vo project>
```

Add the mapping of the project to the VO in `/etc/cloudkeeper-os/mapping.json`:

```json
{
  "<your new vo>": {
    "tenant": "<your new vo project>"
  }
}
```
