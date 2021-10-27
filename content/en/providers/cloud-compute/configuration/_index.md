---
title: "VO Configuration"
weight: 50
type: "docs"
description: >
  Configuring VOs in your provider
---

This section provides the needed steps for supporting a new VO in your
infrastructure

## EGI AAI

### OpenStack

The usual method of supporting a VO is by creating a local project for it. You
should assign quotas to this project as agreed in the OLA defining the support
for the given VO.

#### Check-in VOs (OpenID Connect)

Follow these steps if you are using OpenID Connect to integrate with EGI:

1. Create a group where users belongig to the VO will be mapped to: :

   ```shell
   group_id=$(openstack group create -f value -c id <new_group>)
   ```

1. Add that group to the desired local project: :

   ```shell
   openstack role add member --group $group_id --project <your project>
   ```

1. Expand your mapping.json with the VO membership to the created group
   (substitute `group_id` and `vo_name` as appropriate): :

   <!-- markdownlint-disable line-length -->
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
                       "^urn:mace:egi.eu:group:<vo_name>:role=vm_operator#aai.egi.eu$"
                   ]
               }
           ]
       }
   ]
   ```
   <!-- markdownlint-enable line-length -->

1. Update the mapping in your Keystone IdP: :

   ```shell
   openstack mapping set --rules mapping.json egi-mapping
   ```

#### Legacy VOs (VOMS)

When using the Keystone-VOMS module, you should follow these steps:

1. Configure your LSC files according to the
   [VOMS documentation](http://italiangrid.github.io/voms/documentation/voms-clients-guide/3.0.3/#voms-trust),
   e.g.: :

   ```shell
   mkdir -p /etc/grid-security/vomsdir/ops

   cat > /etc/grid-security/vomsdir/ops/lcg-voms2.cern.ch.lsc << EOF
   /DC=ch/DC=cern/OU=computers/CN=lcg-voms2.cern.ch
   /DC=ch/DC=cern/CN=CERN Grid Certification Authority
   EOF

   cat > /etc/grid-security/vomsdir/ops/voms2.cern.ch.lsc << EOF
   /DC=ch/DC=cern/OU=computers/CN=voms2.cern.ch
   /DC=ch/DC=cern/CN=CERN Grid Certification Authority
   EOF
   ```

1. Add the mapping to your `voms.json` mapping. It must be proper JSON (you can
   check its correctness [online](http://jsonlint.com/) or with
   `python -mjson.tool /etc/keystone/voms.json`). Edit the file, and add an
   entry like this:

   ```json
   {
       "<voname|FQAN>": {
           "tenant": "<project_name>"
       }
   }
   ```

   Note that you can use the FQAN from the incoming proxy, so you can map a
   group within a VO into a tenant, like this:

   ```json
   {
       "dteam": {
           "tenant": "dteam"
       },
       "/dteam/NGI_IBERGRID": {
           "tenant": "dteam_ibergrid"
       }
   }
   ```

1. Restart Apache server, and it\'s done.

## EGI Accounting

### OpenStack

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

## EGI Information System

### OpenStack

Add the user configured in your cloud-info-provider as member of the new
project:

```shell
openstack role add member \
          --user <your cloud-info-provider user> \
          --project <your new vo project>
```

## EGI VM Image Management

### cloudkeeper-core

Add the new image list to the `cloudkeeper` configuration in
`/etc/cloudkeeper/cloudkeeper.yml` (or `/etc/cloudkeeper/image-lists.conf` if
using the appliance), new entry should look similar to:

`https://<APPDB_TOKEN>:x-oauth-basic@vmcaster.appdb.egi.eu/store/vo/<your new vo>/image.list`

### OpenStack

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
