# Serverless

## AWS Lambda
Short-lived, serverless compute functions that can be triggered on-demand.
- Automatic scaling
- Pricing:
    - pay per request + compute time
    - generous free-tier of 1,000,000 requests and 400,00 GBs of compute time
- Integrated with a lot of AWS services
- Supports most Programming Languages
- Monitoring via CloudWatch
- can get upto 10GB of RAM (to improve CPU and Network performance)
- Lambda Runtime API?
- Resources:
    - Memory: 128MB - 10GB (1MB increments)
    - Disk: 512MB to 10GB ephemeral storage mounted at /tmp
- Limits (Per-region)
    - Execution:
        - Memory : 128MB - 10GB (1MB increments)
        - Max Execution Time: 900 seconds (15 minutes)
        - Environment variables: 4KB
        - Disk (/tmp) : 512 MB to 10GB
        - Concurrency: 1000 executions (can be increased)
    - Deployment
        - Size: 50 MB (compressed .zip), 250 MB (unzipped code + dependencies) 
        - can use /tmp directory to load other files at startup
        - Environment variables: 4KB
- Reserved Concurrency
    - can limit the maximum number of concurrent executions
    - at function level
    - each invokation over the limit will return 
        - Synchronous -> ThrottleError 429
        - asynchronous -> Retry automatically with exponential backoff and then go to DLQ after max attempts.
    - can raise a support ticket to get a higher (>1000) limit.
    - Usecase: 
        * to ensure each caller gets equity

- Provisioned Concurrency
    - ensures a specified number of lambda functions are initialized and ready to serve requests
    - eliminates "Cold" start for that number of concurrent invocations
    - you pay for provisioned concurrency even if idle
    - Application Auto Scaling can manage concurrency (schedule or target utilization)
- SnapStart (only for JAVA, Python, .NET)
    - runs the init phase once and then stores the state
    - subsequent runs are faster
    - use for unpredictable workloads (running on JAVA,Python,.NET) where provisioned concurrency is not cost-effective.
- Encryption Helpers:
    - Encryption helpers in Lambda let you use KMS to encrypt environment variable values when saving them, and Lambda automatically decrypts them at runtime using the execution role’s KMS permissions.

- AWS Lambda with Container Image Support:
    - allows you to use a docker container in ECR to be run as a lambda function
    - easier to package runtime+dependecies compared to traditional lambda.


# AWS API Gateway
## Features:
- Supports HTTP/WebSocket
- handle API versioning
- handle environments (prod, dev)
- handle security (Authentication and Authorization)
- create API Keys; handle request throttling
- Swagger/OpenAPI import to define APIs faster
- Transform and Validate requests/responses
- Generate SDK and API spec
- Caching of API responses

## Integrations
- Lambda Function: invoke lambda function as a response to API call
- HTTP: backend can be on-prem or ALB
- AWS Service: integrate with other AWS services directly via the service's API
- DynamoDB

## Endpoint Types
- Edge-Optimized (default):
    - for globally distributed clients; Public APIs.
    - requests are routed automatically through Cloudfront Edge locations to a regional API Gateway
    - url: https://{api-id}.execute-api.{region}.amazonaws.com
      - default HTTPs
      - AWS-managed certificate
      - TLS termination at Cloudfront

- Regional
    - for clients within the same region;
    - could manually combine with Cloudfront for more control over Cahing/WAF Rules.
    - url: https://{api-id}.execute-api.{region}.amazonaws.com
        - default HTTPs
        - AWS-managed certificate
        - TLS termination in the Region
- Private
    - can only be accessed via VPC using an interface VPC endpoint
    - use a resource policy to define access
    - url: https://{api-id}.execute-api.{region}.amazonaws.com
        - default HTTPS
        - AWS-managed certificate
        - TLS termination in the Region

## User Authentication
- IAM Roles for internal applications
- Cognito for external users using WebIdentity
- Custom Authorizer 

## EXAM - Custom Domain Name HTTPs Security
- integrates with ACM
- for edge-optimized endpoints certificate must be us-east-1 (as Cloudfront (Control Plane) will only use certificates from us-east-1)
- for regional endpoint certificate must be in the same region as API Gateway
- setup Alias or CNAME in Route 53 

# AWS Step Functions

A visual, serverless workflow service to orchestrate AWS services (commonly Lambda).

Features:
- Integrates with AWS services such as Lambda, ECS, EC2, API Gateway, SQS, SNS, DynamoDB
- Can implement **human approval workflows** using **wait states + callbacks** (task tokens)
- Supports **sequence, parallel execution, retries, timeouts, error handling, and branching**
- Manages **state and execution history automatically**



## Amazon SWF vs AWS Step Functions (Exam-Focused)

| Distinction | Amazon SWF | AWS Step Functions |
|------------|-----------|-------------------|
| Purpose | Coordinate long-running, stateful workflows | Serverless orchestration of AWS services |
| Execution Model | **Worker polling (pull model)** | **Service invocation (push model)** |
| Task Runners | External workers (EC2, containers, **on-prem**) | AWS-managed services (Lambda, ECS, SDK calls) |
| On-Prem Support | **Native and firewall-friendly** | Indirect (API Gateway, SQS, callbacks) |
| State Management | Manual via SWF APIs | Automatic |
| Workflow Duration | Minutes to **months** | Seconds to days (Standard) |
| Human Approval | Native | Via wait states + callbacks |
| Serverless | No | **Yes** |
| Complexity | Higher (you manage workers) | Lower (managed) |
| Exam Preference | Legacy / niche | **Default choice** |
| Exam Triggers | On-prem workers, long-running, polling | Serverless orchestration, Lambda workflows |



# Amazon Cognito

Identity service for **web and mobile application users**.

## Cognito User Pools (CUP)
- **User directory** for app users (sign-up, sign-in, MFA, password policies)
- Issues **JWT tokens** after authentication
- Integrates with:
  - **API Gateway** (Cognito authorizer)
  - **Application Load Balancer (ALB)** (OIDC authentication)
- Used for **authentication**

## Cognito Identity Pools
- Provide **temporary AWS credentials** (via STS) to authenticated or guest users
- Allow users to access **AWS services directly** (e.g., S3, DynamoDB)
- Can federate identities from:
  - **Cognito User Pools**
  - Social IdPs (Google, Facebook, Apple)
  - SAML / OIDC providers
- Used for **authorization to AWS resources**




# Others

- DynamoDB
- AWS Cognito
- AWS API Gateway
- Amazon S3
- AWS SNS & SQS
- AWS Kinesis Data Firehose
- Aurora Serverless
- Step Functions
- Fargate
