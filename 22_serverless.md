# Serverless

## AWS Lambda
- Short-lived Virtual Functions
- runs On-Demand
- Automatic scaling
- Pricing:
    - pay per request + compute time
    - generous free-tier of 1,000,000 requests and 400,00 GBs of compute time
- Integrated with a lot of AWS services
- Supports most Programming Languages
- Monitoring via CloudWatch
- can get upto 10GB of RAM (to improve CPU and Network performance)
- Lambda Runtime API?
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
    - avoid "Cold" start
    - Application Auto Scaling can manage concurrency (schedule or target utilization)




- DynamoDB
- AWS Cognito
- AWS API Gateway
- Amazon S3
- AWS SNS & SQS
- AWS Kinesis Data Firehose
- Aurora Serverless
- Step Functions
- Fargate
