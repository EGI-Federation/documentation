---
title: Dynamic DNS
type: docs
weight: 60
aliases:
  - /users/cloud-compute/dynamic-dns
description: >
  Dynamic domain names for VMs in the EGI Cloud
---

<!-- cSpell:words noip -->

The Dynamic DNS service provides a unified, federation-wide Dynamic DNS support
for VMs in EGI infrastructure. Users can register their chosen meaningful and
memorable DNS hostnames in given domains (e.g. `my-server.vo.fedcloud.eu`) and
assign to public IPs of their servers.

By using Dynamic DNS, users can host services in EGI Cloud with their
meaningful service names, can freely move VMs from sites to sites without
modifying server/client configurations (federated approach), can request valid
server certificates in advance (critical for security) and many other
advantages.

A short demonstration video is available at
[fedcloud.eu YouTube channel](https://www.youtube.com/watch?v=dk4VYT2VFmU).

## Dynamic DNS GUI portal

The Dynamic DNS offers a [web GUI portal](https://nsupdate.fedcloud.eu) where
users can login using their Check-in credentials. For doing so, click on the
_Login_ link (top left) and then click on the _egi_ button.

Once logged in, you will be presented with the following page:

![Dynamic DNS front page](dynamic-dns-portal.png)

To register a new DNS host name:

1. Click on _Overview_ and then on _Add Host_.

1. Type in the hostname you'd like to register and select the domain to use.

   ![Add host](add-host.png)

1. The portal will then show you a secret than can be used for updating
   the host ip whenever needed. Note it down so you can use it later.

1. From the VM you'd like to assign the name to, run a command like follows:

   ```shell
   curl "https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update"
   ```

   where `<hostname>` is the full hostname generated before, e.g.
   `myserver.fedcloud-tf.fedcloud.eu` and `<secret>` is the secret generated
   in the previous step. You can add that as a boot command in your `cloud-init`
   configuration:

   ```yaml
   #cloud-config

   runcmd:
     - [ curl, "https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update" ]
   ```

1. You can also manually edit your registered hostnames in the _Overview_ menu
   by clicking on the hostname you'd like to manage

{{% alert title="Note" color="info" %}}

- Hostnames/IP addresses are not expired so no need to refresh IP addresses if
  no changes, it is enough to run once. You can add the following command
  `curl https://HOSTNAME:SECRET@nsupdate.fedcloud.eu/nic/update` to cloud-init
  as described above to assign hostname automatically at VM start.

- DNS server set Time-to-Live (max time for caching DNS records) to 1 min for
  dynamic DNS, but MS Windows seems to not respect that. You can clear DNS cache
  in Windows with `ipconfig /flushdns` command with Administrator account.

{{% /alert %}}

## Dynamic DNS support in Infrastructure Manager

[Infrastructure Manager (IM)](../../orchestration/im/) automatically
creates hostname and assign the correct public IP of the head node of your
infrastructure in the Dynamic DNS. Just fill in the `DNS name to be used for
the VM` or `DNS name to set to the Kubernetes Front-end` (other infrastructures
may have similar names for this field) with a FQDN within the supported domains
of the Dynamic DNS:

![IM Dynamic DNS support](im-dyndns.png)

IM will take care of registering the hostname, assigning the IP and eventually
removing the hostname once the infrastructure is destroyed.

## API

### List domains

List available domains for your user

```plain
GET /nic/domains
Authorization: Bearer {{access_token}}
```

where `access_token` is a valid Check-in access token

Sample response:

```json
{
  "status": "ok",
  "private": [],
  "public": [
    {
      "name": "cloud.ai4eosc.eu",
      "public": true,
      "available": true,
      "comment": "Domain for stable services in AI4EOSC project",
      "owner": "viet02"
    },
    {
      "name": "cloud.eosc-siesta.eu",
      "public": true,
      "available": true,
      "comment": "Domain for production services in EOSC-SIESTA project",
      "owner": "root"
    },
}
```

### Register host

You can register a new hostname with a call to `/nic/register` either by
specifying `name` and `domain` (both mandatory):

```plain
GET /nic/register?name={{host_name}}&domain={{domain}}&comment={{comment}}&wildcard={{true|false|1|0|yes|no}}
Authorization: Bearer {{access_token}}
```

where:

- `host_name` is the name of the host to register
- `domain` is the domain where to register the host
- `comment` is a comment to add to the host
- `wildcard` is whether to ?
- `access_token` is a valid Check-in access token

of by specifying the `fqdn` (also mandatory):

```plain
GET /nic/register?fqdn={{fqdn_of_host}}&comment={{comment}}&wildcard={{true|false|1|0|yes|no}}
Authorization: Bearer {{access_token}}
```

where:

- `fqdn_of_host` is fqdn of the host to register
- `comment` is a comment to add to the host
- `wildcard` is whether to ?
- `access_token` is a valid Check-in access token

Response will be a json as follows:

```json
{
  "status": "ok",
  "message": "Host registered.",
  "host": {
    "fqdn": "test.vm.fedcloud.eu",
    "name": "test",
    "domain": "vm.fedcloud.eu",
    "wildcard": false,
    "comment": "test",
    "available": true,
    "client_faults": 0,
    "server_faults": 0,
    "abuse_blocked": false,
    "abuse": false,
    "last_update_ipv4": "2025-10-13T11:24:51.165433+00:00",
    "tls_update_ipv4": false,
    "ipv4": "10.10.0.253",
    "last_update_ipv6": null,
    "tls_update_ipv6": false,
    "ipv6": null,
    "update_secret": "some_secret",
    "IPv4_update_url_basic_auth": "https://test.vm.fedcloud.eu:some_secret@nsupdate.fedcloud.eu/nic/update",
    "IPv4_update_url_bearer_auth": "https://nsupdate.fedcloud.eu/nic/update?hostname=test.vm.fedcloud.eu&myip=${myip}"
  }
}
```

### Update DNS record

Dynamic DNS update server uses dyndns2 protocol, compatible with commercial
providers like [dyn.com](https://help.dyn.com/remote-access-api/perform-update/),
and [noip.com](https://www.noip.com/integrate/request). The API is specified as
follows:

```plain
GET /nic/update?hostname=yourhostname&myip=ipaddress
Host: nsupdate.fedcloud.eu
Authorization: Basic base64-encoded-auth-string
User-Agent:
```

where:

- `base64-encoded-auth-string`: base64 encoding of username:password
- `username`: your hostname
- `password`: your host secret
- `hostname` in the parameter string can be omitted or must be the same as
  `username`
- `myip` in the parameter string if omitted, the IP address of the client
  performing the GET request will be used

### Lists hosts

This API lists all the registered hosts by a given user:

```plain
GET /nic/hosts
Authorization: Bearer {{access_token}}
```

or

```plain
GET /nic/hosts?domain={{domain}}
Authorization: Bearer {{access_token}}
```
where:

- `domain` is the domain to list hosts for
- `access_token` is a valid Check-in access token

Sample response:

```json
{
  "status": "ok",
  "hosts": [
    {
      "fqdn": "myhost.cloud.ai4eosc.eu",
      "name": "myhost",
      "domain": "cloud.ai4eosc.eu",
      "wildcard": false,
      "comment": "comment",
      "available": true,
      "client_faults": 1,
      "server_faults": 0,
      "abuse_blocked": false,
      "abuse": false,
      "last_update_ipv4": "2025-04-10T10:33:06.930760+00:00",
      "tls_update_ipv4": false,
      "ipv4": "147.213.65.206",
      "last_update_ipv6": "2025-04-10T10:21:57.975176+00:00",
      "tls_update_ipv6": false,
      "ipv6": null
    }
  ]
}
```

## Security

- For updating IP address, only hostname and its secret are needed. No user
  information is stored on VM in any form for updating IP.

- NS-update server uses HTTPS protocol, hostname/secret are encrypted as data
  and not visible during transfer so it is secure to use the update URL

- NS-update portal does not store host secret in recoverable form. If you forget
  the secret of your hostname, simply generate new one via "Show configuration"
  button in the host edit page. The old secret will be invalid.

## Support

Support for Dynamic DNS service is provided via
[EGI Helpdesk](https://helpdesk.ggus.eu/) **"Dynamic DNS"** support unit, where
users can ask questions, report issues or make requests for additional domains
for specific projects or user communities.
