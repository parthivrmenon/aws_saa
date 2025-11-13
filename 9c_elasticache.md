# Elasticache
managed Redis or Memcached
Usecases:
- reduce load on database for read-intensive workloads
- helps make your apps stateless (shared session state)
Note: requires changes to application code

## Caching strategies and caching invalidation

## Elasticache - Redis vs Memcached
Redis:
- Multi-AZ with automatic failover
- support scaling and HA via read replicas
- data durability using AOF persistence
- backups and restore supported
- supports Sets & Sorted Sets

Memcached:
- supports (write) scaling via partitioning of data (sharding)
- no HA or replication
- non persistent
- backup and restore (only supported in Serverless)
- multi-threaded architecture

## Elasticache - Cache Security
Redis
- supports IAM Authentication (but onl)
- IAM policies are only used for AWS API-level security
- Redus AUTH
    - set a password/token 
    - this is an extra level of security (on top of SGs)
    supports SSL in-flight encryption

Memcached
- supports SASL based authentication

Elasticache - Patterns
- Lazy-loading
    If cache-miss:
        - read from database
        - write to cache

- Write Through
    Writes data to both cache and database

- Session Store
    - store temporary session data in a cache
    - invalidate using TTL

UseCase (Elasticache REDIS): Leaderboard
- use REDIS Sorted Sets
- guarantees both uniqueness and element ordering
- each time a new element is added, it's ranked in real time then added in correct order

## List of Ports to be familiar with
FTP -21
SSH/SFTP -22
HTTP - 80
HTTPS - 443
PostgresSQL/Aurora - 5432
MySQL/MariaDB/Aurora
 - 3306
Oracle RDS - 1521
MSSQL - 1433

    
 
