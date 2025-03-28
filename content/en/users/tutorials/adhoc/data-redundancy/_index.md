---
title: "Data redundancy"
type: docs
weight: 180
description: >-
     Guide to redundant storage in cloud environments
---

## Introduction

Data redundancy in cloud environments is crucial to ensure high availability, data integrity, and disaster recovery.
In federated infrastructures like EGI, redundancy mitigates risks such as hardware failures, accidental deletions, and
data corruption. Without proper redundancy, critical data may be lost permanently or become inaccessible during
infrastructure failures.
Redundancy enables resilience against failures and provides consistent service availability in Kubernetes (k8s) and
OpenStack deployments.  Relying on multiple geographically distributed sites supporting redundancy is essential for use
cases that require cross-site data protection, compliance, and disaster recovery strategies.

This guide covers two approaches to achieving redundancy:

1. **Using Rsync and Snapshot Replication** between two OpenStack installations.
2. **Using MinIO for Object Storage**, providing an S3-compatible alternative for data redundancy.

Both solutions provide redundancy but cater to different use cases. The OpenStack rsync method is best for VM failover,
while MinIO offers flexible object storage redundancy.

> For a blend of security and granular control, `Restic`'s encrypted, deduplicated backups offer a compelling
> alternative to solely relying on OpenStack or MinIO redundancy.
> [https://github.com/restic/restic](https://github.com/restic/restic)

---

## Solution 1: Redundant OpenStack Setup

_**Using Rsync and Snapshot Replication**_

### Overview

This solution synchronizes virtual machine (VM) snapshots between two OpenStack instances, ensuring high availability
and data redundancy.

### Prerequisites

- A virtual organization with access to two OpenStack sites (Source and Destination sites)
- A migration instance on both sites
- SSH access between sites
- OpenStack command-line tools installed
- Sufficient storage capacity

### Step 1: Configure SSH for Passwordless Authentication

On the source site:

```sh
ssh-keygen -t rsa
ssh-copy-id user@destination_host
```

### Step 2: Snapshot Replication

#### 2.1 Create a Snapshot on the Source

```sh
openstack server snapshot create --name instance_snapshot INSTANCE_ID
```

#### 2.2 Transfer the Snapshot to the Destination

```sh
openstack image list | grep instance_snapshot
openstack image save --file instance_snapshot.img SNAPSHOT_ID
rsync -avz instance_snapshot.img user@destination_host:/tmp/
```

#### 2.3 Import Snapshot on Destination

```sh
openstack image create --file /tmp/instance_snapshot.img --disk-format qcow2 --container-format bare instance_snapshot
```

### Step 3: Automate Snapshot Replication

Edit the cron job:

```sh
crontab -e
```

Add:

```sh
0 2 * * * openstack server snapshot create --name instance_snapshot-$(date +\%F) INSTANCE_ID
0 3 * * * openstack image save --file /tmp/instance_snapshot-$(date +\%F).img $(openstack image list | \
    grep instance_snapshot-$(date +\%F) | awk '{print $2}')
0 4 * * * rsync -avz /tmp/instance_snapshot-$(date +\%F).img user@destination_host:/tmp/
0 5 * * * ssh user@destination_host 'openstack image create --file /tmp/instance_snapshot-$(date +\%F).img \
    --disk-format qcow2 --container-format bare instance_snapshot-$(date +\%F)'
```

### Step 4: Testing Failover

On the destination site:

```sh
openstack server create --flavor FLAVOR_ID --image instance_snapshot --network NETWORK_ID new_instance
```

### Results

By utilizing rsync and snapshot replication, VM state consistency is ensured between sites, improving failover
readiness.

---

## Solution 2: Redundant Object Storage

_**with MinIO**_

### Overview

MinIO is an open-source, high-performance object storage solution compatible with Amazon S3. It enables redundancy and
data replication across multiple sites, making it a good alternative for OpenStack Swift or AWS S3 in a private or
federated cloud.

### Deployment in FedCloud

MinIO is available in FedCloud with different deployment options:

- **Preconfigured Virtual Machines** using Infrastructure Manager.
- **Helm chart deployment in Kubernetes**, with CESNET's Rancher enabling easy setup with just a few clicks.

### Prerequisites

- MinIO installed on both source and destination sites
- Network connectivity between sites
- Storage capacity for object replication

### MinIO Configuration

To configure MinIO for redundancy, follow these steps:

#### Step 1: Access the MinIO Web Interface

- Open your browser and navigate to `http://<minio_host>:9001`.
- Log in with your MinIO credentials (admin username and password).

#### Step 2: Create Buckets

- In the MinIO Console, go to the "Buckets" section.
- Click "Create Bucket" and enter a bucket name.
- Configure access settings (private/public as required).

#### Step 3: Configure Replication

- Go to "Buckets" and select the bucket you created.
- Click on the "Replication" tab.
- Add a remote target:
  - Enter the remote MinIO server address.
  - Provide access credentials for the remote instance.
  - Enable "Active Sync" to keep the data continuously updated.
- Save the configuration.

#### Step 4: Verify Replication

Upload an object to the source MinIO instance and check if it appears in the destination MinIO bucket.

### Alternate MinIO Configuration using Command-line

#### Step 1: Install and Configure MinIO

On each site:

```sh
docker run -d --name minio \
  -p 9000:9000 \
  -p 9001:9001 \
  -e "MINIO_ROOT_USER=admin" \
  -e "MINIO_ROOT_PASSWORD=password" \
  quay.io/minio/minio server /data --console-address ":9001"
```

#### Step 2: Set Up Site-to-Site Replication

##### 2.1 Configure Replication on Source MinIO

```sh
mc alias set source http://source_host:9000 admin password
mc alias set destination http://destination_host:9000 admin password
mc replicate add source/bucket destination/bucket --remote-bucket destination/bucket --sync
```

##### 2.2 Verify Replication

```sh
mc mirror --watch source/bucket destination/bucket
```

---
