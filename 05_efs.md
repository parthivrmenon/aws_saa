# Elastic File System (EFS)
is a managed Network File System(NFS) compatible with Linux AMIs and supports POSIX permissions.
It is Serverless, highly available, and scalable but expensive (3x gp2 cost); pay per use.


## EFS vs EBS
| Feature | EFS | EBS |
|---------|-----|-----|
|Type|Managed NFS compatible with Linux AMIs|Block Storage|
|Usecases|Shared storage, web servers, CMS, container workloads, home directories|Databases (RDS-like), boot volumes, application disks, low-latency transactional workloads|
|Accessibility|Shared across multiple EC2 instances|Attached to a single EC2 instance at any time|
|Availability|Highly available across AZs|Single AZ (with Snapshots for DR)|
|Cost|Expensive (3x gp2); pay-per-use|Cheaper; pay for provisioned|
|Scalability|Serverless, fully elastic|Fixed size, needs manual scaling|


## Availability Modes
|EFS Standard|EFS One Zone|
|------------|------------|
|Multi-AZ    |Single AZ   |
|99.99% Availability|99.9% Availability|
|Used for production workloads|Used for development workloads|
|More expensive|Less expensive|

**Note:** Automatic daily backups are enabled by default.

## Throughput Mode
|Mode|Description|Use Case|
|----|-----------|--------|
|Elastic|Throughput scales elastically as per demand|Unpredictable workloads|
|Bursting|Throughput scales based on storage size of your filesystem|Variable workloads|
|Provisioned|Set a fixed throughput limit|Predictable workloads|

## Performance Mode

|Mode|Description|Use Case|
|----|-----------|--------|
|General Purpose|Optimized for quick response times|Most workloads|
|Max I/O|Optimized for high-throughput, parallel workloads that can tolerate higher latency|High-performance computing|


**Notes:** 
- You can't change the performance mode after creation.
- Max I/O mode is not available with 'elastic' throughput mode.



## Storage Classes
|Feature|EFS-Standard|EFS-IA|EFS-Archive|
|-------|------------|------|-----------|
|Default|Yes|No|No|
|Used for|General purpose|Infrequent access (few times a quarter)|Rare access (few times a year)|
|Storage Costs|Higher|Medium (but has access fees)|Lower (but has access fees)|
|Access latency|Sub-millisecond|Millisecond|Seconds|
|Minimum billing|-|128KB per file|128KB per file|

**Note:** 
* You can move data across storage tiers using lifecycle policies.
* You can use EFS One Zone-IA for up to 90% savings

## EFS Access Points
are `application-specific` entry points into EFS.

### Benefits
- Simplified Access Control: each application get's its own UID, GID and posix permissions
- Path isolation: restrict applications to specific paths within the EFS

Note: You can have multiple Access Points per EFS


 


