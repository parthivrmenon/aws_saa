# Elastic Block Store (EBS)

A network-attached block storage service that can be mounted on EC2 instances as a logical volume.

## Key Features

- **Persistence**: EBS volumes persist independently from the EC2 instance lifecycle (controlled by "Delete on Termination" setting)
- **Portability**: Can be detached and reattached to different instances within the same Availability Zone
- **Live Configuration**: Supports dynamic changes without service interruption:
  - Volume size increases
  - Throughput adjustments
  - Volume type modifications
  - IOPS provisioning changes

> **Important**: The root EBS volume is automatically deleted when its instance is terminated, unless `Delete on Termination` is explicitly disabled.


## Limitations

- **Single Instance Attachment**: Can only be mounted to one EC2 instance at a time (except for io1/io2 with Multi-Attach)
- **AZ Bound**: Tied to a specific Availability Zone (use snapshots to move across AZs)
- **Pre-provisioned Capacity**: Requires upfront definition of capacity and performance characteristics
- **Billing Model**: Charged for provisioned capacity regardless of actual usage
- **Performance**: Network-attached storage (not direct-attached like instance store)

## EBS Snapshots

Point-in-time backups of EBS volumes with several management features:

### Snapshot Features
- **Online Snapshots**: Can be created while volume is in use (recommended to detach for consistency)
- **Cross-Region/Account**: Snapshots can be copied across regions or shared with other AWS accounts

### Snapshot Management Options

#### EBS Snapshot Archive
- **Cost Savings**: 75% cheaper than standard snapshots
- **Restore Time**: 24-72 hours to restore from archive
- **Use Case**: Long-term, infrequently accessed backups

#### Recycle Bin
- **Purpose**: Prevent accidental snapshot deletion
- **Retention**: Configurable from 1 day to 1 year
- **Automation**: Rules can be set for automatic cleanup

#### Fast Snapshot Restore (FSR)
- **Benefit**: Eliminates initialization penalty on first access
- **Consideration**: Significantly more expensive than standard snapshots
- **Use Case**: Critical workloads requiring immediate full performance

### Data Lifecycle Manager (DLM)
Automate snapshot management with policies that:
- Create snapshots based on tags
- Schedule regular backups
- Enforce retention policies
- Enable cross-region disaster recovery
- Automate cross-account sharing

## Amazon Machine Image (AMI)

A template containing the software configuration (operating system, applications, settings) required to launch EC2 instances.

### Key Benefits
- **Faster Deployment**: Pre-configured software reduces launch time
- **Consistency**: Ensures identical environments across deployments
- **Region-Specific**: AMIs are region-specific but can be copied across regions

### AMI Sources
1. **Public AMIs**: Provided by AWS and the community
2. **AWS Marketplace**: Verified, pre-configured software solutions
3. **Custom AMIs**: Created from your own instances or snapshots

> **Automation Tip**: Use Data Lifecycle Manager to automate AMI creation, copying, and cleanup based on defined policies.

## EC2 Instance Store

High-performance, temporary block storage directly attached to the host computer.

### Characteristics
- **Performance**: Extremely low latency (direct-attached storage)
- **Persistence**: Ephemeral storage - data is lost when instance stops/terminates
- **Use Cases**:
  - Temporary storage needs
  - Buffer/cache/scratch data
  - Content that can be recreated

### Important Considerations
- **No Persistence**: Data doesn't survive instance stop/terminate
- **No Backup**: Not included in EBS snapshots
- **High Performance**: Ideal for I/O-intensive workloads
- **Recommendation**: Implement application-level data replication for critical data

## EBS Volume Types

| Type | Name | Best For | Size Range | Performance Characteristics |
|------|------|----------|------------|-----------------------------|
| **gp3** | General Purpose SSD v3 | Boot volumes, development, test | 1 GiB - 64 TiB | Baseline 3,000 IOPS, up to 16,000 IOPS (additional cost) |
| **gp2** | General Purpose SSD v2 | Boot volumes, development, test | 1 GiB - 16 TiB | 3 IOPS/GiB, burst to 3,000 IOPS |
| **io2** | Provisioned IOPS SSD v2 | Mission-critical, high-performance DBs | 4 GiB - 16 TiB | Up to 64,000 IOPS (50:1 ratio) |
| **io1** | Provisioned IOPS SSD v1 | I/O-intensive DBs | 4 GiB - 16 TiB | Up to 64,000 IOPS (50:1 ratio) |
| **st1** | Throughput Optimized HDD | Big data, data warehouses | 125 GiB - 16 TiB | 40 MB/s per TiB |
| **sc1** | Cold HDD | Infrequently accessed data | 125 GiB - 16 TiB | 12 MB/s per TiB |

### Key Points
- **Boot Volumes**: Only gp2, gp3, io1, and io2 can be used as boot volumes
- **io2 Block Express**: 
  - Higher performance tier
  - 500:1 IOPS to GiB ratio
  - Up to 256,000 IOPS
  - Sub-millisecond latency
- **SR-IOV**: Enables higher I/O performance through direct hardware access


## EBS Multi-Attach (io1/io2 Family)

### Overview
Attach a single EBS volume to multiple EC2 instances within the same Availability Zone with read/write access.

### Key Features
- **High Availability**: Share data across multiple instances
- **Concurrent Access**: Multiple instances can read/write simultaneously
- **Scale**: Supports up to 16 EC2 instances per volume

### Requirements
- **Volume Types**: Only io1 and io2 support multi-attach
- **File System**: Must use a cluster-aware file system (e.g., GFS2, OCFS2)
- **AZ Restriction**: All instances must be in the same Availability Zone

### Use Cases
- High availability applications
- Applications requiring shared storage with concurrent access
- Workloads that need to maintain data consistency across instances

> **Important**: Standard file systems like XFS and EXT4 are not cluster-aware and should not be used with multi-attach volumes.

## EBS Encryption

### Encryption at Rest

#### Key Management
- **Encryption Method**: AWS Key Management Service (KMS)
- **Key Options**:
  - **AWS Managed Key (Default)**: `aws/ebs` (no additional cost)
  - **Customer Managed Key (CMK)**: Greater control over key rotation and policies

#### Configuration
- **Default Encryption**: Enable "Always encrypt new EBS volumes" in EC2 settings
- **Encryption Scope**:
  - All new volumes and snapshots
  - All data moving between the volume and instance
  - All snapshots created from the volume
  - All volumes created from those snapshots

> **Note**: Enabling default encryption only affects new volumes, not existing ones.

## Encrypting an Unencrypted EBS Volume

### Step-by-Step Process

1. **Prepare the Instance**
   - Stop the EC2 instance (recommended for data consistency)
   - Note: Instance stop is not mandatory but ensures data integrity

2. **Create a Snapshot**
   - Take a snapshot of the unencrypted EBS volume
   - This initial snapshot will remain unencrypted

3. **Create Encrypted Copy**
   - Copy the snapshot
   - During the copy process:
     - Enable encryption
     - Select KMS key (default or custom)

4. **Create New Volume** (if needed)
   - Create a new volume from the encrypted snapshot
   - Ensure it's in the same AZ as your instance

5. **Attach and Verify**
   - Attach the new encrypted volume to your instance
   - Verify data integrity and application functionality

> **Exam Tip**: This process is non-destructive - your original unencrypted volume remains unchanged until you're ready to replace it.
    - select a KMS key.
- create EBS volume from this new encrypted snapshot
- detach the unencrypted volume
- attach the encrypted volume
