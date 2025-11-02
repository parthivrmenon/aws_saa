# Simple Queuing Service
Fully-managed service, 
used to decouple applications AND/OR
used to act as buffer between Apps and Database


## Standard Queues
### Features
- unilimited throughput, unlimited messages (inifinitely scalable)
- retention 4-14 days
- low latency (<10ms) on send/receive
- max 256 KB per message
- at least once delivery
- best effort ordering
- consumer: 10 messages at a time
- consumer: use ASG for scaling (using Queue length)

## Consumers: Horizontal Scaling
- Consumers 'poll' for messages 
- Setup an ASG + Cloudwatch Alarm on Cloudwatch Metric 'ApproximateNumberOfMessages' ( Queue length)
- whenever there is a breach, more consumers are added

## Security
- Encryption:
    - In-flight encryption using HTTPS API
    - At-rest encryption using KMS keys
    - Client-side encryption
- Access Controls
    - using IAM policies
- SQS Access Policies
    - useful for cross-account access to SQS queues
    - useful for allowing other services like SNS, S3 etc to write to an SQS queue

## Message Visibility Timeout
Once a message is polled by a consumer, it remains invisible to other consumers until the Message Visibility Timeout is over.

- by default, 30 seconds
- a consumer can call ChnageMessageVisibility API to change visibility settings for a message

## Long Polling
Consumers can optionally 'wait' for messages to arrive if there are None in the queue

- reduce number of API calls made to SQS
- can be enabled at queue level of at the API level using WaitTimeSeconds
- WaitTimeSeconds can be 1 to 20 seconds
- always preferable to Short Polling

## FIFO Queues
### Features
- guaranteed order (within message group)
- Message Group ID mandatory
- 300 msg/s (with no batching), 3000 msg/s (with batching)
- exactly-once send capability (removes duplicates using deduplication id)


