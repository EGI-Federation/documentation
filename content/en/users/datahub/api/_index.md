---
title: "API"
linkTitle: "API"
type: docs
description: "Documentation of EGI DataHub APIs"
weight: 30
---

Most if not all operations can be performed using the Onedata API.

The official documentation is at
[https://onedata.org/#/home/api](https://onedata.org/#/home/api).

{{% alert title="Important" color="warning" %}} In order to be able to access
the Onedata APIs, an access token is required. See below for instructions on how
to generate one. {{% /alert %}}

## Getting an API access token

Tokens have to be generated from the **EGI DataHub** (Onezone) interface as
documented in
[Generating tokens for using Oneclient or APIs](../clients/#generating-tokens-for-using-oneclient-or-apis)
or using a command line call as documented hereafter.

Bear in mind that a single API token can be used with both Onezone, Oneprovider
and other Onedata APIs.

It's possible to retrieve the `CLIENT_ID`, `CLIENT_SECRET` and `REFRESH_TOKEN`
using a
[special OIDC client connected to Check-in](https://aai.egi.eu/fedcloud/). See
[Check-in documentation on EGI Wiki](https://wiki.egi.eu/wiki/AAI) for more
information.

```sh
CLIENT_ID=<CLIENT_ID>
CLIENT_SECRET=<CLIENT_SECRET>
REFRESH_TOKEN=<REFRESH_TOKEN>
# Retrieving an OIDC token from Check-in
curl -X POST -u "$CLIENT_ID":"$CLIENT_SECRET"  \
       -d "client_id=$CLIENT_ID&$CLIENT_SECRET&grant_type=refresh_token&refresh_token=$REDRESH_TOKEN&scope=openid%20email%20profile" \
       'https://aai.egi.eu/oidc/token' | python -m json.tool;
# Token is in the `access_token` field of the response
```

The following variables should be set:

- `OIDC_TOKEN`: OpenID Connect Access token.
- `ONEZONE_HOST`: name or IP of the Onezone host (to use Onezone API).
- `ONEPROVIDER_HOST`: name or IP of the Oneprovider host (to use Oneprovider
  API).

```sh
ONEZONE_HOST=https://datahub.egi.eu
OIDC_TOKEN=<OIDC_ACCESS_TOKEN>
curl -H "X-Auth-Token: egi:$OIDC_TOKEN" -X POST \
  -H 'Content-type: application/json' -d '{}' \
  "$ONEZONE_HOST/api/v3/onezone/user/client_tokens"
```

## Testing the API with the REST client

A docker container with clients acting as wrappers around the API calls is
available: `onedata/rest-cli`. It\'s very convenient for discovering and testing
the **Onezone** and **Oneprovider** API.

```sh
docker run -it onedata/rest-cli
# Exporting env for Onezone API
export ONEZONE_HOST=https://datahub.egi.eu
export ONEZONE_API_KEY=<ACCESS_TOKEN>
# Checking current user
onezone-rest-cli getCurrentUSer | jq '.'
# Listing all accessible spaces
onezone-rest-cli listEffectiveUserSpaces | jq '.'
```

```sh
docker run -it onedata/rest-cli
# Exporting env for Oneprovider API
export ONEPROVIDER_HOST=https://plg-cyfronet-01.datahub.egi.eu
export ONEPROVIDER_API_KEY=<ACCESS_TOKEN>
# Listing all spaces supported by the Oneprovider
oneprovider-rest-cli getAllSpaces | jq '.'
# Listing content of a space
oneprovider-rest-cli listFiles path='EGI Foundation/'
oneprovider-rest-cli listFiles path='EGI Foundation/CS3_dataset'
```

## Printing the raw REST calls of a wrapped command

Raw REST calls (used with `curl`) can be printed using the `--dry-run` switch.

```sh
docker run -it onedata/rest-cli
export ONEZONE_HOST=https://datahub.egi.eu
export ONEZONE_API_KEY=<ACCESS_TOKEN>
# Listing all accessible spaces
onezone-rest-cli listEffectiveUserSpaces | jq '.'
# Printing the curl command without running it
onezone-rest-cli listEffectiveUserSpaces --dry-run
```

## Working with PID / Handle

It's possible to mint a Permanent Identifier (PID) for a space or a subdirectory
of a space using a handle service (like Handle.net) that is registered in the
Onezone (EGI DataHub).

Once done, accessing the PID using its URL will redirect to the Onedata share
allowing to retrieve the files.

Prerequisites: access to a Handle service registered in the Onezone. See the
[Handle Service API documentation](https://onedata.org/#/home/documentation/doc/using_onedata/handle_services.html)
for documentation on registering a new Handle service or ask a Onezone
administrator to authorize you to use an existing Handle service already
registered in the Onezone.

The following variables should be set:

- `API_ACCESS_TOKEN`:
  [Onedata API access token](https://onedata.org/docs/doc/using_onedata/using_onedata_from_cli.html#authentication)
- `ONEZONE_HOST`: name or IP of the Onezone host (to use Onezone API).
- `ONEPROVIDER_HOST`: name or IP of the Oneprovider host (to use Oneprovider
  API)

<!-- markdownlint-disable line-length -->

```sh
# Getting the IDs of the available Handle Services
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/user/handle_services"
HANDLE_SERVICE=<HANDLE_SERVICE_ID>

# Getting details about a specific Handle service
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/user/handle_services/$HANDLE_SERVICE"

# Listing all spaces
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/user/effective_spaces/" | jq '.'

# Displaying details of a space
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/spaces/$SPACE_ID" | jq '.'

# Listing content of a space
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEPROVIDER_HOST/api/v3/oneprovider/files/EGI%20Foundation/" | jq '.'

# Creating a share of a subdirectory of a space
DIR_ID_TO_SHARE=<DIR_ID>
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  -X POST -H 'Content-Type: application/json' \
  -d '{"name": "input"}'
  "$ONEPROVIDER_HOST/api/v3/oneprovider/shares-id/$DIR_ID_TO_SHARE" | jq '.'

# Displaying the share
SHARE_ID=<SHARED_ID>
curl -sS --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
   "$ONEZONE_HOST/api/v3/onezone/shares/$SHARE_ID" | jq '.'

# Registering a handle
# Proper Dublin Core metadata is required
# It can be created using https://nsteffel.github.io/dublin_core_generator/generator_nq.html
cat metadata.xml
# Escape double quotes and drop line return
METADATA=$(cat metadata.xml | sed 's/"/\\"/g' | tr '\n' ' ')
# On handle creation the created handles is provided in the Location header
curl -D - --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  -H "Content-type: application/json" -X POST \
  -d '{"handleServiceId": "'"$HANDLE_SERVICE_ID"'", "resourceType": "Share", "resourceId": "'"$SHARE_ID"'", "metadata": "'"$METADATA"'"}' \
  "$ONEZONE_HOST/api/v3/onezone/user/handles"

# Listing handles
curl --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/user/handles"

# Displaying a handle
HANDLE_ID=<HANDLE_ID>
curl --tlsv1.2 -H "X-Auth-Token: $API_ACCESS_TOKEN" \
  "$ONEZONE_HOST/api/v3/onezone/user/handles/$HANDLE_ID"
```

<!-- markdownlint-enable line-length -->
