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

By using Dynamic DNS, users can host services in EGI Cloud with their meaningful
service names, can freely move VMs from sites to sites without modifying
server/client configurations (federated approach), can request valid server
certificates in advance (critical for security) and many other advantages.

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

1. The portal will then show you a secret than can be used for updating the host
   ip whenever needed. Note it down so you can use it later.

1. From the VM you'd like to assign the name to, run a command like follows:

   ```shell
   curl "https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update"
   ```

   where `<hostname>` is the full hostname generated before, e.g.
   `myserver.fedcloud-tf.fedcloud.eu` and `<secret>` is the secret generated in
   the previous step. You can add that as a boot command in your `cloud-init`
   configuration:

   ```yaml
   #cloud-config

   runcmd:
     - [curl, "https://<hostname>:<secret>@nsupdate.fedcloud.eu/nic/update"]
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

[Infrastructure Manager (IM)](../../orchestration/im/) automatically creates
hostname and assign the correct public IP of the head node of your
infrastructure in the Dynamic DNS. Just fill in the
`DNS name to be used for the VM` or
`DNS name to set to the Kubernetes Front-end` (other infrastructures may have
similar names for this field) with a FQDN within the supported domains of the
Dynamic DNS:

![IM Dynamic DNS support](im-dyndns.png)

IM will take care of registering the hostname, assigning the IP and eventually
removing the hostname once the infrastructure is destroyed.

## Wildcard hosts

For certain use cases, it is desirable for all hosts within a specific subdomain
to resolve to the same IP address. For example, if the head node of a Kubernetes
cluster is accessible at `kubernetes.fedcloud.eu`, all services within the
cluster can share the same IP and be represented using a wildcard entry
`*.kubernetes.fedcloud.eu`, where `*` stands for any of the services; e.g.
`dashboard.kubernetes.fedcloud.eu`, `api.kubernetes.fedcloud.eu`,
`app1.kubernetes.fedcloud.eu`. In such setup, request routing is handled
internally by the cluster, typically through an Ingress or Gateway resource.

![wildcard-example.png](wildcard-example.png)

This kind of names can be registered using the [API calls](#api) as described
below.

## API

The API is accessible via the `API_BASE_URL` endpoint (e.g.
`https://nsupdate.fedcloud.eu`) and exposes several endpoints for domain
management and related operations.

### Authorization

All API requests require a valid `ACCESS_TOKEN`. This token must be included in
the HTTP request `Authorization` header using the `Bearer` scheme for
authentication.

### List domains

Retrieves all private domains owned by the authenticated user, as well as all
available public domains.

#### Endpoint

```http
GET {{API_BASE_URL}}/nic/domains
Authorization: Bearer {{ACCESS_TOKEN}}
```

#### Response

Returns a JSON object containing two arrays:

- `private` — Domains owned by the requesting user.
- `public` — Public domains available for use.

#### Sample response

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
    }
  ]
}
```

#### Domain Fields Description

Each domain object (private or public) includes the following fields:

| Field       | Type    | Description                                                                                                                                                                                  |
| ----------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`      | string  | The fully qualified domain name (FQDN) of the domain. Example: `cloud.ai4eosc.eu`.                                                                                                           |
| `public`    | boolean | Indicates whether the domain is public (`true`) or private (`false`). Public domains are available for multiple users, whereas private domains are owned exclusively by the requesting user. |
| `available` | boolean | Indicates whether the domain is available for new host registrations. `true` means the domain can be used; `false` means it is in use, reserved, or restricted.                              |
| `comment`   | string  | A short description or annotation about the domain. Typically provides context or usage information.                                                                                         |
| `owner`     | string  | The username of the domain owner. For public domains, this is the account responsible for the domain.                                                                                        |

### Register Host

This endpoint registers a host in the specified domain, optionally setting a
wildcard and adding a comment. The response confirms whether the registration
was successful or if an error occurred.

#### Endpoint

##### Option 1

```http
GET {{API_BASE_URL}}/nic/register?fqdn={{HOSTNAME}}&ip={{IP}}&wildcard={{WILDCARD}}&comment={{COMMENT}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

##### Parameters

| Name       | Type    | Required | Description                                                                                                                 |
| ---------- | ------- | -------- | --------------------------------------------------------------------------------------------------------------------------- |
| `fqdn`     | string  | ✅ Yes   | Fully qualified domain name (FQDN) of the host to register.                                                                 |
| `ip`       | string  | No       | IP address to associate with the host. If omitted, the IP is inferred from the incoming request.                            |
| `wildcard` | boolean | No       | Enables or disables a wildcard entry for the host. <br>• `true` — enable wildcard<br>• `false` — disable wildcard (default) |
| `comment`  | string  | No       | Optional comment or description for the host.                                                                               |

##### Option 2

```http
GET {{API_BASE_URL}}/nic/register?name={{NAME}}&domain={{DOMAIN}}&ip={{IP}}&wildcard={{WILDCARD}}&comment={{COMMENT}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

##### Parameters

| Name       | Type    | Required | Description                                                                                                                 |
| ---------- | ------- | -------- | --------------------------------------------------------------------------------------------------------------------------- |
| `name`     | string  | ✅ Yes   | Name of the host to register.                                                                                               |
| `domain`   | string  | ✅ Yes   | Domain under which the host is registered.                                                                                  |
| `ip`       | string  | No       | IP address to associate with the host. If omitted, the IP is inferred from the incoming request.                            |
| `wildcard` | boolean | No       | Enables or disables a wildcard entry for the host. <br>• `true` — enable wildcard<br>• `false` — disable wildcard (default) |
| `comment`  | string  | No       | Optional comment or description for the host.                                                                               |

#### Sample Response

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

#### Response Fields

| Field     | Type   | Description                                                                                      |
| --------- | ------ | ------------------------------------------------------------------------------------------------ |
| `status`  | string | Indicates the overall status of the request (e.g., `"ok"` for success or `"error"` for failure). |
| `message` | string | Human-readable message summarizing the result.                                                   |
| `host`    | object | Contains detailed information about the registered host.                                         |

##### `host` Object

| Field                         | Type              | Description                                                         |
| ----------------------------- | ----------------- | ------------------------------------------------------------------- |
| `fqdn`                        | string            | Fully qualified domain name of the host.                            |
| `name`                        | string            | Name of the host.                                                   |
| `domain`                      | string            | Domain under which the host is registered.                          |
| `wildcard`                    | boolean           | Whether a wildcard entry is enabled for the host.                   |
| `comment`                     | string            | Optional comment associated with the host.                          |
| `available`                   | boolean           | Indicates if the host is active and reachable.                      |
| `client_faults`               | integer           | Number of client-related errors recorded.                           |
| `server_faults`               | integer           | Number of server-related errors recorded.                           |
| `abuse_blocked`               | boolean           | Whether the host has been blocked due to abuse reports.             |
| `abuse`                       | boolean           | Indicates if the host is currently flagged for abuse.               |
| `last_update_ipv4`            | string (ISO 8601) | Timestamp of the last IPv4 update.                                  |
| `tls_update_ipv4`             | boolean           | Indicates if a TLS update is pending for the IPv4 record.           |
| `ipv4`                        | string            | The assigned IPv4 address.                                          |
| `last_update_ipv6`            | string \| null    | Timestamp of the last IPv6 update, or `null` if none.               |
| `tls_update_ipv6`             | boolean           | Indicates if a TLS update is pending for the IPv6 record.           |
| `ipv6`                        | string \| null    | The assigned IPv6 address, or `null` if none.                       |
| `update_secret`               | string            | Secret token used for authenticated updates.                        |
| `IPv4_update_url_basic_auth`  | string            | URL for updating the IPv4 record using Basic Auth credentials.      |
| `IPv4_update_url_bearer_auth` | string            | URL for updating the IPv4 record using Bearer token authentication. |

### Update DNS record

The dynamic DNS update server uses the **dyndns2 protocol**, compatible with
commercial providers such as
[dyn.com](https://help.dyn.com/remote-access-api/perform-update/) and
[noip.com](https://www.noip.com/integrate/request), and allows clients to update
the IP address of a registered host. In addition to Basic authentication using
an [update secret](#generate-update-secret), this endpoint also supports
authentication with the `Bearer` scheme for enhanced security.

#### Endpoint

##### Update using Bearer token authentication

```http
GET {{API_BASE_URL}}/nic/update?hostname={{HOSTNAME}}&myip={{IP_ADDRESS}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

##### Update using Basic authentication with update secret

```http request
GET {{API_BASE_URL}}/nic/update?hostname={{HOSTNAME}}&myip={{IP_ADDRESS}}
Authorization: Basic {{BASE64_ENCODED_AUTH_STRING}}
```

###### Creating Basic authentication secret

To create the Basic authentication token, encode FQDN of the target host and
corresponding update secret using the Base64 encoding. To retrieve the update
secret, use the [/nic/generate_secret](#generate-update-secret) endpoint.

```bash
$ echo -n "${HOSTNAME}:${UPDATE_SECRET}" | base64 -
c3Rldm8tZ3B1Og==
```

#### Parameters

| Name       | Type   | Required | Description                                                                                          |
| ---------- | ------ | -------- | ---------------------------------------------------------------------------------------------------- |
| `hostname` | string | ✅ Yes   | Fully qualified domain name (FQDN) of the host to update.                                            |
| `myip`     | string | No       | IP address to set for the host. If omitted, the server uses the IP address of the requesting client. |

#### Sample response

```text
HTTP/2 200 OK
(Headers) ...content-type: text/plain...

good 123.45.67.89
```

- The response body returns the status of the update followed by the current IP
  address assigned to the host.
- Example: `good 123.45.67.89` indicates the update succeeded and the host now
  points to `123.45.67.89`.

### List Hosts

Retrieves all hosts registered by the authenticated user. Optionally, you can
filter hosts by a specific domain.

#### Endpoint

```http
GET {{API_BASE_URL}}/nic/hosts?domain={{DOMAIN}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

#### Parameters

| Name     | Type   | Required | Description                                                                                     |
| -------- | ------ | -------- | ----------------------------------------------------------------------------------------------- |
| `domain` | string | No       | Optional domain to filter the hosts. If omitted, all hosts registered by the user are returned. |

#### Sample response

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

#### Response Fields

| Field     | Type   | Description                                                                                      |
| --------- | ------ | ------------------------------------------------------------------------------------------------ |
| `status`  | string | Indicates the overall status of the request (e.g., `"ok"` for success or `"error"` for failure). |
| `message` | string | Present only in failed responses; provides a human-readable explanation of the error.            |
| `hosts`   | array  | Presents only in successful responses; provides a list of host objects registered by the user.   |

##### `hosts` Object

| Field              | Type              | Description                                                 |
| ------------------ | ----------------- | ----------------------------------------------------------- |
| `fqdn`             | string            | Fully qualified domain name of the host.                    |
| `name`             | string            | Name of the host.                                           |
| `domain`           | string            | Domain under which the host is registered.                  |
| `wildcard`         | boolean           | Indicates whether a wildcard entry is enabled for the host. |
| `comment`          | string            | Optional comment associated with the host.                  |
| `available`        | boolean           | Indicates if the host is active and reachable.              |
| `client_faults`    | integer           | Number of client-related errors recorded.                   |
| `server_faults`    | integer           | Number of server-related errors recorded.                   |
| `abuse_blocked`    | boolean           | Whether the host has been blocked due to abuse reports.     |
| `abuse`            | boolean           | Indicates if the host is currently flagged for abuse.       |
| `last_update_ipv4` | string (ISO 8601) | Timestamp of the last IPv4 update.                          |
| `tls_update_ipv4`  | boolean           | Indicates if a TLS update is pending for the IPv4 record.   |
| `ipv4`             | string            | The assigned IPv4 address.                                  |
| `last_update_ipv6` | string (ISO 8601) | Timestamp of the last IPv6 update, or `null` if none.       |
| `tls_update_ipv6`  | boolean           | Indicates if a TLS update is pending for the IPv6 record.   |
| `ipv6`             | string \| null    | The assigned IPv6 address, or `null` if none.               |

### Unregister Host

Removes a previously registered host from the specified domain. The response
confirms whether the unregistration was successful or if an error occurred.

#### Endpoint

##### Option 1

```http
GET {{API_BASE_URL}}/nic/unregister?fqdn={{HOSTNAME}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

##### Parameters

| Name   | Type   | Required | Description                                                   |
| ------ | ------ | -------- | ------------------------------------------------------------- |
| `fqdn` | string | ✅ Yes   | Fully qualified domain name (FQDN) of the host to unregister. |

##### Option 2

```http
GET {{API_BASE_URL}}/nic/unregister?name={{NAME}}&domain={{DOMAIN}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

##### Parameters

| Name     | Type   | Required | Description                                |
| -------- | ------ | -------- | ------------------------------------------ |
| `name`   | string | ✅ Yes   | Name of the host to unregister.            |
| `domain` | string | ✅ Yes   | Domain under which the host is registered. |

#### Sample response

```json
{
  "status": "ok",
  "message": "Host unregistered.",
  "host": {
    "fqdn": "test.vm.fedcloud.eu",
    "name": "test",
    "domain": "vm.fedcloud.eu",
    "wildcard": false,
    "comment": "host for testing purposes"
  }
}
```

#### Response Fields

| Field     | Type   | Description                                                                                      |
| --------- | ------ | ------------------------------------------------------------------------------------------------ |
| `status`  | string | Indicates the overall status of the request (e.g., `"ok"` for success or `"error"` for failure). |
| `message` | string | Human-readable message summarizing the result.                                                   |
| `host`    | object | Contains details of the unregistered host.                                                       |

##### `host` Object

| Field      | Type           | Description                                                  |
| ---------- | -------------- | ------------------------------------------------------------ |
| `fqdn`     | string         | Fully qualified domain name (FQDN) of the unregistered host. |
| `name`     | string         | Name of the unregistered host.                               |
| `domain`   | string         | Domain under which the host was registered.                  |
| `wildcard` | boolean        | Indicates whether a wildcard entry was enabled for the host. |
| `comment`  | string \| null | Comment associated with the host, or `null` if none.         |

### Generate update secret

Generates a new update secret for clients to update a registered host. The
secret can be used for authenticated dynamic updates to the host’s IP records.

#### Endpoint

```http
GET {{API_BASE_URL}}/nic/generate_secret?fqdn={{HOSTNAME}}
Authorization: Bearer {{ACCESS_TOKEN}}
```

#### Parameters

| Name   | Type   | Required | Description                                                                      |
| ------ | ------ | -------- | -------------------------------------------------------------------------------- |
| `fqdn` | string | ✅ Yes   | Fully qualified domain name (FQDN) of the host for which to generate the secret. |

#### Sample response

```json
{
  "status": "ok",
  "secret": "bMkzLXMr75"
}
```

#### Response Fields

| Field     | Type   | Description                                                                                               |
| --------- | ------ | --------------------------------------------------------------------------------------------------------- |
| `status`  | string | Indicates the overall status of the request (e.g., `"ok"` for success or `"error"` for failure).          |
| `message` | string | Present only in failed responses; provides a human-readable explanation of the error.                     |
| `secret`  | string | Presents only in successful responses; provides the newly generated update secret for the specified host. |

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
