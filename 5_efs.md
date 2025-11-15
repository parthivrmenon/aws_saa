# Elastic File System (EFS)
is a managed Network File System(NFS)
Highly Available and Scalable but expensive (3x gp2 cost) ; Pay per use.
Only compatible with Linux based AMIs (not Windows)
Encrypted at rest using KMS
Supports POSIX permissions
serverless, fully-elastic file storage compatible with Linux based AMIs.(supports NFSv4.1 protocol)

## Availability
- EFS Standard 
    - Multi-AZ
    - good for Production
    - Offers `99.99%` availability.
- EFS One Zone 
    - Single AZ
    - good for Dev/Testing
    - Offers `99.9%` availability.

**Note:** Automatic daily backups are enabled by default.

## Throughput Mode
- `Elastic` to let the throughput scale with workload. Good for unpredictable workloads.
- `Bursting` to let the throughput scale with workload size. 
- `Provisioned` to set a fixed throughput limit. Good for predictable workloads.

## Performance Mode
- `General Purpose` for most workloads 
- `Max I/O` mode is typically used for parallelized workloads that can tolerate higher latency. Not available if you select 'elastic' throughput mode.

**Note:** This setting cannot be changed after the file system is created.



## Storage Classes
- EFS-Standard 
    - default storage class 
    - uses `SSD` storage 
    - provides `sub-millisecond` first-byte latency.
- EFS-IA 
    - for infrequently accessed (a few times a quarter) data 
    - less cost to store, but additionl cost for access.
    - offering millisecond first-byte latency. 
    - has `minimum billing charge` per file of `128KB` 
- EFS-Archive 
    - rarely access data (few times a year)
    - about 50% less cost to store, but additionl cost for access.
    - has `minimum billing charge` per file of `128KB` 

**Note:** 
* You can move data across storage tiers using lifecycle policies.
* You can use EFS One Zone-IA for upto 90% savings

## EFS Access Points
are application-specific entry points that allow working on shared datasets. 


- can be shared by EC2 instances across AZs
- HA, 3x gp2 cost, pay per use
- UC: Content Management, Web Serving, Data sharing, Wordpress
Uses NFSv4.1 protocol
uses SG to control access to EFS
compatible with ONLY Linux based AMIs (not Windows)
enable ecnryption-at-rest- using KMS

 


