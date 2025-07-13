# Elastic Beanstalk
a managed service which provides a developer-centric view of deploying an application on AWS.

- automatically handles capacity provisioning load balancing, load balancing, scaling, application health monitoring, instance configuration
- just the application code is the responsibility of the developer
- developers can have full control over the configuration
- is free, but you have to pay for the underlying services


## Components
Application
    - Application Version: iteration of application code to deploy
    - Environment: 
        - eg: dev, test, prod...
        - collection of AWS resources for running a specific Application Version
        - Tiers: 
            - Web Server Environment Tier (ELB -> ASG-> EC2)
            - Worker Environment Tier (SQS -> ASG -> EC2)
        



