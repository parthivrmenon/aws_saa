# Elastic File System (EFS)
serverless, fully-elastic file storage compatible with Linux based AMIs.(supports NFSv4.1 protocol)

## File System Type
`Regional` EFS stores data across AZs within the same region. Offers `99.99%` availability.
`One Zone` EFS stores data within a single AZ. Backups can be made using AWS Backup. Offers `99.9%` availability.

**Note:** Automatic daily backups are enabled by default.

## Performance Mode
`General Purpose` for most workloads 

`Max I/O` mode is typically used for high-performance applications like Media Processing, Big Data Analytics or Genome Processing.

**Note:** This setting cannot be changed after the file system is created.

## Throughput Mode
`Bursting` to let the throughput scale with file system size.
`Provisioned` to set a fixed throughput limit.


## Storage Classes
`Standard` storage class uses `SSD` storage providing `sub-millisecond` first-byte latency

`Infrequent Access (IA)` cost-optimized storage class for infrequently accessed (a few times a quarter) data offering millisecond first-byte latency. It has `minimum billing charge` per file of `128KB` 

`Archive` cost-optimized storage class for infrequently accessed (a few times a year) or less. You cannot update througput to `Bursting` or `Provisioned` once it's in the archive storage class.
has `minimum billing charge` per file of `128KB` 
    
## EFS Access Points
are application-specific entry points that allow working on shared datasets. 


- can be shared by EC2 instances across AZs
- HA, 3x gp2 cost, pay per use
- UC: Content Management, Web Serving, Data sharing, Wordpress
Uses NFSv4.1 protocol
uses SG to control access to EFS
compatible with ONLY Linux based AMIs (not Windows)
enable ecnryption-at-rest- using KMS

 


