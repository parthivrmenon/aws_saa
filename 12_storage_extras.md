# Storage Extras
## AWS Snowball
Highly secure, portable devices to collect and process data at the edge, and migrate data into and out of AWS (upto PBs)
- Storage Optimized
- Edge Compute Optimized

Note: Snowball cannot import to Glacier directly. You must use Amazon S3 first, in combination with an S3 lifecycle policy.

## Amazon FSx
Fully-managed high-performance filesystems on AWS backed up by 3rd party filesystems

### Deployment Options
- Scratch File System
    - temporary
    - data is not replicated
    - high burst
    - used for short-term processing, optimize costs
- Persistent File System
    - long-term storage
    - data is replicated within same AZ
    - replace failed files within minutes
    - used for long-term processing , sensitive data
### FSx for Windows File Server
- Supports SMB protocol, Win NTFS
- AD integration, ACLs, user quotas
- can be mounted on Linux EC2 instances
- supports MS DFS Namespaces (group files across multiple FS)
- Scale up to 10s of GB/s, millions of IOPS, 100s PB of data
- Storage options
    - SSD - databases, media processing, data analytics
    - HDD - home dir, CMS
- can be accessed from your on-premises infrastructure (VPN or Direct Connect)
- can be configured to be Multi-AZ
- data is backed up to S3
    - FSx for OpenZFS

### FSx for Lustre
- Lustre (Linux cluster) is a type of parallel distribution FS
- Machine Learning, High Performance Computing (HPC)
- Video Processing, Financial Modelling, Electronic Design Automation
- Scales up to 100s GB/s , millions of IOPs, sub-ms latencies
- Storage Options:
    - SSD - low latency IOPS intenstive workloads, emall and random file operations
    - HDD - throughput-intensive workloads, large and sequential file operations
- Seamless integration with S3
    - can read S3 as a file system
    - can write the output of computations back to S3
- can be used on-prem servers (VPN or Direct Connect)

### FSx for NetApp ONTAP
- compatible with NFS, SMB, iSCSI protocol
- move workloads running on ONTAP or NAS to AWS
- works on: Linux, Win, MacOS, VMware Cloud on AWS, Amazon Workspace & AppStream 2.0, EC2, ECS, EKS
- storage shrinks or grows automatically
- snapshots, replication, low-cost, compression and data de-duplication
- point-in-time instantaneous cloning (helpful for testing new workloads)

### FSx for OpenZFS
- compatible with NFS (v3, v4, v4.1, v4.2)
- migrate workloads running on ZFS to AWS
- works on: Linux, Win, MacOS, VMware Cloud on AWS, Amazon Workspaces & AppStream 2.0, EC2, ECS, EKS
- upto 1,0000,0000 IOPS with < 0.5 ms latency
- snapshots, compression and low-cost
- point-in-time instantaneous cloning (helpful for testing new workloads)

## AWS Storage Gateway
Bridge between on-premises data and cloud data
Use cases:
    - Disaster recovery
    - backup and restore
    - tiered storage
    - on-premises cache & low latency files access
### S3 File Gateway
ON-Prem apps can access S3 buckets (via NFS/SMB) through an `S3 File Gateway`
- Gateway caches most recently used data
- supports S3 Standard, S3 Standard IA, S3 One Zone IA, S3 Intelligent Tiering
- transition to S3 Glacier using a lifecyle policy 
- FIle Gateway requires Access via IAM to S3 Buckets
- SMB protocol can integrate with Active Directory for Auth
    - FSx File Gateway
    - Volume Gateway
    - Tape Gateway

### Amazon FSx File Gateway
On-prem apps can have access to Amazon FSx for Windows File Server
- gateway caches most frequently accessed data
- Win native compatibility (SMB, NTFS, Active Directory)
- useful for User file shares and home directories

### Volume Gateway
Block storage using iSCSI protocol backed by S3
- backed by EBS snapshots which can help restore on-prem volumes
- cached volumes: low latency access to recent data
- Stored Volumes: entire dataset is on-prem, scheduled backups to S3

### Taped Gateway
A Virtual Tape Library (VTL) backed by S3 and Glacier
- backup data using existing tape based processes (and iSCSI interface)
- works with leading backup software vendors

### Hardware appliance
- You can buy it on amazon.com
- set it up as File Gateway, VOlume Gateway, Tape Gateway
- has the required CPU, memory, network, SSD cache resources
- helpful for daily NFS backups in small data centers

## AWS Transfer Family
fully managed service for file transfers into and out of Amazon S3 or EFS over FTP protocol
- Supported protocols: FTP, FTPS, SFTP
- pay-per provisioned endpoint per hour + data transfers in GB
- store and manage user credentials within the service
- integrate with existing authentication systems (AD, LDAP, Okta, Cognito, custom..)
- Usage: sharing files, public datasets, CRM, ERP...

## DataSync
- Move large amounts of data
    - On-prem/other clouds -> AWS (NFS, SMB, HDFS, S3 API..) -- needs Agent
    - AWS to AWS (different storage services) -- No agent
- Can synchronize to:
    - S3
    - EFS
    - FSx (Win, Lustre, NetApp, OpenZFS)
- Replication  tasks can be scheduled hourly, daily, weekly
- File permissions and metadata are preserved (NFS, POSIX, SMB..)
- One agent task can use 10Gbps, can set a bandwidth limit...
- Alternate : AWS Snowcone (has agent pre-installed) can be used if network bandwidth is limited.


