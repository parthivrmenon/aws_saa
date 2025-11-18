# Storage Extras
## AWS Snowball
Highly secure, portable devices to collect and process data at the edge, and migrate data into and out of AWS 
- can deal with Petabytes of data
- Storage Optimized
- Edge Compute Optimized

**Note:** Snowball cannot import to Glacier directly. You must use Amazon S3 first, in combination with an S3 lifecycle policy.

## Amazon FSx
Launch 3rd party high-performance filesystems on AWS

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
AWS Storage Gateway is a hybrid cloud storage service that connects on-premises environments with Amazon Web Services (AWS) cloud storage. It provides low-latency access to frequently used data by caching it locally while securely and durably storing the data in the AWS cloud. This allows on-premises applications to access cloud storage using standard protocols like iSCSI, NFS, and SMB without needing to rewrite applications.  
### Key Features
- Hybrid access: It acts as a bridge between your local data center and AWS cloud storage. 
- Standard protocols: Uses common storage protocols (iSCSI, NFS, SMB) to connect to your existing applications and Windows workloads seamlessly. 
- Local caching: Caches frequently accessed data on-premises for low-latency performance for your applications. 
- Efficient data transfer: Optimizes data transfers by only sending changed data and compressing data. 
- Security and compliance: Helps meet security and compliance needs through features like encryption and audit logging. 
- Deployment: Can be deployed as a virtual machine (VM) in a virtualized environment or as a dedicated hardware appliance. 
### Types of gateways
There are four main types of gateways, each addressing a different use case: 
- File Gateway: Provides file-based access to cloud storage via SMB and NFS protocols, suitable for applications requiring a file interface, such as some Microsoft SharePoint or SQL Server deployments. 
- Volume Gateway: Provides block storage (iSCSI) volumes that can be used for applications like databases that require block storage interfaces. 
- Tape Gateway: Offers a virtual tape library (VTL) for backup and archiving workloads, allowing you to replace physical tape with cloud storage for cost savings and durability. 
- FSx File Gateway: Provides access to in-cloud Amazon FSx for Windows File Server shares from on-premises locations. 

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


