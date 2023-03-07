---
title: Infrastructure Manager Command-Line Interface
linkTitle: Command Line
type: docs
weight: 20
aliases:
  - /users/cloud-compute/im/cli
description: >
  Getting started with the command-line interface of Infrastructure Manager
---

You can find here documentation covering getting started with IM Command-Line
Interface (CLI) on EGI Cloud Compute sites. Full documentation at
[IM CLI documentation](https://imdocs.readthedocs.io/en/latest/client.html)

## Getting started

### Install with pip

You only have to call the install command of the `pip` tool with the `IM-client`
package.

```shell
$ pip install IM-client
```

### IM-Client Docker image

The IM Client has an official Docker container image available on Docker Hub
that can be used instead of installing the CLI. You can use it by typing:

```shell
$ docker run --rm -ti -v "$PWD:/tmp/im" grycap/im-client \
  -r https://server.com:8800 -a /tmp/im/auth.dat list
```

### Configuration

To avoid typing the parameters in all the client calls, the user can define a
config file `im_client.cfg` in the current directory or a file `.im_client.cfg`
in their home directory. In the config file the user can specify the following
parameters:

```ini
[im_client]
restapi_url=https://appsgrycap.i3m.upv.es:31443/im
auth_file=auth.dat
```

### Authentication data file

An authentication file must be created to access the IM service. It must have
one line per authentication element. **It must have at least one line with the
authentication data for the IM service** and another one for the Cloud
provider(s) the user want to access. Each line of the file is composed by pairs
of key and value separated by semicolon, and refers to a single credential. The
key and value should be separated by ` = `, that is an equals sign preceded and
followed by one whitespace at least. The following lines show the credentials
needed to access an EGI Cloud Compute site:

```shell
type = InfrastructureManager; token = egi_aai_token_value
id = egi; type = EGI; host = CESGA; vo = vo.access.egi.eu; token = egi_aai_token_value
```

The value of `egi_aai_token_value` must be replaced with a valid EGI Check-in
access token. Users of EGI Check-in can get all the information needed to obtain
access tokens, by visiting
[EGI Check-in Token Portal](https://aai.egi.eu/token/).

[oidc-agent](https://indigo-dc.gitbook.io/oidc-agent/) can be used to get
a valid access token:

```shell
id = im; type = InfrastructureManager; token = command(oidc-token OIDC_ACCOUNT)
id = egi; type = EGI; host = SCAI; vo = vo.access.egi.eu; token = command(oidc-token OIDC_ACCOUNT)
```

### Create and Manage an infrastructure

To create a virtual infrastructure you have to describe a file documenting
the required resources. IM supports its native language
[RADL](https://imdocs.readthedocs.io/en/latest/radl.html) and the
[OASIS TOSCA Simple Profile in YAML Version 1.0](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0).
You can find some examples in the
[IM GitHub repository](https://github.com/grycap/im/tree/master/examples).

For example, we can use RADL to define a simple VM with 1 CPU, 1 GB of RAM
using the EGI Ubuntu 20.04 image.

```shell
network public (outbound = 'yes')

system node (
cpu.count>=2 and
memory.size>=4g and
net_interface.0.connection = 'public' and
disk.0.os.name='linux' and
disk.0.image.url = 'appdb://SCAI/egi.ubuntu.20.04?vo.access.egi.eu'
)

configure wn (
@begin
---
 - tasks:
    - debug: msg="Configured!"
@end
)

deploy node 1
```

IM also supports TOSCA. For example this is an equivalent TOSCA document to
deploy a single VM:

```yaml
tosca_definitions_version: tosca_simple_yaml_1_0

imports:
- indigo_custom_types: https://raw.githubusercontent.com/indigo-dc/tosca-types/master/custom_types.yaml

topology_template:

  node_templates:

    simple_node:
      type: tosca.nodes.indigo.Compute
      capabilities:
        endpoint:
          properties:
            network_name: PUBLIC
        host:
          properties:
            num_cpus: 2
            mem_size: 4 GB
        os:
          properties:
            image: appdb://SCAI/egi.ubuntu.20.04?vo.access.egi.eu

  outputs:
    node_ip:
      value: { get_attribute: [ simple_node, public_address, 0 ] }
    node_creds:
      value: { get_attribute: [ simple_node, endpoint, credential, 0 ] }
```

Then we can call the `create` operation of the IM client tool using a RADL
or a TOSCA YAML file:

```shell
$ im_client.py create infra.radl
Secure connection with: https://appsgrycap.i3m.upv.es:31443/im 
Infrastructure successfully created with ID: 457273ea-85e4-11ec-aa81-faaae69bc911
```

Then we can call get the current state of infrastructure using the `getstate`
operation of the IM client tool:

```shell
$ im_client.py getstate 457273ea-85e4-11ec-aa81-faaae69bc911
Secure connection with: https://appsgrycap.i3m.upv.es:31443/im 
The infrastructure is in state: pending
VM ID: 0 is in state: pending.
```

The valid VM and infrastructure states are the following:

- `pending`, launched, but still in initialization stage;
- `running`, created successfully and running, but still in the
  configuration stage;
- `configured`, running and contextualized;
- `unconfigured`, running but not correctly contextualized;
- `stopped`, stopped or suspended;
- `off`, shutdown or removed from the infrastructure;
- `failed`, an error happened during the launching; or
- `unknown`, unable to obtain the status.
- `deleting`, in the deletion process.

Once the configuration step has started we can get the output of the Ansible
process using the `getcontmsg` operation:

```shell
$ im_client.py getcontmsg 457273ea-85e4-11ec-aa81-faaae69bc911
Secure connection with: https://appsgrycap.i3m.upv.es:31443/im 
Connected with: http://localhost:8800
Msg Contextualizator: 

2022-02-11 10:40:12.768523: Copying YAML, hosts and inventory files.
VM 0:
Contextualization agent output processed successfullyGenerate and copy the ssh key
Sleeping 0 secs.
Launch task: wait_all_ssh
...

```

Once the VM is booted we can access it via SSH using the `ssh` operation:

```shell
$ im_client.py ssh 457273ea-85e4-11ec-aa81-faaae69bc911
```

When using a TOSCA yaml document to create the infrastructure,
we can get the TOSCA output values with the `getoutputs` operation:

```shell
$ im_client.py getoutputs 457273ea-85e4-11ec-aa81-faaae69bc911
Secure connection with: https://appsgrycap.i3m.upv.es:31443/im
The infrastructure outputs:

node_ip = 8.8.8.8
node_creds = {'token': '...', 'user': 'cloudadm', 'token_type': 'private_key'}
```

Once we no more need the Infrastructure, we can destroy it using the `destroy`
operation:

```shell
$ im_client.py destroy 457273ea-85e4-11ec-aa81-faaae69bc911
Secure connection with: https://appsgrycap.i3m.upv.es:31443/im 
Infrastructure successfully destroyed
```
