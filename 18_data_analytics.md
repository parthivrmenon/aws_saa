# Data & Analytics

# Amazon Athena

Athena is a serverless `interactive query service` that allows you to query data in S3 using standard SQL (built on top of Presto/Trino)

You are charged $5 per TB of data scanned.

Athena is commonly used with QuickSight for data analysis and visualization.

## Performance considerations
* use Columnar data formats (Parquet, ORC) for better performance (You can use Glue to convert data to columnar format)
* compress data to reduce storage and improve query performance (Gzip, Snappy)
* partition datasets in S3 using key prefixes to reduce the amount of data scanned
* use larger (>128MB) files to minimize overhead.

## Amazon Athena Federated Query
allows you to run SQL queries across data in stored in both relational and non-relational data sources (AWS or on-prem).

uses Data Source connectors that run on AWS Lambda to run federated queries on Cloudwatch, RDS, DynamoBD etc.


# Amazon Redshift
- OLAP (Online Analytical Processing) Data Warehouse service based on PostgreSQL.
- Offers 10x better performance than other data warehouses and supports Petabytes of data.
- Stores data as columns and supports parallel queries.
- Supports two modes: 
    * Provisioned
    * Serverless
- Redshift has its own SQL interface for performing queries but also supports direct integration with Amazon QuickSight.

### Redshift - Clustering
- has a leader node for query planning and results aggregation
- has compute nodes for data processing

###  Redshift - Snapshots and DR
- Redshift has multi-AZ for some clusters
- Snapshots are point-in-time backups of the cluster stored in S3.
- Snapshots are incremental and only store the data that has changed since the last snapshot.
- You can restore a snapshot to a new cluster or to the same cluster. You can also restore a snapshot to a different region.

## Redshift - Data Ingestion
- manual: load data into an S3 bucket and COPY it into Redshift
- Amazon Kinesis Data Firehose: loads data into an S3 bucket and then COPY it into Redshift.
- Enhanced VPC Routing: route data from S3 to Redshift over a private link.
- JDBC driver: write data from an EC2 instance to Redshift. It's always better to write the data in batches.

### Redshift Spectrum
allows you to query data in S3 without first loading it.

Your query is submitted to thousands of Spectrum nodes which execute it directly on the data stored in S3.

# Amazon OpenSearch
is a fully managed service for fast and secure search of data at scale and is a successor to Amazon Elasticsearch.

supports both `provisioned` and `serverless` modes.

supports a native (elastic search) queries but has a plugin which allows you to use SQL queries as well.

can ingest from Kinesis Data Streams, AWS IoT, Cloudwatch Logs etc.

Security is provided by AWS Cognito, & IAM. Encryption is provided by AWS KMS.

Comes with OpenSearch Dashboards for visualization.

# Amazon Elastic Map Reduce (Amamazon EMR)
helps you create Hadoop clusters consisting of hundreds of EC2 instances.

EMR comes bundled with Apache Spark, HBase, Presto , Flink etc.

supports auto-scaling and spot instances.

### Amazong EMR Node Types and purchasing
`master` node manages the cluster and the health of all the nodes. It is long-running

`core` nodes run tasks and store data and are also long-running.

`task` nodes run short-lived tasks (ideal for spot instances)

Purchasing Options:
- On-demand: reliable, predictable and never terminated.
- Reserved: minimum 1 year commitment but huge cost savings. EMR will automatically use them if available.
- Spot instances: cheaper but can be terminated, the are ideal for task nodes.

Can be a long-running cluster or a transient cluster.

# Amazon Quicksight
is a serverless, machine-learning powered Business Intelligence service.
You can create interactive dashboards that are fast, scalable and embeddable with per-session pricing.

can integrate with:
- many AWS data sources like RDS, Aurora, Athena, Redshift, S3 etc
- 3rd party data sources like Salesforce, JIRA etc.
- 3rd party databases like teradata or onprem databases using JDBC.
- import data in xlsx, csv, json, .tsv, elf, clf etc. (and use SPICE engine for in-memory computation)

Supports in-memory computation using SPICE engine for data that can be loaded into Quicksight.

Enterprise Edition supportds Column-Level Security (CLS)

## Quicksight - Authentication
You can share Dashboards or Analysis with specific users or groups.
Define users (in Standard version) and Groups (in Enterprise version) that are internal to Quicksight.



# AWS Glue
is a managed ETL service used to prepare data for analytics, machine learning, and application development.

### Use Cases
* Load data from S3 or RDS into a Data Warehouse like Redshift.
* Can take data in  CSV format in an S3 bucket and convert it into Parquet format and can then be analyzed by AWS Athena

## Glue Data Catalog
`Glue Crawler` can connect to various sources like S3, RDS, DynamoDB, JDBC, etc. and create a metadata catalog.
It is used by Athena, Redshift Spectrum and EMR

## Other services
- `Glue Job Bookmark` to prevent re-processing of data
- `Glue DataBrew` no-code data cleaning interface using pre-built transformations.
- `Glue Studio`: new GUI to create, run and monitor ETL Jobs in Glue
- `Glue Streaming ETL` (built on top of Apache Spark Structured Streaming) compatible with Kinesis Data Streaming, Kafka, MSK (managed Kafka)


## AWS Data Lake Formation
is a fully managed service that helps you create Datalakes (stored on S3) in a matter of days.

* Discover, cleanse, transform and ingest data into your Data Lake
* Automates complex steps (collecting, cleansing, moving, cataloging data) and de-duplicates data using ML transforms.
* supports both structured and unstructured data
* has out-of-the-box blueprints for S3, RDS, Relational & No-SQL DBs.
* `Centralized Fine Grained Access Control` for Apps at both `row` and `column` level. [Important!]


AWS Data Lake Formation integrates AWS Services like Athena, Redshift, EMR and 3rd-party services like Apache Spark etc.


## Kinesis Data Analytics (Amazon Managed Service for Apache Flink)

- Flink (Java, Scala, SQL) is a framework for processing `Data Streams`.
- You can run any Flink Application on AWS using Amazon Managed Service for Apache Flink which provides:
    - `Fully Managed` Flink Clusters with parallel-computing
    - `Auto Scaling`
    - `Backups` - via Snapshots and Checkpoints
    - `Monitoring` via CloudWatch

**Note:**: Flink can read from Kinesis Data Streams but not Amazon Data Firehose

## Amazon MSK (Managed Service for Kafka)

- Kafka is a framework for processing `Data Streams` and is an alternative to Flink.
- Amazong MSK is thus an alternative to Kinesis Data Analytics.
- Fully managed Kafka Clusters
    - allows you to create/delete clusters easily with no setup.
    - MSK manages the Brokers and Zookeeper nodes.
    - Supports Multi-AZ deployment (upto 3 for HA)
    - Automatic Recovery from common Kafka failures 
    - Data is stored on EBS volumes for as long as you want.

- MSK Serverless:
    - run Kafka clusters on AWS without managing capacity
    - automatically provisions and scales resources.

- You simply manage your 'producer' and 'consumer' apps.
- MSK Consumer Types:
    - Your own application running on EC2, ECS, EKS etc.
    - Kinesis Data Analytics
    -  AWS Glue Streaming ETL
    - AWS Lambda


## Kinesis Data Streams VS Amazon MSK
- Kinesis has a 1MB hard limit for message size. MSK has the same default limit but it can be configured to use more.
- In Kinesis, you `shard` Data Streams , whereas in MSK you use topic `partitions`
- In Kinesis, you scale by shard-plitting and shard-merging, whereas in MSK you scale by adding more partitions
- Kinesis has in-flight TLS encryption, whereas MSK has TLS as well as PLAINTEXT.
- Both have at-rest encryption using AWS KMS.


## Example: A Big Data Ingestion Pipeline
1. `IOT Core` can be used to collect data from IoT devices.
2. Data can then be sent to `Kinesis Data Streams` which is great for real-time collection.
3. Using `AWS Lambda` data can then be loaded into `Kinesis Data Firehose` which is great for sending data in near real-time to an ingestion bucket on`S3`.
4. The ingestion bucket can be connected to `AWS Athena` (triggered via another AWS Lambda)  which can then clean the data and send it to a reporting bucket on `S3`.
5. `Amazon QuickSight` can be used to visualize the data from the reporting bucket.
6. Data can then be stored in `Redshift` data warehouse for analytics.






