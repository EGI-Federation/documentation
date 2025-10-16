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

On the source migration instance:

```sh
# If you don't have an SSH key pair already
ssh-keygen -t rsa

# Replace user@destination_migration_host with the actual username and hostname/IP
ssh-copy-id ${DESTINATION_USER}@${DESTINATION_HOST}
```

Test the connection:

```sh
ssh user@destination_host "hostname"
```

This should execute hostname on the destination migration instance without asking for a password.

### Step 2: Manual Snapshot Replication (Testing the Process)

Steps for testing the process manually before automating it.

#### 2.1 Define Variables (Source Site)

On the source migration instance:

```sh
# --- Configuration ---
INSTANCE_ID="12345678-90ab-cdef-1234-567890abcdef"     # ID of the VM to snapshot
BASE_SNAPSHOT_NAME="instance_snapshot"                 # Base name for snapshots
LOCAL_OPENRC_PATH="$HOME/source_openrc"                # Path to the OpenStack RC file for the source site

DESTINATION_USER="cloudadm"                            # SSH user on the destination migration instance
DESTINATION_HOST="destination_host"                    # Hostname or IP of the destination migration instance
DESTINATION_OPENRC_PATH="~/destination_openrc"         # Path to OpenStack RC file on destination instance
REMOTE_TMP_DIR="/tmp"                                  # Temporary directory on destination for the image

# --- Dynamic Variables ---
TODAYS_DATE=$(date +%Y-%m-%d)
SNAPSHOT_NAME_WITH_DATE="${BASE_SNAPSHOT_NAME}-${TODAYS_DATE}"
LOCAL_IMAGE_FILE="/tmp/${SNAPSHOT_NAME_WITH_DATE}.img"
REMOTE_IMAGE_FILE="${REMOTE_TMP_DIR}/${SNAPSHOT_NAME_WITH_DATE}.img"
```

#### 2.2 Create a Snapshot on the Source

On the source migration instance:

```sh
echo "Sourcing OpenStack RC file for source: ${LOCAL_OPENRC_PATH}"
source "${LOCAL_OPENRC_PATH}"

echo "Creating snapshot '${SNAPSHOT_NAME_WITH_DATE}' for instance '${INSTANCE_ID}'..."
SNAPSHOT_ID=$(openstack server image create \
  --name "${SNAPSHOT_NAME_WITH_DATE}" \
  "${INSTANCE_ID}" \
  -f value -c id)

if [ -z "$SNAPSHOT_ID" ]; then
  echo "Error: Failed to create snapshot. SNAPSHOT_ID is empty."
  exit 1
fi
echo "Snapshot created with ID: ${SNAPSHOT_ID}"
```

#### 2.3 Transfer the Snapshot to the Destination

On the source migration instance:

```sh
echo "Saving snapshot image to '${LOCAL_IMAGE_FILE}'..."
openstack image save --file "${LOCAL_IMAGE_FILE}" "${SNAPSHOT_ID}"

echo "Transferring image file to ${DESTINATION_USER}@${DESTINATION_HOST}:${REMOTE_TMP_DIR}/ ..."
rsync -avz --progress "${LOCAL_IMAGE_FILE}" "${DESTINATION_USER}@${DESTINATION_HOST}:${REMOTE_TMP_DIR}/"
```

#### 2.4 Import Snapshot on Destination

On the destination migration instance:

```sh
echo 'Sourcing OpenStack RC file on destination: ${DESTINATION_OPENRC_PATH}'
source '${DESTINATION_OPENRC_PATH}'

echo 'Creating image from transferred file: ${REMOTE_IMAGE_FILE}'
openstack image create \\
  --file '${REMOTE_IMAGE_FILE}' \\
  --disk-format qcow2 \\
  --container-format bare \\
  '${SNAPSHOT_NAME_WITH_DATE}'
```

#### 2.5 Cleanup (Source)

On the source migration instance:

```sh
echo "Cleaning up local image file: ${LOCAL_IMAGE_FILE}"
rm -f "${LOCAL_IMAGE_FILE}"
# Optional: Consider a strategy for deleting old snapshots on the source OpenStack to save space.
# openstack image delete OLD_SNAPSHOT_NAME_OR_ID
```

### Step 3: Automate Snapshot Replication with a Script

On the source migration instance, create a script file to combine all the above steps, for example, `~/replicate_vm_snapshot.sh`
Ensure INSTANCE_ID and other critical variables are correctly set within the script itself or loaded from a config file.

Make the script executable:

```sh
chmod +x ~/replicate_vm_snapshot.sh
```

Test the script manually:
```sh
~/replicate_vm_snapshot.sh
```

Check the ~/snapshot_replication.log file for output.

Add the script to Cron. Edit the crontab on the *source migration instance*:

```sh
crontab -e
```

Add an entry to run the script daily at, for example, 2:00 AM:

```sh
# Redirect all output (stdout and stderr) from cron to the log file handled by the script, or to /dev/null if confident.
0 2 * * * /bin/bash /home/your_user/replicate_vm_snapshot.sh >> /home/your_user/snapshot_replication.log 2>&1
```

Replace /home/your_user/ with the actual path to the script and log file.


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
- **Helm chart deployment in Kubernetes**, with [Cloud Container Compute](https://docs.egi.eu/users/compute/cloud-compute/), enabling easy setup with just a few clicks.

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
