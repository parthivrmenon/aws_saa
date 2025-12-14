# Disaster Recovery and Migrations

# AWS Backup
- fully managed service
- centrally manage and automate backups across AWS services.
- supports 
    - **Cross-Region,Cross-Account** backups
    - **On-Demand, Scheduled Backups**
    - **PITR**
    - Tag-based backups
- You can create backup policies known as Backup Plans:
    - frequency
    - retention
    - backup window
    - transition to cold storage
- All backups are stored in an internal S3 bucket
## AWS Backup Vault Lock
- enfore WORM (Write Once Read Many) on backups
- protects against:
    - inadverent or malicious deletion of backups
    - updates that alter/shorten retention
    - Note: Even root accounts cannot delete backups when lock is enabled.
# Database Migration Service (DMS)
Allows you to quickly and securely migrate databases to AWS without downtime.
## Features:
- source database doesn't need to be stopped
- supports 
    - both Homogeneous and Heterogeneous migrations
    - continuous data replication using CDC
- you must create an EC2 instance to run DMS (replication tasks)

## Schema Conversion Tool (SCT)
- used for Heterogeneous migrations
- converts the schema of the source database to the target database

## DMS - Continuous Data Replication
- install a server on-prem with AWS SCT
- convert the schema and create the target database on AWS
- setup up a **Full Load + CDC** replication task using DMS on AWS

## Exam: RDS to Aurora Migration
**Option 1**: Take a `DB snapshot` from RDS and restore it in Aurora

**Option 2**: Create an `Aurora Read Replica` from RDS and once replication lag is zero, promote it as its own cluster.

## Exam: External MySQL to Aurora Migration
**Option 1**: Use `Percona Xtrabackup` to take a backup of the MySQL database into S3 and restore it in Aurora MySQL.


**Option 2**: Use `mysqldump` to take a backup of the MySQL database and restore it in Aurora MySQL

**Note**: Both Option 1 and 2 is best-suited for small databases/one-time migrations or when you can accept some downtime.

**Option 3**: Use `DMS` to migrate the data if both the source and target databases are up and running and you need continuous data replication.
 
## Exam: External Postgres to Aurora Postgres Migration
**Option 1**: Use `pg_dump` to take a backup of the Postgres database into S3 and use `aws_s3` Aurora externsion to restore it in Aurora Postgres.
Note: This is suitable for small databases/one-time migrations or when you can accept some downtime.

**Option 2**: Use `DMS` to migrate the data if both the source and target databases are up and running and you need continuous data replication.


# On-Premise strategies with AWS
- you can download Amazon Linux 2 AMI as a VM (.iso format) and run it on VMware, KVM, VirtualBox, Microsoft Hyper-V etc
- VM Import/Export service to import/export the VM into AWS as an EC2 instance.
- AWS Application Discovery Service (ADS) to discover and inventory your on-premises applications and dependencies. Track with AWS Migrations Hub.
- AWS Database Migration Service (DMS) to migrate your on-premises databases to AWS.
- AWS Application Migation Service (MGN) to incrementally migrate your on-premises applications to AWS.

# AWS Application Discovery Service (ADS)
- plan migration by gathering info about on-prem datacenters
- server utilization data and depdency mapping
- AWS Agentless Discovery Connector:
    - VM inventory, configuration and perfomance history like cpu, memory and disk usage
- AWS Application Discovery Agent:
  - system configuration, performance, runnin gprocesses, network connections etc
- all results can be viewed in **AWS Migration Hub**

# Application Migration Service (MGN)
- Lift-and-Shift (rehosting) 
- converts your physical, virtual and cloud-based servers to run on AWS.
- the AWS replication server is a virtual machine that runs on-premises and replicates your servers to AWS until you are ready to cutover.
- minimal downtime and reduced cost (no need to hire engineers)


# Transferring Large Amounts of Data to AWS
Example: We need to transfer 200TB of data to AWS
- over internet/Site-to-Site VPN via a 100Mbps connection - approx 185 days
- over Direct Connect 1Gbps
    - 1 month to get DX established
    - 18.5 days to transfer 200TB 
- over AWS Snowball
    - 1 week for end-to-end transfer
- For on-going replication/transfer using Site-to-Site VPN or Direct Connect, using DMS  or DataSync 

# VMware Cloud on AWS
- for customers using VMware vCenter to manage their on-premises virtual machines
- can extend vCenter to AWS