# Amazon Data Firehose
A "near" real-time Service that can push/pull data from various sources like Kinesis, CloudWatch, IoT etc

## Features
- fully-managed & serverless
- near real-time with a buffer
- can optionally transform data using Lambda
- can send data (in batches) to:
    - Amazon S3, RedShift, OpenSearch
    - 3rd party services: Mongodb, Datadog, Splunk
    - custom HTTP endpoint 
- supports CSV, JSON, Patquet, Avro, RawText, Binary Data

## Differences between Kinesis & Firehose
* Kinesis:
    - streaming data collection
    - real-time
    - Producer/Consumer code
    - Provisioned/On-Demand 
    - Storage: 365 days retention
    - Replayable

* Firehose:
    - loading of streaming data into various destinations
    - near real-time (has a buffer)
    - fully-managed
    - auto-scaled
    - no Storage
    - Not replayable

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




