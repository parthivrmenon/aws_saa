# Amazon Aurora
Features:
- proprietery
- supports Postgres and MySQL drivers
- cloud-optimized 
    -> 5x performance improvement over mySQL on RDS
    -> 3x performance improvements over POstgres on RDS
- storage automatically grows in increments of 10GB upto 128TB
- can have upto 15 replicas and has sub 10ms replication lag (faster than mySQL)
- native instantaneous HA
- costs 20% more than RDS, but is more efficient
- Backup & Restore; Backtrack?

## High Availability, Replication
- has one Master(RW) and can have upto 15 Replicas (R)
- supports Cross Region replication
- failover in under 30 secs
- clients can use Writer/Reader DNS endpoints
- Shared, striped storage (100s of volumes) with in-built
    - replication
    - self-healing via peer-to-peer replication
    - auto-expanding
- stores 6 copies of your data across 3 AZs
    - 4 copies out of 6 needed for writes
    - 3 copies out of 6 needed for reads

## Advanced Concepts
Replica Auto-Scaling
- auto replica scaling using CPU, Connection targets across heterogenous instances
- Reader endpoint automatically extends to include new replicas

Custom Endpoints
- allows subset of instances to be defined as a custom DNS endpoint
- when using custom endpoints, reader endpoint is usually no longer used
- eg: run analytical queries on specific (more optimized) replicas

Aurora Serverless
- auto database instantiation and scaling based on actual usage
- good for infrequent, intermittent, unpredictable workloads
- no capacity planning needed
- pay-per-second model (more cost-effective)
- clients talk to "Proxy Fleet" (AWS managed proxy layer)

Global Aurora
Aurora Cross Region Read Replicas
- useful for disaster recovery
- simple setup

## Aurora Global Database (recommended)
With the Amazon Aurora Global Database feature, you set up multiple Aurora DB clusters that span multiple AWS Regions.
It supports having one primary DB cluster in one Region, and up to 10 secondary DB clusters in different Regions.
Aurora Global Database provides fast recovery from the rare outage that might affect an entire AWS Region. Having a full copy of all your data in multiple geographic locations also enables low-latency read operations for applications that connect from widely separated locations around the world.


Aurora Machine Learning
- add ML-based predictions to your apps via SQL (no ML experience required)
- integrations with AWS ML services
    - Amazon SageMaker (use with any ML model)
    - Amazon Comprehend (for sentimental analysis)
- Usecases: fraud-detection, ads targetting, sentimental analysis, product recommendations

Babelfish
Babelfish for PostgreSQL is an open-source extension that allows PostgreSQL to understand and run T-SQL, the query language used by Microsoft SQL Server.
- allows Aurora PostgresSQL (which uses PL/pgSQL driver) to understand MSSQL clients (using T-SQL)
- required no to little code changes on the client side
- apps can be migrated to Aurora (using AWS SCT and DMS) 

## Aurora Backups
Automated backups
- 1-35 days retention (cannot be disabled)
- point-in-time recovery within that duration

Manual DB Snapshots
- retain backup as long as you want

## RDS & Aurora Restore options
- Restoring a RDS/Aurora backup or a snapshot creates a new database
- Restoring MySQL RDS database from S3
    - create a backup of on-premises database
    - store it on S3
    - restore backup file onto a new RDS instance running MySQL
- Restoring MySQL Aurora cluster from S3
    - Create a backup of on-premises database using PerconaXtraBackup
    - store it on S3
    - resotre backup onto a new Aurora cluster running MySQL

## Aurora Database Cloning
Create a new Aurora DB cluster from an existing one
- faster & more cost-efficient than snapshot & restore
- uses copy-on-write protocol
    - initially , the new cluster uses same data volume as the original cluster ( fast and efficient)
    - when updates are made to the new cluster, then additional storage is allocated and data is copied to be separated
- eg: To create a "staging" database from a "production" database without impacting production database


## RDS & Aurora Security
At-rest encryption:
- master & replicas encryption using AWS KMS - must be defined at launch time
- if the master is not encrypted, replicas cannot be encrypted
- to encrypt an un-encrypted database, snapshot the DB and restore as encrypted

In-flight encryption:
- TLS-ready by default, use the AWS TLS root certificate client-side

IAM Authentication:
- IAM roles to connect to your database (instead of username/password)

Security Groups:
- control network accesss

No SSH:
- except RDS custom

Audit Logging:
- can be enabled and sent to Cloudwatch Logs for longer retention


## RDS Proxy
managed database proxy for RDS
- allow apps to pool and share DB connection
- reduces stress on resources (CPU, RAM) and minimize open-connections and timeouts
- serverless, autoscaling, HA (multi-AZ)
- reduce failover time by 66%
- supports RDS(MySQL, PostgresSQL, MAriaDB, MSSQL ) and Aurora (mySQL, PostgresSQL)
- no code changes required for most apps (simply change endpoint it connects to)
- enforce IAM authentication for DB and securely store creds in AWS Secrets Manager
- RDS Proxy is never publically accessible (must be access from VPC)


 


