# Dynamo DB
Amazon DynamoDB is a `serverless`, NoSQL, `fully managed` `NoSQL database` with `single-digit millisecond performance at any scale.

## Features
* `Serverless`: On-Demand instant scaling with pay-as-you-go pricing 
* `NoSQL` : supports both key-value and document based data models.
* `Fully-managed` and production ready with zero operational overhead
* `Single digit millisecond` performance at any scale.

## Usecases
* Financial Services - applications with the most stringent availability requirements can make use of `global tables`
* Gaming applications - can be used for all parts of a gaming system like game state, player data, leaderboards etc and supports scale-out patterns with `scale to zero` and `no cold start` features
* Streaming applications - can use DynamoDB as metadata index for content, content management services (CMS) and near real-time sports statistics.

## Resilience
By default data is replicated across `3 Availability Zones` and provides `99.99%` availability.

### Global tables - multi-active, multi-Region replication
provides `multi-actve` , `multi-region` replication with `99.999%` availability.
Global tables provide the following benefits:
* replicate table data across AWS Regions to locate data close to your users 
* enable higher application availability with `low or zero RPO` 

### Continuous backups and point-in-time recovery
- restore table to any point in time during the last `35` days. 
- backups/recovery has no impact on performance or availability of your applicatioons. 
- do not consume provisioned resources.

### On-Demand backup and restore
- create full backups of your tables for long term retention and compliance
- backups do not impact performance and you can backup tables of any size.
- backups can be copied  across Accounts and Regions. 
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
you can create a global and local secondary index to query the table

## Service Integrations
* Serverless
    - Lambda: using Dynamo DB Streams trigger Lambdas to respond to data modifications in tables
    - AWS AppSync for creating GraphQL APIs
    - API Gateway for creating REST APIs
    - Kinesis Data streams for change data capture (CDC)

## Importing/Exporting data to S3
Supports exporting data to S3 for analytics/ML. Use either full table or incremental exports.
You can also import data from S3 into a new DynamoDB table.

## Zero ETL Migration
Supports Zero ETL integration with `Amazon Redshift` and using an `Opensearch` ingestion pipeline 
These integrations enable you to run complex analysis and search (full-text, vector) capabilitiies on your DynamoDB table.

## Caching
`DynamoDB Accelerator (DAX)` is a fully-managed, highly available caching service.
Provides upto 10x performance improvement, in microseconds even at millions of requests per second.

## Security
DynamoDB utilizes `IAM` to help you secureley access your tables.
All data is `Encrypted at rest` using `AWS Key Management Service`. You can use an AWS-owned key, AWS Managed Key  or a Customer-managed key.
Dynamo DB adhered to several compliance standards like `HIPAA`, `PCI DSS` and `GDPR` 

## Pricing
Dynamo DB charges for reading, writing and storing data along with any optional features you enable.
It has two capacity modes:
- on-demand
- provsioned
