---
title: "Accessing virtual machines with SSH"
linkTitle: "Accessing VMs with SSH"
type: docs
weight: 20
description: "Accessing virtual machines with SSH"
---

## Overview

This page provides an introduction of connecting from a local computer to a
cloud host via SSH. It provides general guidelines, SSH options, tips, and
examples for setting up the OpenStack environment.

## SSH Keys

The recommended method to access a cloud virtual machine is via ssh using **SSH
keys**, you may inject your **public key** into the virtual machine, at
deployment time, and use your **private key** to connect via ssh without any
password.

{{% alert title="Tip" color="info" %}} If you are using ssh keys in GitHub your
public keys are available at: `https://github.com/${github_username}.keys`.
i.e.: `wget https://github.com/github_username.keys` {{% /alert %}}

### SSH username

The username to use to connect to a virtual machine is dependent on the virtual
machine image and is generally different in each operative system image.

For `official OS virtual machine images` you can use the general reference
documentation on
[obtaining images](https://docs.openstack.org/image-guide/obtain-images.html).

For custom virtual machine images you need to refer to your virtual machine
image provider (i.e. it could be something specific like `cloudadm`).

It is also possible to change the username using cloud-init with a user-data
configuration (i.e. see the
[cloud config examples](https://cloudinit.readthedocs.io/en/latest/topics/examples.html))
or inject some code to add additional users (i.e. with Ansible).

### Local ssh key configuration

The `private ssh-key` stored on your local computer is required to have
restrictive file permissions. Depending on your local operative system you may
need to run:

```shell
$ chmod 600 ~/.ssh/id_rsa
```

(with `id_rsa` being the name of the private key associated with the public key
in use).

## Username and password

{{% alert title="Warning" color="warning" %}} `Username` and `password` access
to cloud virtual machine images is usually **disabled** for security reasons and
it is **strongly suggested not to be used**. {{% /alert %}}

To enable SSH password authentication, the destination virtual machine needs to
have changed `PasswordAuthentication no` to `PasswordAuthentication yes` in the
`/etc/ssh/sshd_config` file.

If really needed, a custom image with `PasswordAuthentication` enabled can be
used or that can be injected when the virtual machine is deployed.

Depending on your deployment method it could be done with Ansible, Terraform,
Salt, Puppet, Chef, cloud-init, or your own deployment tool if supported (i.e.
the Infrastructure Manager and a custom TOSCA template).

{{% alert title="Warning" color="warning" %}} If you enable
`PasswordAuthentication`, be sure to
[generate a strong and unique password or passphrase](https://bitwarden.com/password-generator/)
for your account, otherwise you virtual machines **will be** compromised, and
you access may be suspended.{{% /alert %}}

## OpenStack networking

The OpenStack environment needs to be populated with the necessary
configurations and virtual hardware. To access the virtual machine from outside
the OpenStack project you have to associate a `floating IP` to the virtual
machine (which will provide a `public IP` to the virtual machine), you also have
to open the necessary ports and add or edit the security groups, (more details
on that in the specific section).

Depending on the default configuration of the OpenStack project in order to
associate a floating IP to a virtual machine in a private network it may be
necessary to set up a virtual `router` in OpenStack and `attach` it with an
`interface` to the private network. This step is usually not required as the
OpenStack router is usually pre-configured by the cloud provider.

### Security Groups Rules

The Virtual Machine that you want to connect needs to have the SSH port (22)
reachable by your local machine. For that, it is necessary that a specific
`Rule` is set up in one of the `Security Groups` associated with the virtual
machine. The rule has to open `port 22` either to any IPs (with
`CIDR 0.0.0.0/0`) or to a specific IP (or subnet) matching the IP of the local
machine used to connect with the virtual machine.

> Sites are often providing a `default` security group, that may already contain
> this rule. You can check this using
> `openstack security group rule list default`.

### Private IP vs public IP

Virtual machines in OpenStack are configured in a private network (like in the
subnet 192.168.0.0/24) but you can directly SSH-connect with them from the
internet only using a `Public IP`, which has to be associated with a virtual
machine in the private network.

### Accessing virtual machines in the private network

In general, to reach all the virtual machines in a private network, only a
single public IP is needed.

The virtual machine associated with a public IP is often referred to as a
`Bastion` host, once you connect with the bastion host, you can connect with the
other virtual machine in the same private network using the private IPs.
Alternatively, it is also possible to set up a `JumpHost` configuration in your
local ssh configuration to do that with a single command.

#### Example: ssh configuration for Jump host

```shell
$ cat ~/.ssh/config
# Bastion
Host bastion 193.1.1.2
   User ubuntu
   Hostname 193.168.1.2
   IdentityFile ~/.ssh/id_rsa
   IdentitiesOnly yes

# with ProxyJump
Host private_vm
   HostName 192.168.1.2
   ProxyJump bastion

# old-style with ProxyCommand and additional settings
Host private_vm 192.168.1.2
   Hostname 192.168.1.2
   ProxyCommand ssh -q -A bastion nc %h %p
   User ubuntu
   ServerAliveInterval 60
   TCPKeepAlive yes
   ControlMaster auto
   ControlPath ~/.ssh/mux-%r@%h:%p
   ControlPersist 8h
   IdentityFile ~/.ssh/dev
   CheckHostIP=no
   StrictHostKeyChecking=no
```

General considerations related to setting up the ssh configuration are valid
also for the connection between hosts in the private network (i.e. the ssh
destination host needs to have a `public key` in the `~/.ssh/known_hosts` file
of the destination user, matching the `private key` used for the connection).

## SSH connection practical example

Network configuration of two virtual machines `A` and `B` :

- `A` private IP 192.168.1.2, public IP 193.168.1.2
- `B` private IP 192.168.1.3

### Connecting from a local machine to `A`

```shell
# ssh VM_OS_username@PUBLIC_IP
$ ssh centos@193.1.1.2
```

If the ssh local key is not the default `~/.ssh/id_rsa` it needs to be specified
with:

```shell
# ssh -i /path_of_your_private_ssh_key VM_OS_username@PUBLIC_IP
$ ssh -i ~/private_key centos@193.1.1.2
```

### Connecting from a local machine to `B`

```shell
# from your computer
# connect to A
$ ssh centos@193.1.1.2

# from the shell opened in 193.1.1.2
# connect from A to B
$ ssh centos@192.168.1.3
```

## Infrastructure Manager (IM)

The Infrastructure Manager (IM) provides the SSH key that can be used to connect
to the virtual machine in the VM
[info page of the IM-Dashboard (see Fig 14)](https://imdocs.readthedocs.io/en/latest/dashboard.html#infrastructures).

The page shows the information related with the virtual machine: the IP, the
username (usually `cloudadm`), and the SSH key.

## Token-based authentication

If supported by your virtual machine, you can also use
[ssh-oidc](https://github.com/EOSC-synergy/ssh-oidc) which implements the
authentication consuming under-the-hood tokens from a local demon installed on
your local machine.

More details on that soon.

The Infrastructure Manager (IM) can `Enable SSH OIDC access to the VM` in
virtual machines by selecting the related `Optional Features`.
