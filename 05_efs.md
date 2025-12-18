# Elastic File System (EFS)

A managed Network File System (NFS) compatible with Linux AMIs that supports POSIX permissions. It is serverless, highly available, and scalable but more expensive (3x gp2 cost) with pay-per-use pricing.


## EFS vs EBS

| Feature | EFS | EBS |
|---------|-----|-----|
| **Type** | Managed NFS compatible with Linux AMIs | Block Storage |
| **Use Cases** | Shared storage, web servers, CMS, container workloads, home directories | Databases (RDS-like), boot volumes, application disks, low-latency transactional workloads |
| **Accessibility** | Shared across multiple EC2 instances | Attached to a single EC2 instance at any time |
| **Availability** | Highly available across AZs | Single AZ (with Snapshots for DR) |
| **Cost** | Expensive (3x gp2); pay-per-use | Cheaper; pay for provisioned |
| **Scalability** | Serverless, fully elastic | Fixed size, needs manual scaling |


## Availability Modes

| Feature | EFS Standard | EFS One Zone |
|---------|--------------|--------------|
| **AZs** | Multi-AZ | Single AZ |
| **Availability** | 99.99% | 99.9% |
| **Use Case** | Production workloads | Development/Test workloads |
| **Cost** | More expensive | Less expensive |

> **Note:** Automatic daily backups are enabled by default for both EFS Standard and EFS One Zone.

## Throughput Modes

| Mode | Description | Use Case |
|------|-------------|-----------|
| **Elastic** | Throughput scales elastically based on demand | Unpredictable workloads |
| **Bursting** | Throughput scales based on storage size (1MB/s per 1GB of storage) | Variable workloads |
| **Provisioned** | Set a fixed throughput limit independent of storage size | Predictable workloads with consistent performance needs |

## Performance Modes

| Mode | Description | Use Case |
|------|-------------|-----------|
| **General Purpose** | Optimized for quick response times and lower latency | Most workloads, including web servers and content management systems |
| **Max I/O** | Optimized for high-throughput, parallel workloads with higher latency tolerance | Big data analytics, media processing, high-performance computing |


> **Important Notes:**
> - Performance mode cannot be changed after the file system is created
> - Max I/O mode is not compatible with 'elastic' throughput mode
> - General Purpose mode is suitable for most use cases



## Storage Classes

| Feature | EFS Standard | EFS-IA (Infrequent Access) | EFS-Archive |
|---------|--------------|---------------------------|-------------|
| **Default** | Yes | No | No |
| **Use Case** | General purpose, frequently accessed files | Infrequently accessed files (few times per quarter) | Rarely accessed files (few times per year) |
| **Storage Cost** | Higher | 92% lower than Standard | 50% lower than EFS-IA |
| **Access Cost** | None | Per-GB data access fee | Per-GB data access fee |
| **Access Latency** | Sub-millisecond | Milliseconds | Seconds |
| **Minimum Billing** | - | 128KB per file | 128KB per file |


> **Key Points:**
> - Use lifecycle policies to automatically move files between storage classes based on access patterns
> - EFS One Zone-IA can provide up to 90% cost savings compared to EFS Standard
> - Accessing EFS-IA or Archive incurs additional request and data retrieval costs

## EFS Lifecycle Management

Automatically transition files between EFS storage classes based on access patterns:

1. **Standard → IA**
   - After 14–90 days of no access (configurable)
   - Minimum file age: 30 days

2. **IA → Archive**
   - After an additional 90 days of no access in IA
   - Fixed duration, not configurable

3. **Access Promotions**
   - Accessing a file in IA or Archive moves it back to Standard
   - Access includes read, write, or attribute changes

> **Exam Tip:** Lifecycle policies only move files to more cost-effective storage classes; they never move files to more expensive classes automatically.

## EFS Access Points

Application-specific entry points into EFS that simplify managing application access to shared datasets.

### Key Benefits

- **Simplified Access Control**
  - Each application gets its own UID, GID, and POSIX permissions
  - Enforces consistent permissions for all file system users

- **Path Isolation**
  - Restrict applications to specific directories within the EFS
  - Each access point can have its own root directory and permissions

- **Operational Simplicity**
  - Multiple access points per EFS file system
  - No need to modify application code when changing access patterns

> **Note:** You can create up to 120 access points per EFS file system by default (soft limit, can be increased).


 


