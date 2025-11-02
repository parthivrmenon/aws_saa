# Amazon MQ
Amazon MQ is a managed message broker service for RabbitMQ, ActiveMQ

Usecase: allows traditional on-prem apps to migrate to cloud without any re-engineering

## Features
- supports traditional protocols like MQTT, AMQP, STOMP, Openwire, WSS
- doesn't scale as much as SQS/SNS
- runs on servers, can run in Multi-AZ with failover (requires Amazon EFS as backend storage)
- supports 'queueing' (like SQS) and topics (like SNS)

