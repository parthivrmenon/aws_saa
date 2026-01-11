# AWS Monitoring and Audit

# Cloudwatch Metrics
provides metrics for every AWS Service. You can also create custom metrics. 

**Cloudwatch Metric Streams**:
near real-time delivery of ALL or 'filtered' metric
targets:
- Amazong Kinesis Data Firehose
- 3rd party service: Datadog, NewRelic, Splunk etc

# Cloudwatch Logs
Log groups: arbitary names, usually defines an application
Log stream: instances within an application/log files/containers
Log expiration policies: never expire, 1 day - 10 years
Log Destinations:
- **S3**:
    - CreateExportTask
    - may take up to 12 hours
    - use Cloudwatch Log
- Kinesis Data Streams
- Kinesis Data Firehose
- AWS Lambda
- Opensearch
Logs are encrypted by default. You can chose to encrypt them via your own key using KMS if you want.

**Cloudwatch Log Insights**, provides an UI to query engine for logs

Logs can be exported via:
1. On demand export via `CreateExportTask`. Not real-time. For example, it may take 12 hours for logs to be exported to S3
2. Log Subscriptions
- real-time log events 
- subscription filter
- can send to Kinesis Data Streams, Data Firehose or Lambda
- subscription filters can work acorss Accounts/Regions

Metric Filters: create metrics out of log streams


## Cloudwatch Logs Agent (older)
You can install a Cloudwatch Logs Agent on your EC2 instances (or on-prem Virtual Machines) in order to collect logs and send it to Cloudwatch Logs.

**Note:** by default Cloudwatch does NOT collect any EC2 logs

## Cloudwatch Unified Agent
- can collect logs (just like Cloudwatch Logs Agent)
- **NEW** centralized configuration mangement of ALL agents using SSM Parameter Store
- collects additional metrics at high granularity
    - CPU
    - DIsk
    - RAM
    - Netstat (no of TCP/UDP connection, packets in, network bytes)
    - Processes
    - Swap Space 

**Note**: by default (without Cloudwatch Unified agent), EC2 only emits metrics for CPU, Network and Disk (not Memory)

## Cloudwatch Alarms
States: OK/ALARM/INSUFFICIENT_DATA

**Targets/Actions supported**:
- EC2 Actions: Stop, Terminate, Reboot or Recover EC2 instances
- Trigger an Auto-Scaling action 
- Send notification to SNS

## EXAM: Cloudwatch Alarms - Composite Alarm
You can create a composite alarm combining multiple Cloudwatch Alarms using AND/OR conditions. 

This lets you create monitors around 'multiple' metrics and thus reduce **Alert noise**.

## EXAM: EC2 Instance Recovery

A Cloudwatch Alarm can be set on any of the status checks (eg: StatusCheckFailed_System) which can be sent to SNS OR trigger an EC2 Action directly

EC2 Status Checks:
- Instance Status checks: checks EC2 VM
- System status: check underlying hardware
- attached EBS status: check attached volumes

**Note**: you can use `set-alarm-state` via CLI to manually set an alarm state (useful for testing)

# Amazon Eventbridge (used ot be CLoudwatch Events)

Default Event Bus (for AWS services)
Partner Event Bus (SaaS Partners - Datadog, Auth0 etc)
Custom Event Bus - custom apps

**Notes:**
- You can setup resource-based policies to allow cross account access to these even buses
- you can `archive` events and `replay` them.

EventBridge - Schema Registry
EventBridge - Resource-based Policy
- manage permissions for a event bus
- eg: Central Event Bus to be shared across accounts


**Event Rule:**
- Rule:
    - Event Pattern -> Event Source, AWS Service, Event Type
        - EC2 Events - eg StartInstance
        - CodeBuild Events - eg BuildFailed
        - S3 Events - UploadObject
        - TrustedAdvisor - New Finding
    - Schedule
        - just like cron..


**Event Filter**:
JSON policies to filter events of interest

**Event Destinations**:
- Lambda. AWS Batch, ECS Task
- SQS, SNS, Kinesis Data Streams
- Step Functions, CodePipeline, CodeBuild
- **SSM**, **EC2 Actions**


# Cloudwatch Container Insights
Collect, aggregate, summarize metrics and logs from containers.
Supports:
- ECS
- EKS
- Kubernetes on EC2
- Fargate (ECS and EKS)

**Note:** Container Insights uses a containerized version of Cloudwatch Agent for EKS/ECS

# Cloudwatch Lambda Insights
Collect, aggregate, summarize lambda metrics:
- CPU, Mem, Disk, NW
- cold starts, worker shutdowns

# Cloudwatch Contributor Insights
Identify "Top Consumers" of log data.
eg: Identify heaviest network users from within VPC Flow Logs

# Cloudwatch Application Insights
Automated dashboards for apps running on EC2
JAVA, .NET, Microsoft IIS Web server
It also aggregates insights from AWS services that your App is using

Powered by SageMaker

**Note:** Findings will be sent to AWS EventBridge and SSM OpsCenter

# AWS Cloudtrail
History of events/API Calls made within your AWS Account by:
- Console
- SDK
- CLI
- AWS Services
**Notes:**:
- Cloudtrail is enabled by default
- Cloudtrail logs can be sent into Cloudwatch Logs or S3
- a Trail can be applied to All Regions (default), or a single Region

## CloudTrail Events
- Management Event(enabled by default):
    - audit management operations performed on your resources
    - ReadEvents and WriteEvents
    - example events: 
        - IAM AttachRolePolicy
        - EC2:CreateSubnet
        - CloudTrail:CreateTrail
- Data Events (not enabled by default as its large volume)
    - eg: Amazon S3 Object level activity: GetObject, PutObject 
    - AWS Lambda Invocations: Invoke API
- Insights Events
    - **paid** feature
    - analyzes unusual activity
        - inaccurate resource provisioning
        - hitting service limits
        - bursts of IAM actions
        - gaps in periodic maintenance activities
    - it analyzed 'normal' management events to create a baseline and then analyzes 'write' events to detect unusual patterns.
    - sent to:
        - CloudTrail console
        - S3 bucket
        - EventBridge

- **Retention:**
    - Events are stored for 90d by default
    - to keep events beyond 90d send them to S3 and use Athena


# AWS Config
Helps you audit all 'configurations' within your Account to ensure you are compliant.

Examples:
- Is there unrestricted SSH access to my Security Groups
- Do my Buckets have unrestricted access
- How has my ALB configuration changed over time

Features:
- You can configure SNS notifications for any configuration changes
- Per-Region service but you can aggregate across ALL regions and accounts
- store configuration data into S3 for later analysis

## Config Rules
 - Over 75 **AWS Managed Config Rule**(s)
 - Define a **Custom Rule** (using Lambda)
 - Rules can be evaluated:
    - on a schedule
    - for each configuration change
**Notes:** 
- Config rules cannot 'DENY' or prevent actions.
- 0.003$ / configuration item recorded / region
- 0.001$ / configuration rule evaliation / region

## Config Rules - Remediations
Example: IAM Access Keys have expired (older than 90 days), 
You can create AWS Config Rule to invoke the `SSM Document: AWSConfigRemediation-RevokeUnusedIAMUserCredentials`

## Config Rules - Notifications
- Use EventBridge Rules to trigger notifications via SNS/SQS/Lambda
- Use SNS (with Filtering at client-side)




