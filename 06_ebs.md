# Elastic Block Store (EBS)
a network-attached drive you can mount on to your instances as a logical volume.

## Features:
* EBS Volumes persist beyond the life of an instance (controlled by "Delete on Termination" option)
* EBS Volumes can be detached and reattached to different instances within the same AZ.
* EBS Volumes support several live configuration changes without any downtime on the service (EC2)
    - increasing the volume
    - throughput changes
    - volume type changes

**Note**: By default, when an instance is terminated, the root EBS volume is deleted unless `Delete on Termination` is disabled.


## Limitations:
* can only be mounted to one instance at a time; 
* bound to an AZ; you can move a volume across AZs using snapshotting
* define capacity & IOPS in advance 
* you are charged for the provisioned capacity and not for what you actually use.

## EBS Snapshots
Make a point-in-time backup of your EBS volume
* not necessary to detach a volume to do snapshot, but it is recommended
* can copy snapshots across AZ or Region
* EBS Snapshot Archive
    * move a snapshot to archive tier that is 75% cheaper
    * takes 24-72 hours for restoring the archive
* Recycle Bin for EBS Snapshots
    * setup rules for retention of deleted snapshots
    * retention can be 1d - 1yr
* Fast Snapshot Restore (FSR)
    * force full init of snapshot to have no latency on first use
    * very expensive
* **Data Lifecycle Manager** can be used to automate the EBS Snapshot lifecycle:
    - create snapshots for EBS based on tags
    - schedule EBS snapshots
    - delete snapshots after the retention period
    - disaster recovery using cross-region/cross-account copying of snapshots.

## Amazon Machine Image (AMI)
an AMI is a template for launching EC2 instances
which included the software, configuration, OS, monitoring etc.

Benefits:
- faster boot/config time because software is pre-packaged
- AMIs are built for specific region and can be copied across regions

An EC2 instance can be launched from
- Public AMIs
- Marketplace AMI
- Your own AMI
- **Data Lifecycle Manager** policies can be used to automate AMI creation and cleanup.

## EC2 Instance Store
is a high performance direct-attached hardware disk (no network latency)

they are ephemeral, lost if EC2 is stopped
good for buffer/cache/scratch data/temporary content

risk of data loss if underlying hardware fails
backups and replication is recommended

## EBS Volume Types
| Volume Type | Generation | Best Use Case | Size | Throughput |
|-------------|------------|---------------|------|------------|
| General Purpose SSD | gp2          | Balanced performance and cost | 1GiB - 16TiB | 3 IOPS per GiB; burstable upto 3000 |
| General Purpose SSD | gp3          | Balanced performance and cost | 1GiB - 64TiB | 3000-80,000 IOPS |
| Provisioned IOPS SSD | io1          | High-performance mission-critical applications | 4GiB - 16TiB | 100-64,000 IOPS depending on volume |
| Provisioned IOPS SSD | io2          | Highest-performance mission-critical applications | 4GiB - 64TiB | 100-256,000 IOPS depending on volume |
| Throughput Optimized HDD | st1          | Low-cost throughput-intensive workloads | 125GiB - 16TiB | 40MiB/s per TiB |
| Cold HDD | sc1          | Infrequent access workloads | 125GiB - 16TiB | 12MiB/s per TiB |


EBS volumes are characterized by Size|Throughput|IOPS
Only gp2/gp3 and io1/io2 can be used as boot volume

Single root I/O virtualization (SR-IOV) enables higher I/O performance for EBS volumes.


## EBS Multi-Attach - io1/io2 family
atach the same EBS volume to multiple EC2 in the same AZ
each instance has RW performance
Use Case:
    - HA
    - Apps must manage concurrent write ops
up to 16 EC2 instances at a time
must use fs that is cluster aware (not XFS, EXT4, etc)

## EBS Encryption
### Encryption at rest
- When enabled, volumes are encrypted using AWS-KMS
- you can chose either the `(default) aws/ebs` AWS-Managed-Key (AMK) or create your own Customer Managed Key (CMK)
- You can enable '*Always encrypt new EBS volumes*' option in EC2 > Settings

## EXAM - EBS Encrypting an unencrypted volume
Follow these steps to encrypt an unencrypted EBS volume
- stop the EC2 instance (not required but recommended)
- create an EBS snapshot. This snapshot will be unencrypted.
- copy the snapshot and enable encryption
    - during the copy, enable encryption
    - select a KMS key.
- create EBS volume from this new encrypted snapshot
- detach the unencrypted volume
- attach the encrypted volume
