# Amazon Kinesis Data Streams (KDS)
Real-time streaming ingestion that you consume/process yourself (e.g., Lambda, Kinesis Client Library apps).

## Features
- Retention: 24 hours to 365 days
- Replay: conumsrs can replay data
- Expiration: data cannot be deleted (until it expires)
- Message Size: upto 1MB (small, real-time data)
- Ordering: order is guaranteed within same 'partition'
- Encryption: At-rest via KMS encryption, in-flight via  HTTPs
- Kinesis Producer Library (KPL) to write an optimized producer application
- Kinesis Client Library (KCL) to write an optimized consumer application

## Producers
- Apps using Kinesis Producer Library (KPL) or AWS SDK
- AWS Lambda
- AWS IoT Core
- AWS Firehose/CloudWatch

## Capacity Modes
`Provisioned Mode`: 
Manually scale by defining the number of shards
- Each shard gets a fixed throughput:
    - 1MB/s or 1k records/s IN
    - 2MB/s OUT
- scale manually
- cost -> per shard per hour

`On-demand mode`:
Kinesis automatically scales based on observed throughput in last 30d
- starts with 4MB/s or 4k records/s
- auto-scale based on observed throughput in last 30d
- $/stream/hour & data(in GB) in/out

## Exam: KDS - Enhanced Fan-Out
Normally, the OUT throughput is shared across consumers, but KDS let's you create dedicated thoughout for each Consumer using Enhanced Fan-Out.
 
## Partitioning


