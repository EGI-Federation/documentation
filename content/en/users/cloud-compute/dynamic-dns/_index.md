---
title: "Dynamic DNS"
type: docs
weight: 80
description: >
  Dynamic DNS for VMs in EGI Cloud
---

The Dynamic DNS service provides a unified, federation-wide Dynamic DNS support
for VMs in EGI infrastrcuture. Users can register their chosen meaningful and
memorable DNS host names in given domains (e.g. `my-server.vo.fedcloud.eu`) and
assign to public IPs of their servers.

By using Dynamic DNS, users can host services in EGI Cloud with their
meaningful service names, can freely move VMs from sites to sites without
modifying server/client configurations (federated approach), can request valid
server certificates in advance (critical for security) and many other
advantages.

## Dynamic DNS GUI portal

The Dynamic DNS offers a [web GUI portal](https://nsupdate.fedcloud.eu) where
users can login using their Check-in credentials. For doing so, click on the
_Login_ link (top left) and then click on the _egi_ button.

Once logged in, you will be presented with the following page:

![Dynamic DNS front page](dynamic-dns-portal.png)

To register a new DNS host name:

1. click on _Overview_ and then on _Add Host_.

1. Type in the host name you'd like to register and select the domain to use.

   ![Add host](add-host.png)

1. The portal will then show you a secret than can be used for updating
   the host ip whenever needed. Note it down so you can use it later

1. From the VM you'd like to assign the name to, run a command like follows:

   ```shell
   curl https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update"
   ```

   where `<hostname>` is the full hostname generated before, e.g.
   `myserver.fedcloud-tf.fedcloud.eu` and `<secret>` is the secret generated
   in the previous step.

1. You can also manually edit your registered hostnames in the _Overview_ menu
   by clicking on the hostname you'd like to manage

{{% alert title="Note" color="info" %}}
- Hostnames/IP addresses are not expired so no need to refresh IP addresses if
  no changes, it is enough to run once. You can add the following command
  `curl https://HOSTNAME:SECRET@nsupdate.fedcloud.eu/nic/update` to cloud-init
  to assign hostname automatically at VM start

- DNS server set Time-to-Live (max time for caching DNS records) to 1 min for
  dynamic DNS, but MS Windows seems to not respect that. You can clear DNS cache
  in Windows with `ipconfig /flushdns` command with Administrator account
{{% /alert %}}


## API

Dynamic DNS update server uses dydns2 protocol, compatible with commercial
providers like [dyn.com](https://help.dyn.com/remote-access-api/perform-update/),
and [noip.com](http://www.noip.com/integrate/request). The API is specified as
follows:

```plain
GET /nic/update?hostname=yourhostname&myip=ipaddress
Host: nsupdate.fedcloud.eu
Authorization: Basic base64-encoded-auth-string
User-Agent:
```

where:

- `base64-encoded-auth-string`: base64 encoding of username:password
- `username`: your host name
- `password`: your host secret
- `hostname` in the parameter string can be omitted or must be the same as
  `username`
- `myip` in the parameter string if omitted, the IP address of the client
  performing the GET request will be used

## Security

- For updating IP address, only hostname and its secret are needed. No user
  information is stored on VM in any form for updating IP.

- NS-update server uses HTTPS protocol, hostname/secret are encrypted as data
  and not visible during transfer so it is secure to use the update URL


- NS-update portal does not store host secret in recoverable form. If you forget
  the secret of your hostname, simply generate new one via "Show configuration"
  button in the host edit page. The old secret will be invalid.
