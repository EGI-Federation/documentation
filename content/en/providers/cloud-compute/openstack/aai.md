---
title: "Check-in"
weight: 10
type: "docs"
description: >
  Authentication and Authorization integration
---

The integration of OpenStack service providers into the EGI Check-in is a
two-step process:

1. Test integration with the demo instance of EGI Check-in. This will allow you
   to check the complete functionality of the system without affecting the
   production Check-in service.
1. Once the integration is working correctly, register your provider with the
   production instance of EGI Check-in to allow members of the EGI User
   Community to access your service.

## Registration into Check-in demo instance

Before your service can use the EGI Check-in OIDC Provider for user login, you
need to register a client through the
[EGI Federation Registry](https://aai.egi.eu/federation) in order to obtain
OAuth2.0 credentials and register one or more redirect URIs.

Make sure that you fill in the following options:

- _General_ tab:

  > - Set _Integration Environment_ to _Demo_ and fill the form with the
  >   information about your Service.

- _Protocol Specific_ tab:

  > - Set _Select Protocol_ to _OIDC Service_
  > - Set redirect URL to
  >   `https://<your keystone endpoint>/v3/auth/OS-FEDERATION/websso/openid/redirect`.
  >   Recent versions of OpenStack may deploy Keystone at `/identity/`, be sure
  >   to include that in the `<your keystone endpoint>` part of the URL if
  >   needed.
  > - Enable _openid_, _profile_, _email_, _eduperson_entitlement_ in the
  >   **Scope** field
  > - Enable _authorization code_ in the **Grant Types** field
  > - Set _Proof Key for Code Exchange (PKCE) Code Challenge Method_ to _SHA-256
  >   hash algorithm (recommended)_
  > - Make sure _Allow calls to the Introspection Endpoint?_ is enabled in
  >   **Introspection** field

Submit the request for review by the Check-in operations team. Once the request
has been approved, you will get a client ID and client secret. Save them for the
following steps

## Keystone setup

### Pre-requisites

1. Keystone must run as a WSGI application behind an HTTP server (Apache is used
   in this documentation, but any server should be possible if it has OpenID
   connect/OAuth2.0 support). Keystone project has deprecated eventlet, so you
   should be already running Keystone in such way.
1. Keystone must be run with SSL
1. You need to install
   [mod_auth_openidc](https://github.com/pingidentity/mod_auth_openidc) for
   adding support for OpenID Connect to Apache.

{{% alert title="IGTF CAs" color="info" %}} EGI monitoring checks that your
Keystone accepts clients with certificates from the IGTF CAs. Please ensure that
your server is configured with the correct Certificate and Revocation path:

For Apache HTTPd

: HTTPd is able to use CAs and CRLs contained in a directory:

```ApacheConf
SSLCACertificatePath    /etc/grid-security/certificates
SSLCARevocationPath     /etc/grid-security/certificates
```

For haproxy

: CA and CRLS have to be bundled into one file.

Client verification should be set as optional otherwise accepted CAs won\'t be
presented to the EGI monitoring:

  <!-- markdownlint-disable line-length -->

```plaintext
# crt: concatenated cert, key and CA
# ca-file: all IGTF CAs, concatenated as one file
# crl-file: all IGTF CRLs, concatenated as one file
# verify: enable optional X.509 client authentication
bind XXX.XXX.XXX.XXX:443 ssl crt /etc/haproxy/certs/host-cert-with-key-and-ca.pem ca-file /etc/haproxy/certs/igtf-cas-bundle.pem crl-file /etc/haproxy/certs/igtf-crls-bundle.pem verify optional
```

  <!-- markdownlint-enable line-length -->

For nginx

: CA and CRLS have to be bundled into one file.

Client verification should be set as optional otherwise accepted CAs won\'t be
presented to the EGI monitoring:

```Nginx configuration file
ssl_client_certificate /etc/ssl/certs/igtf-cas-bundle.pem;
ssl_crl /etc/ssl/certs/igtf-crls-bundle.pem;
ssl_verify_client optional;
```

Managing IGTF CAs and CRLs

: IGTF CAs can be obtained from UMD, you can find repository files for your
distribution at
[EGI CA repository](https://repository.egi.eu/sw/production/cas/1/current/)

IGTF CAs and CRLs can be bundled using the examples command hereafter.

Please update CAs bundle after IGTF updates, and CRLs bundle after each CRLs
update made by fetch-crl:

```shell
cat /etc/grid-security/certificates/*.pem > /etc/haproxy/certs/igtf-cas-bundle.pem
cat /etc/grid-security/certificates/*.r0 > /etc/haproxy/certs/igtf-crls-bundle.pem
# Some CRLs files are not ending with a new line
# Ensuring that CRLs markers are separated by a line feed
perl -pe 's/----------/-----\n-----/' -i /etc/haproxy/certs/igtf-crls-bundle.pem
```

{{% /alert %}}

## Apache Configuration

Include this configuration on the Apache config for the virtual host of your
Keystone service, using the client ID and secret obtained above:

```ApacheConf
OIDCResponseType "code"
OIDCClaimPrefix "OIDC-"
OIDCClaimDelimiter ;
OIDCScope "openid profile email eduperson_entitlement"
OIDCProviderMetadataURL https://aai-demo.egi.eu/auth/realms/egi/.well-known/openid-configuration
OIDCClientID <client id>
OIDCClientSecret <client secret>
OIDCCryptoPassphrase <some crypto pass phrase>
OIDCRedirectURI https://<your keystone endpoint>/v3/auth/OS-FEDERATION/websso/openid/redirect

# OAuth for CLI access
OIDCOAuthIntrospectionEndpoint https://aai-demo.egi.eu/auth/realms/egi/protocol/openid-connect/token/introspect
OIDCOAuthClientID <client id>
OIDCOAuthClientSecret <client secret>

# Increase Shm cache size for supporting long entitlements
OIDCCacheShmEntrySizeMax 65536

<Location ~ "/v3/auth/OS-FEDERATION/websso/openid">
        AuthType openid-connect
        Require valid-user
</Location>

<Location ~ "/v3/OS-FEDERATION/identity_providers/egi.eu/protocols/openid/auth">
        Authtype oauth20
        Require valid-user
</Location>
```

If you have multiple keystone hosts, configure an alternative caching mechanism
as per <https://github.com/zmartzone/mod_auth_openidc/wiki/Caching>

For example, using memcache

```ApacheConf
OIDCCacheType memcache
OIDCMemCacheServers "memcache1 memcache2 memcache3"
```

Be sure to enable the `mod_auth_oidc` module in Apache, in Ubuntu:

```shell
sudo a2enmod auth_openidc
```

{{% alert title="Note" color="info" %}} If running Keystone behind a proxy, make
sure to correctly set the X-Forwarded-Proto and X-Forwarded-Port request
headers, e.g. for haproxy:

```plaintext
http-request set-header X-Forwarded-Proto https if { ssl_fc }
http-request set-header X-Forwarded-Proto http if !{ ssl_fc }
http-request set-header X-Forwarded-Port %[dst_port]
```

{{% /alert %}}

## Keystone Configuration

Configure your `keystone.conf` to include in the `[auth]` section `openid` in
the list of authentication methods:

```ini
[auth]

# This may change in your installation
# add openid to the list of the methods you support
methods = password, token, openid
```

Add a `[openid]` section as follows:

```ini
[openid]
# this is the attribute in the Keystone environment that will define the
# identity provider
remote_id_attribute = HTTP_OIDC_ISS
```

Add your horizon host as trusted dashboard to the `[federation]` section:

```ini
[federation]
trusted_dashboard = https://<your horizon>/dashboard/auth/websso/
```

Finally copy the default template for managing the tokens in horizon to
`/etc/keystone/sso_callback_template.html`. This template can be found in
keystone git repository at
`https://github.com/openstack/keystone/blob/master/etc/sso_callback_template.html`

<!-- markdownlint-disable line-length -->

```shell
curl -L https://raw.githubusercontent.com/openstack/keystone/master/etc/sso_callback_template.html \
    > /etc/keystone/sso_callback_template.html
```

<!-- markdownlint-enable line-length -->

Now restart your Apache (and Keystone if running in uwsgi) so you can configure
the Keystone Federation support.

## Keystone Federation Support

First, create a new `egi.eu` identity provider with remote id
`https://aai-demo.egi.eu/auth/realms/egi`:

```shell
$ openstack identity provider create --remote-id https://aai-demo.egi.eu/auth/realms/egi egi.eu
+-------------+-----------------------------------------+
| Field       | Value                                   |
+-------------+-----------------------------------------+
| description | None                                    |
| domain_id   | 1cac7817dafb4740a249cc9ca6b14ea5        |
| enabled     | True                                    |
| id          | egi.eu                                  |
| remote_ids  | https://aai-demo.egi.eu/auth/realms/egi |
+-------------+-----------------------------------------+
```

Create a group for users coming from EGI Check-in, usual configuration is to
have one group per VO you want to support.

```shell
$ openstack group create ops
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description |                                  |
| domain_id   | default                          |
| id          | 89cf5b6708354094942d9d16f0f29f8f |
| name        | ops                              |
+-------------+----------------------------------+
```

Add that group to the desired local project:

```shell
openstack role add member --group ops --project ops
```

Define a mapping of users from EGI Check-in to the group just created and
restrict with the `OIDC-eduperson_entitlement` the VOs you want to support for
that group. Substitute the group ID and the allowed entitlements for the
adequate values for your deployment:

```shell
$ cat mapping.egi.json
[
    {
        "local": [
            {
                "user": {
            "name": "{0}"
        },
                "group": {
                    "id": "89cf5b6708354094942d9d16f0f29f8f"
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
                    "https://aai-demo.egi.eu/auth/realms/egi"
                ]
            },
            {
                "type": "OIDC-eduperson_entitlement",
                "regex": true,
                "any_one_of": [
                    "^urn:mace:egi.eu:group:ops:role=vm_operator#aai.egi.eu$"
                ]
            }
        ]
    }
]
```

More recent versions of Keystone allow for more elaborated mapping, but this
configuration should work for Mitaka and onwards

Create the mapping in Keystone:

<!-- markdownlint-disable line-length -->

```shell
$ openstack mapping create --rules mapping.egi.json egi-mapping
+-------+--------------------------------------------------------------------------------------------------------------------------------------+
| Field | Value                                                                                                                                |
+-------+--------------------------------------------------------------------------------------------------------------------------------------+
| id    | egi-mapping                                                                                                                          |
| rules | [{u'remote': [{u'type': u'HTTP_OIDC_SUB'}, {u'type': u'HTTP_OIDC_ISS', u'any_one_of': [u'https://aai-demo.egi.eu/auth/realms/egi']}, |
|       | {u'regex': True, u'type': u'OIDC-eduperson_entitlement', u'any_one_of': [u'^urn:mace:egi.eu:.*:ops:vm_operator@egi.eu$']}],          |
|       | u'local': [{u'group': {u'id': u'89cf5b6708354094942d9d16f0f29f8f'}, u'user': {u'name': u'{0}'}}]}]                                   |
+-------+--------------------------------------------------------------------------------------------------------------------------------------+
```

<!-- markdownlint-enable line-length -->

Finally, create the federated protocol with the identity provider and mapping
created before:

```shell
$ openstack federation protocol create \
            --identity-provider egi.eu \
            --mapping egi-mapping openid
+-------------------+-------------+
| Field             | Value       |
+-------------------+-------------+
| id                | openid      |
| identity_provider | egi.eu      |
| mapping           | egi-mapping |
+-------------------+-------------+
```

Keystone is now ready to accept EGI Check-in credentials.

## Horizon Configuration

Edit your local_settings.py to include the following values:

```python
# Enables keystone web single-sign-on if set to True.
WEBSSO_ENABLED = True

# Allow users to choose between local Keystone credentials or login
# with EGI Check-in
WEBSSO_CHOICES = (
    ("credentials", _("Keystone Credentials")),
    ("openid", _("EGI Check-in")),
)
```

Once horizon is restarted you will be able to choose \"EGI Check-in\" for login.

## CLI Access

The
[OpenStack Client](https://docs.openstack.org/developer/python-openstackclient/)
has built-in support for using OpenID Connect Access Tokens to authenticate. You
first need to get a valid Access Token from EGI Check-in (e.g. from
<https://aai-demo.egi.eu/token/>) and then use it in a command like:

<!-- markdownlint-disable line-length -->

```shell
$ openstack --os-auth-url https://<your keystone endpoint>/v3 \
            --os-auth-type v3oidcaccesstoken --os-protocol openid \
            --os-identity-provider egi.eu \
            --os-access-token <your access token> \
            token issue
+---------+---------------------------------------------------------------------------------------+
| Field   | Value                                                                                 |
+---------+---------------------------------------------------------------------------------------+
| expires | 2017-05-23T11:24:31+0000                                                              |
| id      | gAAAAABZJA3fbKX....nEMAPi-IsFOCkU9QWGTISYElzYJsI3z0SJGs7QsTJv4aJQq0JDJUBz6uE85SqXDj3  |
| user_id | 020864ea9415413f9d706f6b473dbeba                                                      |
+---------+---------------------------------------------------------------------------------------+
```

<!-- markdownlint-enable line-length -->

## Additional VOs

Configuration can include as many mappings as needed in the json file. Users
will be members of all the groups matching the remote part of the mapping. For
example this file has 2 mappings, one for members of `ops` and another for
members of `fedcloud.egi.eu`:

```json
[
  {
    "local": [
      {
        "user": {
          "name": "{0}"
        },
        "group": {
          "id": "66df3a7a0c6248cba8b729de7b042639"
        }
      }
    ],
    "remote": [
      {
        "type": "HTTP_OIDC_SUB"
      },
      {
        "type": "HTTP_OIDC_ISS",
        "any_one_of": ["https://aai-demo.egi.eu/auth/realms/egi"]
      },
      {
        "type": "OIDC-eduperson_entitlement",
        "regex": true,
        "any_one_of": [
          "^urn:mace:egi.eu:group:ops:role=vm_operator#aai.egi.eu$"
        ]
      }
    ]
  },
  {
    "local": [
      {
        "user": {
          "name": "{0}"
        },
        "group": {
          "id": "e1c04284718f4e19bb0516e5534a24e8"
        }
      }
    ],
    "remote": [
      {
        "type": "HTTP_OIDC_SUB"
      },
      {
        "type": "HTTP_OIDC_ISS",
        "any_one_of": ["https://aai-demo.egi.eu/auth/realms/egi"]
      },
      {
        "type": "OIDC-eduperson_entitlement",
        "regex": true,
        "any_one_of": [
          "^urn:mace:egi.eu:group:fedcloud.egi.eu:vm_operator:role=member#aai.egi.eu$"
        ]
      }
    ]
  }
]
```

## Multiple OIDC providers

If your OpenStack deployment needs to support multiple identity providers
(besides EGI Check-in) you will need to configure `mod_auth_openidc` to support
[multiple providers](https://github.com/zmartzone/mod_auth_openidc/wiki/Multiple-Providers#discovery)
and use an OAuth2.0 token introspection proxy like
[ESACO](https://github.com/indigo-iam/esaco).

### `mod_auth_openidc` configuration

First, create a directory to host each of the providers configuration, in our
case we will use `/var/lib/apache2/oidc/metadata`, but adapt this to your
specific needs. Ensure this directory is writable by the user running apache:

```shell
mkdir -p /var/lib/apache2/oidc/metadata
chown -R www-data:www-data /var/lib/apache2/oidc/metadata
```

Set in your Apache configuration the `OIDCMetadataDir` pointing to that
directory

```ApacheConf
OIDCMetadataDir /var/lib/apache2/oidc/metadata
```

You may remove the `OIDCProviderMetadataURL`, `OIDCClientID` and
`OIDCClientSecret` options from the Apache configuration as these will be now
set in new files created in the metadata directory. For every provider you will
support, you need to create 3 files:

1. `<urlencoded-issuer-value-with-https-prefix-and-trailing-slash-stripped>.provider`
   with the OpenID Connect Discovery OP JSON metadata. The easiest way to create
   this file is getting its content from the OIDC server itself. For EGI
   Check-in:

   ```shell
   curl https://aai-demo.egi.eu/auth/realms/egi/.well-known/openid-configuration > \
        /var/lib/apache2/oidc/metadata/aai-demo.egi.eu%2Foidc.provider
   ```

1. `<urlencoded-issuer-value-with-https-prefix-and-trailing-slash-stripped>.client`
   with the client credentials. For EGI Check-in
   (`aai-demo.egi.eu%2Foidc.client`):

   ```json
   {
     "client_id": "<your client id>",
     "client_secret": "<your secret id>"
   }
   ```

1. `<urlencoded-issuer-value-with-https-prefix-and-trailing-slash-stripped>.conf`
   with any extra configuration for the provider. This may not be needed if all
   your providers are similar. For example to specify the scopes to use for
   Check-in, use a `aai-demo.egi.eu%2Foidc.conf` as follows:

   ```json
   {
     "scope": "openid email profile eduperson_entitlement"
   }
   ```

Now add for the providers you support new configuration in Apache to facilitate
the use of the dashboard. This is for a configuration of an `egi.eu` identity
provider with `openid` as protocol:

```ApacheConf
<Location ~ "/v3/auth/OS-FEDERATION/identity_providers/egi.eu/protocols/openid/websso">
        AuthType openid-connect
        # This is your Redirect URI with a new iss=<your idp iss> option added
        OIDCDiscoverURL https://<your keystone endpoint>/v3/auth/OS-FEDERATION/websso/openid/redirect?iss=https%3A%2F%2Faai-demo.egi.eu%2Foidc%2F
        # Ensure that the user is authenticated with the expected iss
        Require claim iss:https://aai-demo.egi.eu/auth/realms/egi
        Require valid-user
</Location>
```

In your Horizon configuration, set the list of providers and their mappings:

```python
# this is the list that will show up in the dropdown menu
WEBSSO_CHOICES = (
    ("credentials", _("Keystone Credentials")),
    ("egi.eu", _("EGI Check-in")),
    ("other-idp", _("Other IdP")),
)

# this maps the options above to keystone's idps and protocols
WEBSSO_IDP_MAPPING = {
    "egi.eu": ("egi.eu", "openid"),
    "other-idp": ("other-idp.com", "openid")
}
```

### ESACO configuration

ESACO will handle OAuth tokens when users hit your Keystone from API/CLI. It
needs to run as a daemon that listens (by default) on port 8156. We will use
docker for facilitating the deployment:

1. Create a yaml file with the configuration of the different providers
   (`application.yaml`):

   ```yaml
   oidc:
     clients:
       - issuer-url: https://aai-demo.egi.eu/auth/realms/egi
         client-id: "<your check-in client id>"
         client-secret: "<your check-in client secret>"
       - issuer-url: <another idp>
         client-id: "<your client id for second idp>"
         client-secret: "<your client secret for second idp>"
   ```

1. Create a environment file with the ESACO credentials you want to use
   (`esaco.env`):

   ```shell
   # User name credential requested from clients introspecting tokens
   ESACO_USER_NAME=<esaco user name>

   # Password  credential requested from clients introspecting tokens
   ESACO_USER_PASSWORD=<esaco password>
   ```

1. Run the ESACO server (adapt this as it better fits to run on your servers and
   make it run permanently):

   ```shell
   docker run -p 8156:8156 -d -env-file=esaco.env \
              -v application.yml:/esaco/config/application.yml:ro \
              indigoiam/esaco:latest
   ```

1. Configure Keystone's Apache to use ESACO as OAuth introspection endpoint:

   ```ApacheConf
   # point this to the host where ESACO is running
   OIDCOAuthIntrospectionEndpoint http://localhost:8156/introspect
   OIDCOAuthClientID              <esaco user name>
   OIDCOAuthClientSecret          <esaco password>
   OIDCIDTokenIatSlack            3600
   ```

1. Configure also the locations in Apache that should use OAuth:

   ```ApacheConf
   <Location ~ "/v3/OS-FEDERATION/identity_providers/egi.eu/protocols/openid/auth">
        Authtype oauth20
        Require valid-user
   </Location>

   <Location ~ "/v3/OS-FEDERATION/identity_providers/other_idp/protocols/openid/auth">
        Authtype oauth20
        Require valid-user
   </Location>
   ```

## Moving to EGI Check-in production instance

Once tests in the development instance of Check-in are successful, you can move
to the production instance. Go to
[EGI Federation Registry](https://aai.egi.eu/federation) and submit a Service
Request for the production instance of EGI Check-in. After the approval of the
request, you will need to update your configuration as follows:

- Update the `remote-id` of the identity provider:

  ```shell
  openstack identity provider set --remote-id https://aai.egi.eu/auth/realms/egi egi.eu
  ```

- Update the `HTTP_OIDC_ISS` filter in your mappings, e.g.:

  ```shell
  sed -i 's/aai-demo.egi.eu/aai.egi.eu/' mapping.egi.json
  openstack mapping set --rules mapping.egi.json egi-mapping
  ```

- Update Apache configuration to use `aai.egi.eu` instead of `aai-demo.egi.eu`:

  ```ApacheConf
  OIDCProviderMetadataURL https://aai.egi.eu/auth/realms/egi/.well-known/openid-configuration
  OIDCOAuthIntrospectionEndpoint https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/token/introspect
  ```

{{% alert title="Changes in the client settings" color="info" %}} If you want to
make any changes to the client configuration, you need to submit a
reconfiguration request through the
[Federation Registry](https://aai.egi.eu/federation). {{% /alert %}}

## Client Migration to Keycloak

Check-in is migrating its internal implementation to Keycloak. The Development
and Demo environments already using Keycloak since June 24th 2022 and Production
environment expected to migrate during July 2022.

A general guide on migration is available on
[Check-in documentation](../../../check-in/sp#client-migration-to-keycloak), in
this section we provide specific information for OpenStack providers.

### Changes in Apache configuration

The new Keycloak endpoint has a different URL that needs to be updated in your
apache config. You will also need to add PKCE configuration. These are the
configuration parameters and their new values:

```ApacheConf
# update Metadata URL
OIDCProviderMetadataURL https://aai.egi.eu/auth/realms/egi/.well-known/openid-configuration
# Add PKCE method
OIDCPKCEMethod S256
# update introspection endpoint
OIDCOAuthIntrospectionEndpoint https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/token/introspect
```

{{% alert title="Require claim" color="Warning" %}} If you use the
`Require claim iss:<issuer>` in your Apache configuration to restrict the
issuer, please allow both the Keycloak and MitreID issuers during the transition
period, e.g.:

```ApacheConf
<RequireAny>
    Require claim iss:https://aai.egi.eu/auth/realms/egi
    Require claim iss:https://aai.egi.eu/oidc/
</RequireAny>
```

{{% /alert %}}

#### Multiple OIDC providers

{{% alert title="Note" color="Warning" %}} Configuration in this section is only
needed if you are using `mod_auth_oidc` with multiple providers {{% /alert %}}

If you are using multiple OpenID Connect providers, you will need to add a new
configuration to your metadata directory:

```shell
$ curl https://aai.egi.eu/auth/realms/egi/.well-known/openid-configuration > \
       /var/lib/apache2/oidc/metadata/aai.egi.eu%2Fauth%2Frealms%2Fegi.conf
# copy credentials from existing client
$ cp /var/lib/apache2/oidc/metadata/aai.egi.eu%2Foidc.client \
     /var/lib/apache2/oidc/metadata/aai.egi.eu%2Fauth%2Frealms%2Fegi.client
# create configuration for the client
$ cat >  /var/lib/apache2/oidc/metadata/aai.egi.eu%2Fauth%2Frealms%2Fegi.conf << EOF
{
  "scope": "openid email profile eduperson_entitlement",
  "pkce_method": "S256"
}
EOF
```

And update your Apache configuration for the authentication with Horizon:

```ApacheConf
<Location ~ "/v3/auth/OS-FEDERATION/identity_providers/egi.eu/protocols/openid/websso">
        AuthType openid-connect
        # This is your Redirect URI with a new iss=<your idp iss> option added
        OIDCDiscoverURL https://<your keystone endpoint>/v3/auth/OS-FEDERATION/websso/openid/redirect?iss=https%3A%2F%2Faai.egi.eu%2Fauth%2Frealms%2Fegi
        # Ensure that the user is authenticated with the expected iss
        Require claim iss:https://aai.egi.eu/auth/realms/egi
        Require valid-user
</Location>
```

Also update ESACO to include the configuration of the new endpoint URL:

```yaml
oidc:
  clients:
    - issuer-url: https://aai.egi.eu/auth/realms/egi
      client-id: "<your check-in client id>"
      client-secret: "<your check-in client secret>"
    # other clients
```

### Keystone configuration

Similarly to the change from Demo to Production described
[above](#moving-to-egi-check-in-production-instance), you will need to update
the URLs on your configuration:

1. Update the `remote-id` of the identity provider to also include the new
   issuer:

   ```shell
   $ openstack identity provider set --remote-id https://aai.egi.eu/auth/realms/egi --remote-id https://aai.egi.eu/oidc/ egi.eu
   ```

1. Add the new issuer to the `HTTP_OIDC_ISS` filter in your mappings, keep both
   the `https://aai.egi.eu/oidc/` and `https://aai.egi.eu/auth/realms/egi` so
   users can still use their existing tokens. Check-in will handle the
   validation of both kind of tokens automatically. The `HTTP_OIDC_ISS` section
   should look as follows:

   ```json
   {
     "type": "HTTP_OIDC_ISS",
     "any_one_of": [
       "https://aai.egi.eu/auth/realms/egi",
       "https://aai.egi.eu/oidc/"
     ]
   }

   ```shell
   $ openstack mapping set --rules mapping.egi.json egi-mapping
   ```

As the new issuer is included in the `remote-id` configuration of the Keystone
identity provider, there should not be any changes in your users, they will be
still be able to manage owned resources after the change.
