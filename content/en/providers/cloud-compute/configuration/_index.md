---
title: "VO Configuration"
weight: 50
type: "docs"
description: >
  Configuring VOs in your provider
---

This section provides the needed steps for supporting a new VO in your
infrastructure

## Local project creation

The usual method of supporting a VO is by creating a local project for it. You
should assign quotas to this project as agreed in the OLA defining the support
for the given VO.

1. Create a group where users belongig to the VO will be mapped to: :

   ```shell
   group_id=$(openstack group create -f value -c id <new_group>)
   ```

1. Add that group to the desired local project: :

   ```shell
   $ openstack role add member --group $group_id --project <your project>
   ```

## Keystone Mapping

Expand your `mapping.json` with the VO membership to the created group
(substitute `group_id` and `entitlement` as appropriate, see
[table of entitlements for VOs below](#entitlement-mappings)):

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
                    "https://aai.egi.eu/oidc/"
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
$ openstack mapping set --rules mapping$.json egi-mapping
```

### Entitlement mappings

| VO                             | Entitlement                                                                             |
| ------------------------------ | --------------------------------------------------------------------------------------- |
| `acc-comp.egi.eu`              | `urn:mace:egi.eu:group:acc-comp.egi.eu:vm_operator:role=member#aai.egi.eu`              |
| `belle`                        | `urn:mace:egi.eu:group:belle:vm_operator:role=member#aai.egi.eu`                        |
| `benchmark.terradue.com`       | `urn:mace:egi.eu:group:benchmark.terradue.com:vm_operator:role=member#aai.egi.eu`       |
| `biinsight.eosc-hub.eu`        | `urn:mace:egi.eu:group:biinsight.eosc-hub.eu:vm_operator:role=member#aai.egi.eu`        |
| `bioisi`                       | `urn:mace:egi.eu:group:bioisi:vm_operator:role=member#aai.egi.eu`                       |
| `biomed`                       | `urn:mace:egi.eu:group:biomed:vm_operator:role=member#aai.egi.eu`                       |
| `blazarmonitoring.asi.it`      | `urn:mace:egi.eu:group:blazarmonitoring.asi.it:vm_operator:role=member#aai.egi.eu`      |
| `chipster.csc.fi`              | `urn:mace:egi.eu:group:chipster.csc.fi:vm_operator:role=member#aai.egi.eu`              |
| `cloud.egi.eu`                 | `urn:mace:egi.eu:group:cloud.egi.eu:vm_operator:role=member#aai.egi.eu`                 |
| `cms`                          | `urn:mace:egi.eu:group:cms:vm_operator:role=member#aai.egi.eu`                          |
| `covid19.eosc-synergy.eu`      | `urn:mace:egi.eu:group:covid19.eosc-synergy.eu:vm_operator:role=member#aai.egi.eu`      |
| `cryoem.instruct-eric.eu`      | `urn:mace:egi.eu:group:cryoem.instruct-eric.eu:vm_operator:role=member#aai.egi.eu`      |
| `d4science.org`                | `urn:mace:egi.eu:group:d4science.org:vm_operator:role=member#aai.egi.eu`                |
| `datafurn.eosc-hub.eu`         | `urn:mace:egi.eu:group:datafurn.eosc-hub.eu:vm_operator:role=member#aai.egi.eu`         |
| `demo.fedcloud.egi.eu`         | `urn:mace:egi.eu:group:demo.fedcloud.egi.eu:vm_operator:role=member#aai.egi.eu`         |
| `drihm.eu`                     | `urn:mace:egi.eu:group:drihm.eu:vm_operator:role=member#aai.egi.eu`                     |
| `dteam`                        | `urn:mace:egi.eu:group:dteam:vm_operator:role=member#aai.egi.eu`                        |
| `ec-meloa.eu`                  | `urn:mace:egi.eu:group:ec-meloa.eu:vm_operator:role=member#aai.egi.eu`                  |
| `egi-services`                 | `urn:mace:egi.eu:group:egi-services:vm_operator:role=member#aai.egi.eu`                 |
| `eiscat.se`                    | `urn:mace:egi.eu:group:eiscat.se:vm_operator:role=member#aai.egi.eu`                    |
| `enmr.eu`                      | `urn:mace:egi.eu:group:enmr.eu:vm_operator:role=member#aai.egi.eu`                      |
| `eosc-synergy.eu`              | `urn:mace:egi.eu:group:eosc-synergy.eu:vm_operator:role=member#aai.egi.eu`              |
| `fedcloud.egi.eu`              | `urn:mace:egi.eu:group:fedcloud.egi.eu:vm_operator:role=member#aai.egi.eu`              |
| `fusion`                       | `urn:mace:egi.eu:group:fusion:vm_operator:role=member#aai.egi.eu`                       |
| `gosafe.eng.it`                | `urn:mace:egi.eu:group:gosafe.eng.it:vm_operator:role=member#aai.egi.eu`                |
| `kampal.eosc-hub.eu`           | `urn:mace:egi.eu:group:kampal.eosc-hub.eu:vm_operator:role=member#aai.egi.eu`           |
| `lagoproject.net`              | `urn:mace:egi.eu:group:lagoproject.net:vm_operator:role=member#aai.egi.eu`              |
| `med.semmelweis-univ.hu`       | `urn:mace:egi.eu:group:med.semmelweis-univ.hu:vm_operator:role=member#aai.egi.eu`       |
| `mswss.ui.savba.sk`            | `urn:mace:egi.eu:group:mswss.ui.savba.sk:vm_operator:role=member#aai.egi.eu`            |
| `mteam.data.kit.edu`           | `urn:mace:egi.eu:group:mteam.data.kit.edu:vm_operator:role=member#aai.egi.eu`           |
| `o3as.data.kit.edu`            | `urn:mace:egi.eu:group:o3as.data.kit.edu:vm_operator:role=member#aai.egi.eu`            |
| `opencoast.eosc-hub.eu`        | `urn:mace:egi.eu:group:opencoast.eosc-hub.eu:vm_operator:role=member#aai.egi.eu`        |
| `ops`                          | `urn:mace:egi.eu:group:ops:vm_operator:role=member#aai.egi.eu`                          |
| `peachnote.com`                | `urn:mace:egi.eu:group:peachnote.com:vm_operator:role=member#aai.egi.eu`                |
| `saps-vo.i3m.upv.es`           | `urn:mace:egi.eu:group:saps-vo.i3m.upv.es:vm_operator:role=member#aai.egi.eu`           |
| `seadatanet-pilot.eosc-hub.eu` | `urn:mace:egi.eu:group:seadatanet-pilot.eosc-hub.eu:vm_operator:role=member#aai.egi.eu` |
| `training.egi.eu`              | `urn:mace:egi.eu:group:training.egi.eu:vm_operator:role=member#aai.egi.eu`              |
| `umsa.cerit-sc.cz`             | `urn:mace:egi.eu:group:umsa.cerit-sc.cz:vm_operator:role=member#aai.egi.eu`             |
| `vo.access.egi.eu`             | `urn:mace:egi.eu:group:vo.access.egi.eu:vm_operator:role=member#aai.egi.eu`             |
| `vo.agiliacenter.com`          | `urn:mace:egi.eu:group:vo.agiliacenter.com:vm_operator:role=member#aai.egi.eu`          |
| `vo.clarin.eu`                 | `urn:mace:egi.eu:group:vo.clarin.eu:vm_operator:role=member#aai.egi.eu`                 |
| `vo.deltares.nl`               | `urn:mace:egi.eu:group:vo.deltares.nl:vm_operator:role=member#aai.egi.eu`               |
| `vo.elixir-europe.org`         | `urn:mace:egi.eu:group:vo.elixir-europe.org:vm_operator:role=member#aai.egi.eu`         |
| `vo.emphasisproject.eu`        | `urn:mace:egi.eu:group:vo.emphasisproject.eu:vm_operator:role=member#aai.egi.eu`        |
| `vo.emso-eric.eu`              | `urn:mace:egi.eu:group:vo.emso-eric.eu:vm_operator:role=member#aai.egi.eu`              |
| `vo.enes.org`                  | `urn:mace:egi.eu:group:vo.enes.org:vm_operator:role=member#aai.egi.eu`                  |
| `vo.envri-fair.eu`             | `urn:mace:egi.eu:group:vo.envri-fair.eu:vm_operator:role=member#aai.egi.eu`             |
| `vo.eurogeoss.eu`              | `urn:mace:egi.eu:group:vo.eurogeoss.eu:vm_operator:role=member#aai.egi.eu`              |
| `vo.europlanet-vespa.eu`       | `urn:mace:egi.eu:group:vo.europlanet-vespa.eu:vm_operator:role=member#aai.egi.eu`       |
| `vo.geoss.eu`                  | `urn:mace:egi.eu:group:vo.geoss.eu:vm_operator:role=member#aai.egi.eu`                  |
| `vo.indigo-datacloud.eu`       | `urn:mace:egi.eu:group:vo.indigo-datacloud.eu:vm_operator:role=member#aai.egi.eu`       |
| `vo.lifewatch.eu`              | `urn:mace:egi.eu:group:vo.lifewatch.eu:vm_operator:role=member#aai.egi.eu`              |
| `vo.max-centre.eu`             | `urn:mace:egi.eu:group:vo.max-centre.eu:vm_operator:role=member#aai.egi.eu`             |
| `vo.nbis.se`                   | `urn:mace:egi.eu:group:vo.nbis.se:vm_operator:role=member#aai.egi.eu`                   |
| `vo.nextgeoss.eu`              | `urn:mace:egi.eu:group:vo.nextgeoss.eu:vm_operator:role=member#aai.egi.eu`              |
| `vo.notebooks.egi.eu`          | `urn:mace:egi.eu:group:vo.notebooks.egi.eu:role=admin#aai.egi.eu`                        |
| `vo.obsea.es`                  | `urn:mace:egi.eu:group:vo.obsea.es:vm_operator:role=member#aai.egi.eu`                  |
| `vo.openbiomap.lifewatch.eu`   | `urn:mace:egi.eu:group:vo.openbiomap.lifewatch.eu:vm_operator:role=member#aai.egi.eu`   |
| `vo.operas-eu.org`             | `urn:mace:egi.eu:group:vo.operas-eu.org:vm_operator:role=member#aai.egi.eu`             |
| `vo.panosc.eu`                 | `urn:mace:egi.eu:group:vo.panosc.eu:role=vm_operator#aai.egi.eu`                        |
| `vo.plocan.eu`                 | `urn:mace:egi.eu:group:vo.plocan.eu:vm_operator:role=member#aai.egi.eu`                 |
| `vo.policycloud.eu`            | `urn:mace:egi.eu:group:vo.policycloud.eu:vm_operator:role=member#aai.egi.eu`            |
| `vo.stars4all.eu`              | `urn:mace:egi.eu:group:vo.stars4all.eu:vm_operator:role=member#aai.egi.eu`              |
| `worsica.vo.incd.pt`           | `urn:mace:egi.eu:group:worsica.vo.incd.pt:vm_operator:role=member#aai.egi.eu`           |

## Accounting

Add the project supporting the VO to cASO:

1. `projects` in `/etc/caso/caso.conf` :

   ```ini
   projects = vo_project1, vo_project2, <your_new_vo_project>
   ```

1. as a new mapping in `/etc/caso/voms.json` :

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

## Cloud-info-provider

Add the mapping to your site configuration with a new Pull Request to the
[fedcloud-catchall-operations repo](https://github.com/EGI-Federation/fedcloud-catchall-operations)

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
openstack role add member \
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
