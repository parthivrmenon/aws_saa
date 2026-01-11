# Simple Queuing Service (SQS)
Fully-managed service, 
used to decouple applications AND/OR
used to act as buffer between Apps and Database

## Standard Queue

### General Features
* Unlimited throughput
* Unlimited capacity
* Retention: 4 days by default; upto 14 days
* Latency: <10ms for both send/receive
* Message Size: 256 KB/message

### Producers & Consumers
- Producers send messages via SDK's SendMessage API
- Consumers poll for messages from the queue
- Consumers can fetch upto 10 messages at a time
- messages are persisted in the queue until consumers delete it via DeleteMessage API or retention period has expired.

- at least once delivery
- best effort ordering
- consumer: 10 messages at a time
- consumer: use ASG for scaling (using Queue length)


## Consumers: Automatic Horizontal Scaling with Queue Length
- Add Consumers to an ASG
- Configure a CloudWatch alarm on `ApproximateNumberOfMessagesVisible` (or other queue metrics)
- Configure alarm to trigger ASG scaling policy (simple, step or target)

## Security
### Encryption:
- In-flight encryption using HTTPS API
- At-rest encryption using KMS keys
- Client-side encryption
### Access Controls
- using IAM policies
### SQS Access Policies
- used when other AWS services like Lambda, SNS, S3 need to send messages to the queue
- used when you want to access SQS across accounts

## Message Visibility Timeout
Once a message is polled by a consumer, it remains invisible to other consumers until the Message Visibility Timeout has expired.
- by default, the timeout is `30 seconds`
- a consumer can call `ChangeMessageVisibility` API to change visibility settings for a message

## Long Polling
`WaitTimeSeconds` is the amount of time consumers wait while polling when there are no messages in the queue.
It can be set:
- per API call `ReceiveMessage(WaitTimeSeconds)` by the consumer
- at queue level as `ReceiveMessageWaitTimeSeconds`
- useful to reduce the number of API calls made to SQS
- `WaitTimeSeconds` can be 0 (short polling) to 20 seconds


## FIFO Queues
FIFO queues support two special fields:
- `MessageGroupId`: a mandatory attribute that groups related messages together for ordering.
- `MessageDeduplicationId`: a unique identifier for each message to prevent duplicates.

These two fields ensure that `all messages within a message group are processed in order and exactly once`.

FIFO queues offer 300 msg/s (without batching) 3000 msg/s



## Standard Queues vs FIFO Queues
|Standard|FIFO|
|--------|----|
|At-least-once delivery to the queue|Exactly-once delivery to the queue|
|Best-effort ordering|Strict ordering within message groups|
|Unlimited throughput|300 messages/second (without batching), 3000 messages/second (with batching)|
|No deduplication|Built-in deduplication using MessageDeduplicationId|
|No message grouping|MessageGroupId for grouping related messages|
