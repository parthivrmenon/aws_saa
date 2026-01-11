# Simple Notification Service
Managed Pub/Sub service when you want to send a single message to multiple targets.

## SNS vs SQS
|Feature|SNS|SQS
|---|---|---|
|Architecture|Publish/Subscribe|Queueing system|
|Persistence|Not stored|Stored for upto 14 days|
|Delivery Guarantee|At-least-once delivery to each subsriber|At-least-once delivery (Standard), exactly-once processing (FIFO)|
|Ordering|No ordering|Ordering is guaranteed (FIFO)|
|Duplicates|Duplicates are possible|No duplicates are possible with FIFO Queues|
|Fan-out| Nativeley supported | Not supported natively|
|Subsriber Types| Lambda, SQS, SMS, Email, HTTPS| Only Applications|
|Advanced Features|Message Filtering|Message Groups|

**Note:** See SNS FIFO Topic



## Features
- Publisher sends messages to a single SNS Topic
- Subscribers who have subscribed to the topic receives all the messages
- NEW feature to filter messages is now available
- Upto 12,500,000 subscriptions per topic
- limited to 100,000 topics
- integrations with lots of AWS services

## How to publish?
- Topic publish
    - using SDK
    - create a topic
    - create a subscription
    - publish to topic

- Direct publish
    - for mobile apps SDK
    - create a platform applicatoion
    - create a platform endpoint
    - publish to platform endpoint
    - works with Google GCM, Apple APNS, Amazon ADM

## Security
- Encryption:
    - In-flight encryption using HTTPS API
    - At-rest encryption using KMS keys
    - Client-side encryption
- Access Controls
    - using IAM policies
- SNS Access Policies
    - useful for cross-account access to SNS queues
    - useful for allowing other services like S3 etc to write to an SNS topic

## SNS + SQS: Fan out
Publish once into an SNS topic and have multiple SQS queues subscribe to it.

Note: SQS Access Policy must allow SNS to write to it.

### Benefits
- SNS provides "fan-out" by simply adding more subscribers (SQS queues)
- SQS provides persistence, retries and delayed processing
- can work across regions.
### Practical Applications
`S3 Events`:
* Limitation: for one combination of an event_type (eg: ObjectCreate) and prefix (images/) you can only have one S3 Event Rule. 
* You can get around this limitation by using the "fan-out" pattern.

`Kinesis Data Firehose`:
* SNS can have Kinesis Data Firehose as a subscriber
* Applications can simply write to an SNS topic which then gets sent to Kinesis Data Firehose
* Kinesis Data Firehose can then write to S3



## SNS FIFO Topic
A `FIFO Topic` implements the same MessageGroupId and MessageDeduplicationId features as SQS FIFO Queue. This ensures ordering and deduplication.

But, you can only have a SQS Queue (Standard or FIFO) subscribe to a SNS FIFO Topic.

Throughput is limited to 300 messages/second (without batching) 3000 messages/second (with batching)


## Message Filtering
- JSON policy used to filter messages received by Subscribers
- If there is no filter policy, a subscriber recieves ALL messages
