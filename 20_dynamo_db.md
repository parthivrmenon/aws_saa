# Dynamo DB
Amazon DynamoDB is a fully managed NOSQL serverless database service which has single-digit millisecond performance at any scale.

## Usecases
* Financial Services - applications with the most stringent availability requirements can make use of `global tables`
* Gaming applications - can be used for all parts of a gaming system like game state, player data, leaderboards etc and supports scale-out patterns with `scale to zero` and `no cold start` features
* Streaming applications - can use DynamoDB as metadata index for content, content management services (CMS) and near real-time sports statistics.

## Resilience
By default data is replicated across `3 Availability Zones` and provides `99.99%` availability.


## Table Classes:
- `DynamoDB Standard`: 
    - for frequently accessed data
    - charged based on throughput
- `DynamoDB Standard-IA`:
    - for infrequently-accessed data
    - charged based on storage

## Capacity Modes:
Dynamo DB charges for reading, writing and storing data along with any optional features you enable.
It has two capacity modes:
- `OnDemand`: DynamoDB scales to meet read/write throughput. You pay as per usage.
- `Provisioned`: 
    - Auto-Scaling ON:
        - Set Min/Max Read-Capacity Units and Write-Capacity Units
        - Set target utilization (e.g., 70%)

        - Auto-scaling adjusts capacity based on traffic patterns to maintain performance and cost efficiency.
    - Auto-scaling OFF:
        - You set Provisioned Read/Write Capacity Units manually

*Note:* Auto-scaling is selected by default when creating a DynamoDB table via the console, but if you are creating the table via CLI/Terraform you have to enable it explicitly.

*Note:* `Warm throughput` is DynamoDB’s instantly available read/write capacity—based on recent traffic or manual pre-warming (additional charge) that lets tables absorb sudden spikes without waiting for scaling.

## Global tables
provides `multi-actve` , `multi-region` replication with `99.999%` availability.
Global tables provide the following benefits:
* replicate table data across AWS Regions to locate data close to your users. Well-suited for global apps.
* enable higher application availability with `low or zero RPO`. Well suited for Disaster recovery
* Note: Strong consistency only in local region. Uses 'last writer wins' for conflict resolution.

## Backups - Point-In-Time-Recovery (PITR)
- restore table to any point in time during the last `35` days. 
- backups/recovery has no impact on performance or availability of your applicatioons. 
- do not consume provisioned resources.
- *Note:* PITR cannot be done across region/account.

## Backups - On-Demand
- create full backups of your tables for long term retention and compliance
- backups do not impact performance and you can backup tables of any size.
- backups can be copied  across Accounts and Regions using AWS Backups.
- older backups can be transitioned to cold storage for cost-optimization.


## DynamoDB Trasactions
designed to support  mission-critical workloads 
has server-side support for `ACID` transactions.

## Change Data Capture 
* supports item-level CDC records in near real-time.
* It offers two streaming models for CDC:
    * DynamoDB Streams
    * Kinesis Data Streams for Dynamo DB

## Secondary Indexes
- if you want to query a table using a non primary (Partition Key + Optional SortKey) index, you can define a secondary indxex.
- Types:
    - Local Secondary Index (LSI): 
        - Same Partition Key , but different Sort Key
        - defined during table creation
        - max 5 LSI's per table
    - Global Secondary Index (GSI):
        - can have different Partition Key and Sort Key
        - can be added anytime
- You can create a secondary index to optimize queries around that index. (if primar)
you can create a global and local secondary index to query the table

## Choosing the right partition key
- use `high-cardinality` attributes: choose fields that have many distinct values so that they distribute data evenly across partitions
- use `composite` keys: combine attributes to fit your access pattern

## Service Integrations 
### Serverless
- APIGateway as the REST API Frontend + DynamoDB as backend
- AppSync as GraphQL API + DynamoDB as backend
- using `DynamoDB Streams`
  * Trigger a Lambda function when entries are modified/created.
  * Change Data Capture using Kinesis Data Streams

### S3
Supports exporting data to S3 for analytics/ML. Use either full table or incremental exports.
You can also import data from S3 into a new DynamoDB table.

## Zero ETL Migration
Supports Zero ETL integration with `Amazon Redshift` and using an `Opensearch` ingestion pipeline 
These integrations enable you to run complex analysis and search (full-text, vector) capabilitiies on your DynamoDB table.

### KCL Apps 
- you can enable DynamoDB Kinesis Adapter which lets KCL apps interact with it by transforming DynamoDB shard structures and records into Kinesis compatible format.
- it enables reusing KCL based apps.

## Caching
`DynamoDB Accelerator (DAX)` is a fully-managed, highly available caching service.
Provides upto 10x performance improvement, in microseconds even at millions of requests per second.

## Security
DynamoDB utilizes `IAM` to help you secureley access your tables.
All data is `Encrypted at rest` using `AWS Key Management Service`. You can use an AWS-owned key, AWS Managed Key  or a Customer-managed key.
Dynamo DB adhered to several compliance standards like `HIPAA`, `PCI DSS` and `GDPR` 


