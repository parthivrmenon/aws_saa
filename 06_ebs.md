# Elastic Block Store (EBS)
a network-attached drive you can mount on to your instances as a logical volume.

## Features:
* EBS Volumes persist beyond the life of an instance (controlled by "Delete on Termination" option)
* EBS Volumes can be detached and reattached to different instances within the same AZ.
* EBS Volumes support several live configuration changes without any downtime on the service (EC2)
    - increasing the volume
    - throughput changes
    - volume type changes

Note: By default, when an instance is terminated, the root EBS volume is deleted unless "Delete on Termination" is disabled.


## Limitations:
* can only be mounted to one instance at a time; 
* bound to an AZ; you can move a volume across AZs using snapshotting
* define capacity & IOPS in advance 

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
* **Data Lifecycle Manager** can be used to create EBS Snapshot management policies which:
    - schedule automatic EBS snapshots
    - delete snapshots after the retention period

## Amazon Machine Image (AMI)
offers a way to customize an EC2 instance
you can add software, config, OS, monitoring etc
faster boot/config time because software is pre-packaged
AMIs are built for specific region and can be copied across regions
An EC2 instance can be launched from
- Public AMIs
- Marketplace AMI
- Your own AMI
- **Data Lifecycle Manager** policies can be used to automate AMI creation and cleanup.

## EC2 Instance Store
is a high performance hardware disk (no network latency)
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

### Encryption during transit
all snapshots encrypted
all volumes created from snapshot is encrypted

encrypt/decrypt handled transparently
has minimal impact on latency
leverages keys from KMS(AES-256)

to encrypt an unencrypted EBS volume
- create an EBS snapshot (unencrypted)
- copy the snapshot into same AZ with encryption OR create EBS with encryption enabled
- create EBS volume from this new encrypted snapshot

- 





