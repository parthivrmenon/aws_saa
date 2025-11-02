# Simple Notification Service
Managed Pub/Sub service

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
- publish once onto SNS
- setup multiple SQS as subscribers to SNS
- fully-decouples, no data loss
- SQS provides data persistence, delayed processing and retries 
- can add more SQS subscribers over time
- ensure SQS queue access policy allows for writes from SNS
- cross-region delivery (SNS can write to SQS in other regions)

## Fan out: Use cases
- S3 Events to multiple Queues
    * Limitation: For some combination of Event Type (S3: Create Object) and prefix (images/) you can only have one S3 Event Rule
    * using a "fan-out" pattern same S3 Event (S3:Create Object) can be send to many SQS queues and then consumed by multiple targets
- SNS to Amazon S3 through Kinesis Data Firehose?
- SNS - FIFO ?


## Message Filtering
- JSON policy used to filter messages received by Subscribers
- If there is no filter policy, a subscriber recieves ALL messages