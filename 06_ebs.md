# Elastic Block Store (EBS)
a networked drive you can attach to your instances as a logical volume.

## Features:
* EBS Volumes persist beyond the life of an instance (controlled by "Delete on Termination" option)
* EBS Volumes can be detached and reattached to different instances

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

## Amazon Machine Image (AMI)
offers a way to customize an EC2 instance
you can add software, config, OS, monitoring etc
faster boot/config time because software is pre-packaged
AMIs are built for specific region and can be copied across regions
An EC2 instance can be launched from
- Public AMIs
- Marketplace AMI
- Your own AMI

## EC2 Instance Store
is a high performance hardware disk (no network latency)
they are ephemeral, lost if EC2 is stopped
good for bugger/cache/scratch data/temporary content
risk of data loss if underlying hardware fails
backups and replication is recommended

## EBS Volume Types
* gp2/gp3 (SSD) - General purpose SSD; balanced price v performance
* io1/io2 - Block  Express SSD; highest performance for mission critical , low latency, high throughput workloads
* st1 - Low cost HDD, for frequenctly accessed, throughput intensive workloads
* sc1 - Lowest cost HDD, for less frequently accessed workloads

EBS volumes are charecterized by Size|Throughput|IOPS
Only gp2/gp3 and io1/io2 can be used as boot volume

## General Purpose SSD (gp3/gp2)
* 1GiB - 16TiB
* gp3: 
    - baseline 3000 IOPS and throughput of 125MiB/s
    - can increase  IOPS up to 16,000 and throughput up to 1000MiB/s independently
* gp2:
    - small gp2 volumes can burst IOPS to 3000
    - size of volume and IOPS are linked IOPS, max IOPS is 16,000

## Provisioned IOPS (PIOPS) SSD
* critical business applications with sustained IOPS performance
* or apps that need more than 16,000 IOPS
* great for database workloads (storage performance & consistency)
* io1 (4Gib - 16TiB)
    - Max PIOPS 64,000 for Nitro EC2, 32000 for others
    - can increase PIOPS indepednetly from storage size
* io2 (4GiB - 64TiB)
    - sub milli latency
    - max PIOPS 256,000 with IOPS GiB ratio of 1000:1
* Supports EBS Multi-attach

## Hard Disk Drives
125GiB to 16TiB
Throughput Optimized HDD (st1)
    - Big Data, Data warehouses, Log Processing
    - Max throughoput 500 MiB/s - max IOPS 500
Cold HDD (sc1)
- for data that is infrequently accessed
- lowest cost

## EBS Multi-Attach - io1/io2 family
atach the same EBS volume to multiple EC2 in the same AZ
each instance has RW performance
Use Case:
    - HA
    - Apps must manage concurrent write ops
up to 16 EC2 instances at a time
must use fs that is cluster aware (not XFS, EXT4, etc)

## EBS Encryption
encryption at rest
encryption during transit
all snapshots encrypted
all volumes created from snapshot is envrupted

encrypt/decrypt handled transparently
has minimal impact on latency
leverages keys from KMS(AES-256)

to encrypt an unencrypted EBS volume
- create an EBS snapshot (unencrypted)
- copy the snapshot into same AZ with encryption OR create EBS with encryption enabled
- create EBS volume from this new encrypted snapshot

- 





