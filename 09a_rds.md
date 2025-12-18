# Relational Database Service (RDS)
managed relational database using SQL as a query language

# RDS - Engine Options
- MySQL
- PostgresSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- IBM DB2
- Aurora for MySQL
- Aurora for PostgresSQL

# RDS - Management Type
- Amazon RDS: RDS fully manages your database including patching. 
- Custom: RDS manages your database but you have full-admin access to the underlying database. Use this if you want to customzie the OS.

# Availability and Durability modes
## Multi-AZ DB Cluster (3 instances)
- creates a primary and two replicas in separate AZs
- 99.95% uptime
- increased read capacity
- reduced write latency
- you get a read/write endpoint and reader endpoints.

## Multi-AZ DB Instance (2 instances)
- creates a primary with a standby in separate AZs.
- 99.95% uptime
- you get a read/write endpoint

**Note:** Even with a Multi-AZ setup a database `engine-level upgrade` will simultaneously upgrade both active and standby databases and will thus incur a downtime.

## Single-AZ DB Instance (1 instance)
- creates a single instance in a single AZ
- 99.5% uptime
- no redundancy

# RDS - Storage
- **Storage type**:
    * General Purpose SSD (gp2)
    * General Purpose SSD (gp3)
    * Provisioned IOPs (io1)
    * Provisioned IOPs (io2)

- **Allocated storage:**
    * General Purpose: 20GiB to 65TiB
        - IOPs is calculated based on allocates storage
    * Provisioned IOPs: 100GiB to 64TiB
        - You can explicity set IOPs 1k-256k


# RDS - Storage Auto Scaling
You can optionally select **enable storage autoscaling** which allows storage to increase dynamically.
- **Condition for scaling**: *If free storage is less than 10% of allocated storage for at least 5 minutes and 6 hours have passed since last storage modification*
- **Maximum Storage Threshold**: Autoscaling will scale storage from the "Allocated Storage" upto this limit. 
- **Best-suited for**: applications with unpredictable workloads
- **Note:** RDS Storage Autoscaling can be enabled at anytime without any downtime.


## Features
- supported engines: Postgres, MySQL, MariaDB, Oracle, MS SQL, IBM DB2, Aurora
- Provisioned by you but can be autoscaled later. (except Aurora)
- Continuous backups and restore
- Monitoring dashboard
- Read replicas
- Multi-AZ with DR
- Maintenance Windows
- Scale In/Out; Scale Up/Down
- EBS backed storage
You cannot SSH into your instances



## RDS Read Replicas 
helps you scale 'reads'
- upto 15 replicas
- within AZ, Cross AZ, Cross Region
- Replication is Async so reads are "eventually consistent"
- replicas can be promoted to their own DB????
- Applications must update connection string to leverage read replicas
Network Costs
- Cross-regions replication is charged
- Within a region, it is free

## RDS Multi AZ (Disaster Recovery)
for HA
- sync replication to Standby
- a single DNS name with automatic failover in case of loss of AZ, lost off network, instance or storage failure
- not used for scaling
Note: Read Replicas can be setup as Multi AZ for Disaster Recovery

## RDS - from Single-AZ to Multi-AZ
- Zero downtime operation
- internally
    * a snapshot is taken
    * a new DB is restored from the snapshot in a new AZ
    - sync established between two databases

## RDS Custom
Allows users full-admin access to the underlying database and OS
- configure settings
- install patches
- enable native features
- access underlying EC2 instances using SSH or SSM Session Manager
Available for Managed Oracle and MS SQL Server Database

De-activate Automation Mode to perform customization,
advised to take DB snapshots before

## RDS - Backup
**Automated backups**:
A daily full backup is taken during the backup window.Transaction logs are backed-up every 5 minutes.(RPO: 5 minutes)
- `Backup Retention Period`: 1-35 days; set 0 to disable.
- `Backup window`: UTC time range for backup. Set No Preference to disable 

**Manual DB snapshots**:
You can opt for manual DB snapshots if:
- you want to retain backups for longer periods.
- for infrequently used RDS (restore from snapshot rather than turning it off as you would still need to pay for storage even for a stopped RDS instance)


# RDS - Database Authentication
### Password Authentication:
use database engine's `native` credentials management.

### Password and IAM Database Authentication
- supported by Aurora, MySQL, MariaDB, and PostgreSQL
- uses a short-lived (15 min) token for authentication.
- you can use `IAM users and roles` to control access to your DB
- for applications running on EC2, you can use `EC2's profile` credentials.
- traffic to/fro is encrypted using TLS to protect the token.

### Exam: Enabling TLS in-transit for Microsoft SQL Server engine
for Microsoft SQL Server engine, use one of the below two options:

- Force SSL for all connections using the **rds.force_ssl** option. This happens transparently to the client, and the client doesn't have to do any work to use SSL.
- Encrypt specific connections — this sets up an SSL connection from a specific client computer, and you must do work on the client to encrypt connections.

## EXAM - RDS Monitoring
### Basic Monitoring
These are enabled by default and are DB-instance–level metrics.
    - CPU Utilization
    - Database Connections
    - Freeable Memory
    - ReadIOPS/WriteIOPs
    - ReadLatency/WriteLatency
    - FreeStorageSpace
### Enhanced Monitoring:
Enhanced Monitoring provides real-time OS metrics (from the host, not the database engine). 
Metrics are published to Cloudwatch Logs not Cloudwatch Metrics.
It is disabled by default, but can be enabled anytime.
    - RDS Child Processes: 
    - RDS Processes
    - OS Processes
    - CPU, memory, file system, and network usage at the OS level










