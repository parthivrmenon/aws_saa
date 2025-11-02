# Relational Database Service (RDS)
managed relational database using SQL as a query language
**Features**:
- supports Postgres, MySQL, MariaDB, Oracle, MS SQL, IBM DB2, Aurora
- Automated provisioning, OS Patching
- Continuous backups and restore
- Monitoring dashboard
- Read replicas
- Multi-AZ with DR
- Maintenance Windows
- Scale In/Out; Scale Up/Down
- EBS backed storage
You cannot SSH into your instances

## RDS - Storage Auto Scaling
increase storage dynamically
- you set a Maximum Storage Threshold
- Automatically modify storage if:
    - free storage is less than 10% of allocated storage
    - Low-Storage lasts at least 5 minutes
    - 6 hours have passd since last modification
- useful for applications with unpredictable workloads
- supports ALL RDS engines

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




