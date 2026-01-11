# Amazon Data Firehose
Fully managed delivery pipeline that automatically loads streaming data into AWS services (S3, Redshift, OpenSearch, Splunk, Datadog, etc.).

## Features
- fully-managed & serverless
- near real-time with a buffer
- can optionally transform data using Lambda
- can send data (in batches) to:
    - Amazon S3, RedShift, OpenSearch
    - 3rd party services: Mongodb, Datadog, Splunk
    - custom HTTP endpoint 
- supports CSV, JSON, Patquet, Avro, RawText, Binary Data


## Kinesis vs Firehose
|Kinesis|Firehose|
|---|---|
|A semi-managed, real-time streaming service that you consume/process yourself using Lambda or a Kinesis Client Library (KCL) apps|A fully-managed, near real-time delivery pipeline that automatically loads streaming data into AWS services (S3, Redshift, OpenSearch, Splunk, Datadog, etc.)|
|processes events in real-time with low latency (milliseconds)|buffers data before delivery in near real-time (seconds to a minute based on buffer size)|
|Manual shard-management and scaling|Fully-managed, Auto-scaled|
|Retention: 1-365 days configurable|No storage beyond the buffer|
|Replayable|Not replayable|
|No processing of data|Can process data (Lambda, built-in transformations) like JSON -> Parquet/Avro/ORC|
|can be **consumed** by Lambda or KCL apps|can be **delivered** to S3, Redshift, OpenSearch, Custom HTTP endpoint, Datadog, Splunk|
| Guarantees Ordering within a shard | No ordering|
|Usecases: Real-time dashboards, Fraud detection, IoT Telemetry, custom stream-processing apps| Usecases: delivery logs from apps/cloudwatch to s3, ingest data into a DataLake, load clickstream into Redshift, send logs to Opensearch/Splunk|



## SQS vs SNS vs Kinesis
* SQS
    - Consumer pulls data
    - data is deleted after being consumed
    - unlimited no of consumers
    - no need to provision throughput
    - ordering is guaranteed only in FIFO queues
    - individual message delays capability
* SNS
    - push data to many subscribers
    - upto 12,500,000 subscribers per topic
    - data is not persisted
    - Pub/Sub
    - upto 100k topics
    - no need to provision throughput
    - integrated with SQS for 'fan-out' architecture
    - FIFO capability for SQS-FIFO
* Kinesis:
    - standard pull data 2MB per shard
    - enhanced fan-out push data: 2MB per shard per consumer
    - data is replayable
    - for real-time big data analytics, ETC etc
    - ordering at shard level
    - data expiry after X days (max 365d)
    - provisioned or on-demand capacity




