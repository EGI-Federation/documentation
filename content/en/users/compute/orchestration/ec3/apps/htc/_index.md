---
title: HTC
type: docs
weight: 20
aliases:
  - /users/cloud-compute/ec3/apps/htc
description: >
  Using Elastic Cloud Computing Cluster (EC3) platform to create elastic virtual
  clusters on the EGI Cloud.
---

## Templates

We will build a torque cluster on one of the EGI Cloud providers using EC3.
Create a directory to store EC3 configuration and init it with the
[FedCloud client](../../../../../getting-started/cli):

```shell
mkdir -p torque
cd torque
fedcloud ec3 init --site <your site> --vo <your vo>
```

We will use the following templates:

1. `torque` (from ec3 default templates)
1. `nfs` (from ec3 default templates),
1. `ubuntu-1604` (user's template),
1. `cluster_configure` (user's template)

You can find the content below (make sure that you adapt them to your needs):

`templates/ubuntu-1604.radl` specifies the VM image to use in the deployment:

```plaintext
description ubuntu-1604 (
    kind = 'images' and
    short = 'Ubuntu 16.04' and
    content = 'FEDCLOUD Image for EGI Ubuntu 16.04 LTS [Ubuntu/16.04/VirtualBox]'
)
system front (
    cpu.arch = 'x86_64' and
    cpu.count >= 4 and
    memory.size >= 8196 and
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://<url>/<image_id>' and
    disk.0.os.credentials.username = 'ubuntu'
)
system wn (
    cpu.arch = 'x86_64' and
    cpu.count >= 2 and
    memory.size >= 2048m and
    ec3_max_instances = 10 and # maximum number of working nodes in the cluster
    disk.0.os.name = 'linux' and
    disk.0.image.url = 'ost://<url>/<image_id>' and
    disk.0.os.credentials.username = 'ubuntu'
)
```

`templates/cluster_configure.radl` customises the torque deployment to match our
needs:

```plaintext
configure front (
@begin
---
  - vars:
     - USERS:
       - { name: user01, password: <PASSWORD> }
       - { name: user02, password: <PASSWORD> }
[..]
    tasks:
    - user:
        name: "{{ item.name }}"
        password: "{{ item.password }}"
        shell: /bin/bash
        append: yes
        state: present
      with_items: "{{ USERS }}"
    - name: Install missing dependences in Debian system
      apt: pkg={{ item }} state=present
      with_items:
       - build-essential
       - mpich
       - gcc
       - g++
       - vim
      become: yes
      when: ansible_os_family == "Debian"
    - name: SSH without password
      include_role:
        name: grycap.ssh
      vars:
        ssh_type_of_node: front
        ssh_user: "{{ user.name }}"
      loop: '{{ USERS }}'
      loop_control:
        loop_var: user
    - name: Updating the /etc/hosts.allow file
      lineinfile:
        path: /etc/hosts.allow
        line: 'sshd: XXX.XXX.XXX.*'
      become: yes
    - name: Updating the /etc/hosts.deny file
      lineinfile:
        path: /etc/hosts.deny
        line: 'ALL: ALL'
      become: yes
@end
)
configure wn (
@begin
---
  - vars:
     - USERS:
       - { name: user01, password: <PASSWORD> }
       - { name: user02, password: <PASSWORD> }
[..]
    tasks:
    - user:
        name: "{{ item.name }}"
        password: "{{ item.password }}"
        shell: /bin/bash
        append: yes
        state: present
      with_items: "{{ USERS }}"
    - name: Install missing dependences in Debian system
      apt: pkg={{ item }} state=present
      with_items:
       - build-essential
       - mpich
       - gcc
       - g++
       - vim
      become: yes
      when: ansible_os_family == "Debian"
    - name: SSH without password
      include_role:
        name: grycap.ssh
      vars:
        ssh_type_of_node: wn
        ssh_user: "{{ user.name }}"
      loop: '{{ USERS }}'
      loop_control:
        loop_var: user

    - name: Updating the /etc/hosts.allow file
      lineinfile:
        path: /etc/hosts.allow
        line: 'sshd: XXX.XXX.XXX.*'
      become: yes
    - name: Updating the /etc/hosts.deny file
      lineinfile:
        path: /etc/hosts.deny
        line: 'ALL: ALL'
      become: yes
@end
)
```

## Create the cluster

Deploy the cluster using ec3 docker image:

```shell
$ docker run -it -v $PWD:/root/ -w /root \
         grycap/ec3 launch torque_cluster \
         torque nfs ubuntu-1604 refresh cluster_configure \
         -a auth.dat
Creating infrastructure
Infrastructure successfully created with ID: 529c62ec-343e-11e9-8b1d-300000000002
Front-end state: launching
Front-end state: pending
Front-end state: running
IP: 212.189.145.XXX
Front-end configured with IP 212.189.145.XXX
Transferring infrastructure
Front-end ready!
```

To access the cluster, use the command:

```shell
$ docker run -ti -v $PWD:/root/ -w /root grycap/ec3 ssh torque_cluster

Warning: Permanently added '212.189.145.140' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 3.13.0-164-generic x86_64)
 * Documentation:  https://help.ubuntu.com/
Last login: Tue Feb 19 13:04:45 2019 from servproject.i3m.upv.es
```

## Configuration of the cluster

### Enable Password-based authentication

Change settings in `/etc/ssh/sshd_config`

```plaintext
# Change to no to disable tunnelled clear text passwords
PasswordAuthentication yes
```

and restart the ssh daemon:

```shell
sudo service ssh restart
```

### Configure the number of processors of the cluster

```shell
$ cat /var/spool/torque/server_priv/nodes
wn1 np=XX
wn2 np=XX
[...]
```

To obtain the number of CPU/cores (np) in Linux, use the command:

```shell
$ lscpu | grep -i CPU
CPU op-mode(s):         32-bit, 64-bit
CPU(s):                 16
On-line CPU(s) list:    0-15
CPU family:             6
Model name:             Intel(R) Xeon(R) CPU E5520  @ 2.27GHz
CPU MHz:                2266.858
NUMA node0 CPU(s):      0-3,8-11
NUMA node1 CPU(s):      4-7,12-15
```

### Test the cluster

Create a simple test script:

```shell
$ cat test.sh
#!/bin/bash
#PBS -N job
#PBS -q batch

#cd $PBS_O_WORKDIR/
hostname -f
sleep 5
```

Submit to the batch queue:

```shell
qsub -l nodes=2 test.sh
```

## Destroy the cluster

To destroy the running cluster, use the command:

```shell
$ docker run -it -v $PWD:/root/ -w /root grycap/ec3 destroy torque_cluster
WARNING: you are going to delete the infrastructure (including frontend and nodes).
Continue [y/N]? y
Success deleting the cluster!
```
