# Amazon Kinesis Data Streams
Store streaming data in real-time

## Features
- Retention: upto 365 days
- Replay: conumsrs can replay data
- Expiration: data cannot be deleted (until it expires)
- Message Size: upto 1MB (small, real-time data)
- Ordering: order is guaranteed within same 'partition'
- Encryption: At-rest via KMS encryption, in-flight via  HTTPs
- Kinesis Producer Library (KPL) to write an optimized producer application
- Kinesis Client Library (KCL) to write an optimized consumer application

## Capacity Modes
- Provisioned mode:
    * choose number of shards
    * each shard gets 1MB/s or 1k records/s IN
    * each shard gets 2MB/s OUT
    * scale manually
    * cost -> per shard per hour

- On-demand mode:
    * default: 4MB/s or 4k records/s
    * auto-scale based on observed throughput in last 30d
    * cost -> per stream per hour & data(in GB) in/out

