# Elastic Container Service

## EC2 Launch Type
- You must provision and maintain the EC2 instances
- ECS Tasks are run on pre-provisioned EC2 instances
- each EC2 instance must run the ECS Agent to register in the ECS Cluster
- starting/stopping containers is taken care by AWS 



## Fargate Launch Type
- You don't need to provision or scale the infrastructure (Serverless)
- ECS Tasks are run by AWS automatically
- **Note:** Fargate Profiles can be created for EKS clusters too.

## IAM Roles

### EC2 Instance Profile (only EC2 Launch Type)
- used by ECS Agent
- makes API calls to ECS service
- send container logs to CloudWatch
- pull images from ECR
- pull secrets from Secrets Manager/SSM Parameter Store

### ECS Task Role:
- assigned to ECS Tasks
- different roles for different ECS services you run
- Task Roles are defined in the task definition

## Load Balancer Integrations
- ALB : Recommended for most use cases
- NLB: only for high throughput/ high performance (pair with Private Link)
- CLB: Not recommended: does not integrate with Fargate)

## Data Volumes (EFS)
- Fargate + EFS recommended
- supports both Fargate and EC2 launch types
- Use case: persistent multi-AZ shared storage for tasks
- Note: S3 cannot be mounted as file system


## ECS Service Auto-scaling
automatically increase the number of ECS tasks

### Types
### using AWS Application Auto Scaling
scaling can be based on the following metric(s)
- Average CPU Utilization
- Average Memory Utilization
- ALB Request count per Target

### Target Tracking: 
scaled based on target value for a specific CloudWatch metric

### Step Scaling:
scale based on a specific CloudWatch Alarm

### Scheduled Scaling
scale based on a specified date/time  (predictable changes)


## EC2 Launch Type - Autoscaling EC2 instances
accomodate ECS Service scaling by adding underlying EC2 instances.

### Auto Scaling Group
- scale your ASG based on CPU utilization
- add EC2 instances over time

### ECS Cluster Capacity Provider
- used to auto-provision
- pair with ASG
- add EC2 instances when you are missing capacity.


## Amazon ECR
Elastic Container Registry

* can be Public: https://gallery.ecr.aws or Private
* Fully-integrated with ECS, backed by S3
* Access-controlled through IAM policies
* Supports image vulnerability scanning, versioning, image tags, image lifecycle.


