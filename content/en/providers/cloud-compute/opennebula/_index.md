---
title: "OpenNebula"
weight: 30
type: "docs"
description: >
  Integration of OpenNebula providers
---

EGI Federated Cloud Site based on OpenNebula is an ordinary OpenNebula
installation with some EGI-specific integration components. There are no
additional requirements placed on internal site architecture. Follow
[OpenNebula documentation](http://opennebula.org/documentation/) if you need
advice on how to install and configure OpenNebula itself.

**Supprted OpenNebula versions:**

- OpenNebula v5.2.x
- OpenNebula v5.4.x

**Integration Prerequisites:**

- Working OpenNebula installation.
- Valid IGTF-trusted host certificates for selected hosts.

**Please consider that:**

- **CDMI** storage endpoints are currently **not supported** for
  OpenNebula-based sites.
- OpenNebula GUI integration is **not** supported.

![image](opennebulasite.png)

The following **components** must be installed:

- **rOCCI-server** \-- provides a standard virtual machine management interface.
- **keystorm** \-- serves federated authentication and authorization.
- **cloudkeeper** and **cloudkeeper-one**, synchronize site with appliances from
  [AppDB](https://appdb.egi.eu/browse/cloud).
- **oneacct-export** and **apel-ssm** \-- collect accounting and publishe it
  into EGI\'s accounting database.
- **cloud-info-provider** and **BDII**, register site in the EGI Information
  System.

## Open Ports

The following **ports** must be open to allow access to an OpenNebula-based
FedCloud site:

<!-- markdownlint-disable line-length -->
| Port          | Application              | Host                             | Note                                                                            |
| ------------- | ------------------------ | -------------------------------- | ------------------------------------------------------------------------------- |
| **2633**/TCP  | **OpenNebula**/XML-RPC   | **OpenNebula**                   | Communication between integration components and OpenNebula.                    |
| **2170**/TCP  | **BDII**/LDAP            | **cloud-info-provider**/**BDII** | EGI Service Discovery/Information System.                                       |
| **11443**/TCP | **OCCI**/HTTPS           | **rOCCI-server**                 | EGI Virtual Machine Management.                                                 |
| **5000**/TCP  | **keystorm**/HTTPS       | **keystorm**                     | EGI User Management.                                                            |
| **50505**/TCP | **cloudkeeper**/HTTP     | **cloudkeeper**                  | EGI Image Management, needs to be accessible from **cloudkeeper-one** node only |
| **50051**/TCP | **cloudkeeper-one**/gRPC | **cloudkeeper-one**              | EGI Image Management, needs to be accessible from **cloudkeeper** node only     |
<!-- markdownlint-enable line-length -->

There are no additional requirements for **OpenNebula** hosts used to run
virtual machines.

## Service accounts

This is an overview of **service accounts** used in an OpenNebula-based site.
The names are default and can be changed if required.

<!-- markdownlint-disable line-length -->
| Account name      | Host                     | Use                                                                                           |
| ----------------- | ------------------------ | --------------------------------------------------------------------------------------------- |
| `rocci`           | rOCCI-server             | Service account for **rOCCI-server**. It is only a service account, no access required.       |
| `keystorm`        | keystorm                 | Service account for **keystorm**. It is only a service account, no access required.           |
| `apel`            | oneacct-export/APEL      | Service account for **oneacct-export/APEL**. Just a service account, no access required.      |
| `openldap`        | cloud-info-provider/BDII | Service account for **cloud-info-provider/BDII**. Just a service account, no access required. |
| `cloudkeeper`     | cloudkeeper              | Service account for **cloudkeeper**. Just a service account, no access required.              |
| `cloudkeeper-one` | cloudkeeper-one          | Service account for **cloudkeeper-one**. Just a service account, no access required.          |
<!-- markdownlint-enable line-length -->

## EGI Virtual Machine Management

### Prerequisites

Enable EPEL and install the following packages prior to installation:

```shell
yum install -y epel-release wget
```

### Installation

rOCCI-server is distributed as package for multiple Linux distributions which is
available in AppDB. This guide will expect CentOS 7 distribution but
installation on any other supported distribution is very similar.

- Register `rOCCI-server` repositories

  <!-- markdownlint-disable line-length -->
  ```shell
  wget http://repository.egi.eu/community/software/rocci.server/2.x/releases/repofiles/sl-7-x86_64.repo -O /etc/yum.repos.d/rocci-server.repo
  ```
  <!-- markdownlint-enable line-length -->

- Install package

  ```shell
  yum install -y occi-server
  ```

### Configuration

- Make rOCCI-server listen on a public interface

  ```shell
  mkdir -p /etc/systemd/system/occi-server.socket.d
  cat > /etc/systemd/system/occi-server.socket.d/override.conf <<EOS
  [Socket]
  # lines below are NOT duplicated by mistake
  ListenStream=
  ListenStream=0.0.0.0:11443
  EOS

  sed -i 's/HOST=127.0.0.1/HOST=0.0.0.0/g' /etc/occi-server/variables
  ```

- Uncomment and configure optional parameters in _/etc/occi-server/variables_

  ```shell
  # host certificate readable by the rocci user
  export HOST_CERT=/path/to/cert
  # host key readable by the rocci user
  export HOST_KEY=/path/to/key
  # URL pointing to keystorm installation
  export ROCCI_SERVER_KEYSTONE_URI=https://localhost:5000/
  # URL pointing to OpenNebula installation
  export ROCCI_SERVER_OPENNEBULA_ENDPOINT=http://localhost:2633/RPC2

  # crypto options MUST MATCH keystorm's crypto options
  # see /etc/keystorm/variables
  export ROCCI_SERVER_ENCRYPTION_TOKEN_CIPHER=
  export ROCCI_SERVER_ENCRYPTION_TOKEN_KEY=
  export ROCCI_SERVER_ENCRYPTION_TOKEN_IV=
  ```

- Enable and start the service

  ```shell
  systemctl enable occi-server
  systemctl start occi-server
  ```

### Runtime

- Import resource templates to OpenNebula

  <!-- markdownlint-disable line-length -->
  ```shell
  /opt/occi-server/bin/oneresource create --endpoint http://one.example.org:2633/RPC2 # --username PRIVILEGED_USER --password PASSWD
  # re-run with `--resources /opt/occi-server/embedded/app/rOCCI-server/lib/resources/gpu/` to enable GPU resource templates
  ```
  <!-- markdownlint-enable line-length -->

- In OpenNebula, set flags for groups by adding attributes:

  ```shell
  # Default cluster for this group
  DEFAULT_CLUSTER_ID="0"
  # Default connectivity for this group: public|nat|private
  DEFAULT_CONNECTIVITY="public"
  ```

- In OpenNebula, set network type on networks used via OCCI by adding an
  attribute:

  ```shell
  NETWORK_TYPE="public"               # Supported types: public|nat|private
  ```

- In OpenNebula, set flag for networks that should be treated as public IP pools
  (for IP reservations) by adding an attribute:

  ```shell
  FLOATING_IP_POOL="yes"
  ```

- In OpenNebula, set additional network attributes:

  ```shell
  NETWORK_ADDRESS=""                  # e.g., "172.16.100.0"
  NETWORK_MASK=""                     # e.g., "255.255.255.0"
  GATEWAY=""                          # e.g., "172.16.100.1"
  ```

### Migration from v1 to v2

In order to migrate from rOCCI-server v1 with Perun-managed user accounts,
perform the following steps.

#### Preparation

- Disconnect direct propagation (slave scripts)
- Remove all user accounts that do not have any resource allocations

#### Migration

- Merge multiple single-group accounts into one account with multiple groups

  Single-group accounts owned by the same person can be identified as having:

  - `NAME` following the naming convention $VONAME_$ID where the same user
    always has the same \$ID
  - `TEMPLATE/X509_DN` where the same user always has the same DN

  Name of the merged user MUST be a SHA256 digest of the `TEMPLATE/X509_DN`
  attribute value.

  In ruby, SHA256 digest can be generated as:

  ```ruby
  require 'digest'
  Digest::SHA256.hexdigest 'DN_STRING_HERE'
  ```

- Manually add user attributes

  For each user, add the following attributes:

  - TEMPLATE/ID
  - TEMPLATE/NAME
  - TEMPLATE/IDENTITY
  - TEMPLATE/AUTHENTICATION

  Where

  - `TEMPLATE/ID` is a SHA256 digest of the `TEMPLATE/X509_DN` attribute value
  - `TEMPLATE/IDENTITY` and `TEMPLATE/NAME` contain the old `TEMPLATE/X509_DN`
    value
  - `TEMPLATE/AUTHENTICATION` is a static value 'voms'

- _chown_ all user-owned resources to the new user

## EGI User Management

### Prerequisites

Enable EPEL and install the following packages prior to installation:

```shell
yum install -y epel-release wget
```

### Installation

keystorm is distributed as package for multiple Linux distributions which is
available in AppDB. This guide will expect CentOS 7 distribution but
installation on any other supported distribution is very similar.

- Register `keystorm` repositories

  <!-- markdownlint-disable line-length -->
  ```shell
  wget http://repository.egi.eu/community/software/keystorm/1.x/releases/repofiles/sl-7-x86_64.repo -O /etc/yum.repos.d/keystorm.repo
  ```
  <!-- markdownlint-enable line-length -->

- Install package

  ```shell
  yum install -y keystorm
  ```

### Configuration

- Uncomment and configure optional parameters in _/etc/keystorm/variables_

  ```shell
  # URL pointing to OpenNebula installation
  export KEYSTORM_OPENNEBULA_ENDPOINT=http://localhost:2633/RPC2
  # Privileged OpenNebula credentials (with user & group management permissions)
  export KEYSTORM_OPENNEBULA_SECRET=oneadmin:opennebula
  ```

- Enable and start the service

  ```shell
  systemctl enable keystorm
  systemctl start keystorm
  ```

- Configure Apache2/httpd

  ```shell
  # on Ubuntu/Debian only
  a2enmod ssl && \
    a2enmod headers && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod remoteip && \
    a2enmod auth_openidc && \
    a2enmod zgridsite

  # make sure the following files exist
  SSLCertificateFile /etc/grid-security/hostcert.pem
  SSLCertificateKeyFile /etc/grid-security/hostkey.pem

  # make sure the following directory exists
  SSLCACertificatePath /etc/grid-security/certificates
  ```

- Enable and start Apache2/httpd

  ```shell
  # on Ubuntu/Debian only
  systemctl enable apache2
  systemctl restart apache2

  # on CentOS/SL only
  systemctl enable httpd
  systemctl start httpd
  ```

- Enable support for EGI VOs via VOMS:
  [VOMS configuraton](../configuration)
- Enable support for EGI VOs via OIDC: _TBD_

### Runtime

- In OpenNebula, create empty groups for _fedcloud.egi.eu_, _ops_, and _dteam_
  with group attribute:

  ```shell
  # Allow keystorm to manage membership for this group
  KEYSTORM="YES"
  ```

## EGI Accounting

### Prerequisites

`oneacct-export` uses **Secure Stomp Messenger** to send accounting records to
the central repository. Please, refer to `ssm` documentation for
[installation instructions](https://github.com/apel/ssm). By default, accounting
records are placed in `/var/spool/apel/outgoing/00000000`. You **have to**
configure and run `ssmsend` periodically, this is not handled by oneacct-export.

Enable EPEL and install the following packages prior to oneacct-export
installation: :

```shell
yum install -y epel-release wget
```

### Installation

oneacct-export is distributed as package for multiple Linux distributions which
is available in AppDB. This guide will expect CentOS 7 distribution but
installation on any other supported distribution is very similar.

- Register `oneacct-export` repositories

  <!-- markdownlint-disable line-length -->
  ```shell
  wget http://repository.egi.eu/community/software/oneacct.export/0.4.x/releases/repofiles/sl-7-x86_64.repo -O /etc/yum.repos.d/oneacct-export.repo
  ```
  <!-- markdownlint-enable line-length -->

- Install package

  ```shell
  yum install -y oneacct-export
  ```

### Configuration

- Edit `/etc/oneacct-export/conf.yml`

  ```yaml
  apel:
    # Usually a short provider name, e.g. CESNET
    site_name: Undefined
    # CMF type, only OpenNebula is supported
    cloud_type: OpenNebula
    # Public URL of your OCCI endpoint
    endpoint: https://localhost.edu:11443/

  xml_rpc:
    # OpenNebula credentials, privileged
    secret: oneadmin:opennebula
    # OpenNebula XML RPC endpoint
    endpoint: http://localhost:2633/RPC2
  ```

- Add the following lines to `/etc/one/oned.conf` and restart OpenNebula

  ```ini
  INHERIT_IMAGE_ATTR = "VMCATCHER_EVENT_AD_MPURI"
  INHERIT_IMAGE_ATTR = "VMCATCHER_EVENT_DC_IDENTIFIER"
  INHERIT_IMAGE_ATTR = "VMCATCHER_EVENT_IL_DC_IDENTIFIER"
  INHERIT_IMAGE_ATTR = "VMCATCHER_EVENT_SL_CHECKSUM_SHA512"
  INHERIT_IMAGE_ATTR = "VMCATCHER_EVENT_HV_VERSION"
  ```

- Set benchmark values on CLUSTERs (applies to all hosts in the cluster) or
  HOSTs (only for that host) in OpenNebula

  ```ini
  # benchmark type
  BENCHMARK_TYPE  = "HEP-SPEC06"
  # represents a per-core measured value of said benchmark
  BENCHMARK_VALUE = "84.46"
  ```

- Use `/etc/oneacct-export/groups.include` or
  `/etc/oneacct-export/groups.exclude` to control which information gets
  exported. Specify one group name per line.

### Usage

- Enable and register service \'redis\'

  ```shell
  service redis start
  chkconfig redis on
  ```

- Enable and register service \'oneacct-export-sidekiq\'

  ```shell
  service oneacct-export-sidekiq start
  chkconfig oneacct-export-sidekiq on
  ```

- Perform the first export manually

  ```shell
  # This process may take a long time, consider using **tmux** or **screen**
  sudo -u apel /usr/bin/oneacct-export-cron --all
  ```

- Enable and register service \'oneacct-export-cron\'

  ```shell
  service oneacct-export-cron start
  chkconfig oneacct-export-cron on
  ```

This service registers a cron job which will run oneacct-export every 2 hours.

## EGI Information System

Sites must publish information to EGI information system which is based on BDII.
There is a common
[bdii provider](https://github.com/EGI-FCTF/cloud-bdii-provider) for all cloud
management frameworks. Information on installation and configuration is
available in the cloud-bdii-provider
[README.md](https://github.com/EGI-FCTF/cloud-bdii-provider/blob/master/README.md)
and in the
[FedClouds BDII instructions](https://wiki.egi.eu/wiki/Fedclouds_BDII_instructions),
there is a
[specific section with OpenNebula details](https://wiki.egi.eu/wiki/Fedclouds_BDII_instructions#OpenNebula_.2B_rOCCI).

## EGI VM Image Management

[cloudkeeper](https://github.com/the-cloudkeeper-project/cloudkeeper) and
[cloudkeeper-one](https://github.com/the-cloudkeeper-project/cloudkeeper-one)
are tools used to ensure synchronization of virtual appliances with an
[OpenNebula](https://opennebula.org/)-based cloud.

![image](cloudkeeper-setup.png)

### Prerequisites

`cloudkeeper` uses VO-wide image lists provided by AppDB to synchronize virtual
appliances to clouds. In order to use VO-wide image lists you need to have a
valid access token to AppDB. Check
[how to access to VO-wide image lists](https://wiki.appdb.egi.eu/main:faq:how_to_get_access_to_vo-wide_image_lists)
and
[how to subscribe to a private image list](https://wiki.appdb.egi.eu/main:faq:how_to_subscribe_to_a_private_image_list_using_the_vmcatcher)
documentation for more information.

- Install recent `qemu-img` and `wget`

  ```shell
  yum install -y centos-release-qemu-ev wget sudo
  ```

### Installation

Both `cloudkeeper` and `cloudkeeper-one` are distributed as packages for
multiple Linux distributions which are available in AppDB. This guide will
expect CentOS 7 distribution but installation on any other supported
distribution is very similar.

- Register `cloudkeeper` and `cloudkeeper-one` repositories

  <!-- markdownlint-disable line-length -->
  ```shell
  wget http://repository.egi.eu/community/software/cloudkeeper/1.x/releases/repofiles/sl-7-x86_64.repo -O /etc/yum.repos.d/cloudkeeper.repo
  wget http://repository.egi.eu/community/software/cloudkeeper.one/1.x/releases/repofiles/sl-7-x86_64.repo -O /etc/yum.repos.d/cloudkeeper-one.repo
  ```
  <!-- markdownlint-enable line-length -->

- Install `cloudkeeper` and `cloudkeeper-one`

  ```shell
  yum install -y cloudkeeper cloudkeeper-one
  ```

### `cloudkeeper` configuration

`cloudkeeper` configuration file can be found in
`/etc/cloudkeeper/cloudkeeper.yml`.

image-lists

: URLs of image lists containing appliances which you want to synchronize to
your cloud. Must contain authentication token.

```yaml
image-lists: # List of image lists to sync against
 - https://APPDB_TOKEN:x-oauth-basic@vmcaster.appdb.egi.eu/store/vo/somevo/image.list
 - https://APPDB_TOKEN:x-oauth-basic@vmcaster.appdb.egi.eu/store/vo/othervo/image.list
```

authentication

: Says whether `cloudkeeper` and `cloudkeeper-one` will communicate securely via
TLS. This requires options `certificate`, `key` and `backend->certificate` to be
properly set.

image-dir

: Directory where images will be downloaded and converted before uploading to
OpenNebula. Directory is cleaned after each appliance registration/update
nonetheless, it should provide sufficient free space (some runs may require up
to 200GB of free space).

remote-mode

: Says whether to serve downloaded images via web server or to copy them
locally. Should be `true` especially if OpenNebula is running on different
machine than `cloudkeeper` and `cloudkeeper-one`.

nginx-\>ip-address

: IP address on which NGINX will serve images in remote mode. This address MUST
be accessible from the machine hosting `cloudkeeper-one` and your OpenNebula
installation.

formats

: List of image formats images can be converted to and are supported by the
cloud.

### `cloudkeeper-one` configuration

`cloudkeeper-one` configuration file can be found in
`/etc/cloudkeeper-one/cloudkeeper-one.yml`.

authentication

: Says whether `cloudkeeper` and `cloudkeeper-one` will communicate securely via
TLS. This requires options `certificate`, `key` and `core->certificate` to be
properly set.

appliances-\>tmp-dir

: Directory images will be copied to before registration in OpenNebula when in
non-remote mode.

appliances-\>template-dir

: Directory for ERB-enabled templates of OpenNebula images and templates used
for registration. More information in the next section.

opennebula-\>datastores

: List of OpenNebula datastores images are uploaded to.

opennebula-\>allow-remote-source

: Allows OpenNebula to directly download images in remote mode.

### Templates configuration

The directory specified by option `appliances->template-dir` contains templates
for OpenNebula images and templates in files `image.erb` and `template.erb`.
These files can be customized to register images and templates according to your
needs. Files are using standard ERB templating mechanism. By default, these
files can be found in `/etc/cloudkeeper-one/templates/`.

- `image.erb` available variables:

name

: Name, under which will the image be registered

appliance

: Appliance object. Contains following attributes: `identifier`, `title`,
`description`, `mpuri`, `group`, `ram`, `core`, `version`, `architecture`,
`operating_system`, `vo`, `expiration_date`, `image_list_identifier`,
`attributes`.

image

: Image object. Contains following attributes: `format`, `uri`, `checksum`,
`size`

- `template.erb` available variables:

name

: Name, under which will the template be registered

image_id

: ID of the previously registered image (same appliance)

appliance

: Appliance object. Same as for `image.erb`

image

: Image object. Same as for `image.erb`

**For compatibility with other integration components, add the following lines
to \`\`image.rb\`\`:**

```ruby
VMCATCHER_EVENT_AD_MPURI="<%= appliance.mpuri %>"
VMCATCHER_EVENT_HV_VERSION="<%= appliance.version %>"
VMCATCHER_EVENT_DC_DESCRIPTION="<%= appliance.description %>"
VMCATCHER_EVENT_DC_TITLE="<%= appliance.title %>"
```

### Usage

- Start and enable `cloudkeeper-one` service

  ```shell
  systemctl enable cloudkeeper-one
  systemctl start cloudkeeper-one
  ```

`cloudkeeper-one` will be now listening for communication from `cloudkeeper`.

- Perform the first synchronization manually

  ```shell
  # This MAY take a long time, keep checking for successful exit with
  # `systemctl status cloudkeeper`
  systemctl start cloudkeeper
  ```

- Start and enable systemd timer for `cloudkeeper`

  ```shell
  systemctl enable cloudkeeper.timer
  systemctl start cloudkeeper.timer
  ```

This service registers a systemd timer which will run `cloudkeeper` approx.
every 2 hours.
