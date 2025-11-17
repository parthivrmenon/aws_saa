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

## Single-AZ DB Instance (1 instance)
- creates a single instance in a single AZ
- 99.5% uptime
- no redundancy

# RDS - Storage Types
* General Purpose SSD (gp2)
* General Purpose SSD (gp3)
* Provisioned IOPs (io1)
* Provisioned IOPs (io2)

# RDS - Storage Auto Scaling
increase storage dynamically
- you set a Maximum Storage Threshold
- Automatically modify storage if:
    - free storage is less than 10% of allocated storage
    - Low-Storage lasts at least 5 minutes
    - 6 hours have passd since last modification
- useful for applications with unpredictable workloads
- supports ALL RDS engines.


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

## RDS Backups
Automated backups:
- daily full backup during the backup window
- transaction logs are backed-up every 5 minutes; (ie: most recent backup would be 5 minutes ago)
- 1-35 days of retention; (set 0 to disable automated backups)

Manual DB snaphosts:
- retain backups as long as user wants
- can be used for infrequently used RDS (restore from snapshot rather than turning it off as you would still need to pay for storage even for a stoppped RDS instance)


# RDS - Database Authentication
### Password Authentication:
use database engine's `native` credentials management.

### Password and IAM Database Authentication
- supported by Aurora, MySQL, MariaDB, and PostgreSQL
- uses a short-lived (15 min) token for authentication.
- you can use `IAM users and roles` to control access to your DB
- for applications running on EC2, you can use `EC2's profile` credentials.
- traffic to/fro is encrypted using TLS.

# RDS - Enabling TLS for Microsoft SQL Server
for Microsoft SQL Server, use one of the below two options:

- Force SSL for all connections using the rds.force_ssl option. This happens transparently to the client, and the client doesn't have to do any work to use SSL.
- Encrypt specific connections — this sets up an SSL connection from a specific client computer, and you must do work on the client to encrypt connections.







