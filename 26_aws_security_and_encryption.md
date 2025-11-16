# AWS Security and Encryption

# AWS Key Management Service (KMS)
- Fully managed Encryption Service 
- integrates with IAM for Authorization
- integrates with AWS CloudTrail for Auditing
- integrates with other AWS Services lke EBS, S3, RDS, SSM, EKS etc
- KMS keys cannot be migrated across regions/accounts
## Key Types - General
### Symmetric Keys
- a single key is used for both encryption and decryption
- AWS services that integrates with KMS uses Symmetric Keys
- You don't have access to the key material

### Asymmetric Keys 
- a public key is used to encrypt data and a private key is used to decrypt data
- used for signing/verifying data
- you can download the public key material

## KMS -  Key Types
- AWS Owned Keys - SSE-S3, SSE-SQS, SSE-DDB 
- AWS Managed Keys (AMK)
    * format: aws/service
    * uses symmetric keys
    * rotated automatically
- Customer Managed Keys (CMK)
    * two types: created, imported
    * both types cost $1/month + 0.03 per 1000 requests
    * key rotation:
        - can be enabled (90d - 2560d)
        - supports on-demand rotation as well (max 10 times)
    * if its an imported key, you need to manage key rotation usig 'alias'

## KMS - Key Policies
### Default Key Policy
- created if you don't provide a key policy
- grants complete access to the key to the owner of the key

### Custom Key Policy
- allows you to define who can use the key and what actions they can perform
- used to allow cross-account access to the key. eg: Copying snapshots between accounts
- can be attached to a CMK

## KMS - Multi-Region Keys
- a set of identical keys in different AWS regions that can be used interchangeably - ie. encrypt in one region and decrypt in another.
- multi-region keys have the same ID, key material, key rotation policy.
- once created, each Multi-Region keys is managed independently.

Use Cases:
- a 'global' client side encryption key 
- for services like Global Aurora or Global DynamoDB.


# S3 Replication - Encryption Considerations
- SSE-S3: encryption is fully supported by S3 replication.
- SSE-C: encryption is not supported by S3 replication.
- SSE-KMS: 
    - encryption is supported by S3 replication
    - S3 requires permissions to:
        - decrypt using source KMS CMK
        - encrypt using destination KMS CMK
    - object is decrypted using source KMS CMK by S3
    - re-encrypted using destination KMS CMK by S3
    - even if you use Multi-Region keys, S3 will treat them as independent keys.

# AMI Sharing across AWS Accounts - Encryption Considerations
1. AMI in source account is encrypted with KMS Key in source account
2. modify AMI to add Launch Permissions for the destination account
3. Share the KMS key with the destination account
4. destination account should have permissions to DescribeKey,ReEncrypt, CreateGrant, Decrypt
4. When launching an EC2 instance with the AMI, the destination account has the option to re-encrypt the AMI using a different KMS key.
## KMS - EKS

## KMS - Lambda


# SSM Parameter Store
- secure sotrage for secrets
- optional encryption using KMS
- version tracking
- integrates with IAM
- integrates with CloudFormation
- notifications via Amazon EventBridge
- can acces AWS Secrets Manager secrets via /aws/reference/secretsmanager/secret_id
## Parameter Tiers
|Standard|Advanced|
|---|---|
|10k per account per region|100k per account per region|
|4KB max size per parameter|8KB max size per parameter|
|no parameter policies|parameter policies are available|
|free|$0.05 per parameter per month|
|cant be shared across accounts|can be shared across accounts|

## Parameter Policies
- only for advanced tier
- allow assigning a TTL to a parameter

# AWS Secrets Manager
- newer than SSM Parameter Store
- force rotation of secrets every 'x' days
- automate generation of secrets using Lambda
- integrates with more services like Amazon RDS (MySQL, Postgres, Aurora) , DocumentDB, Redshift etc.
- Secrets are encrypted using KMS
## AWS Secrets Manager - Multi-Region Secrets
- replicates secrets across regions
- replicas are kept in sync
- can promote replica secrets to primary
- useful to use the same secret across regions for Disaster Recovery patterns.
- $0.40 per secret per month + 0.05 per 10,000 requests

# AWS Certificate Manager (ACM)
- provision, manage, deploy TLS certificates
- supports both public and private certificates
- free of charge for public certificates
- auto-renewal
- integrates with
    * Elastic Load Balancing (CLB, ALB, NLB)
    * CloudFront
    * API Gateway
- Note: You cannot use ACM with EC2 instances directly.

## AWS ACM - Reuqestint a Public Certificate
- List domains (FQDN or wildcard) for which you want to request a certificate
- Selectt validation method (DNS or Email)
    - Email validation sends an email to the contacts listed in WHOIS
    - DNS validation requires you to add a CNAME record to your domain
- After a few hours certificate is issued and setup f or auto-renewal 60 days before expiry.

## AWS ACM - Importing a Private Certificate
- No auto-renewal
- ACM will send daily reminders to the contacts listed in WHOIS 45 days before expiry. (can be configured)
- Reminders are sent into AWS EventBridge
- You can also use AWS Config to monitor certificate expiry using the rule acm-certificate-expiration-check.

## AWS ACM - Integrating with ALB
- ALB can send HTTP-to-HTTPS redirect

## AWS ACM - Integrating with API Gateway
- create a custom domain name in API Gateway
- For Edge-Optimized (default) endpoints:
    - requests are routed through CloudFront Edge Locations
    - TLS certificate must be in the same region as CloudFront (us-east-1)
    - setup CNAME or Alias records in route53
- For Regional endpoints:
    - TLS certificate must be imported in the same region as API Gateway
    - CNAME records or ALIAS records in route53

# AWS Web Application Firewall (WAF)
- protects you against common Layer 7 attacks
- deploys on:
    - ALB
    - API Gateway
    - CloudFront
    - AppSync Graphql API
    - Cognito User Pools

- define Web ACLs on:
    - IP Set: upto 10k IP addresses per rule
    - HTTP Headers or Body, URI Strings for common attacks like SQL Injection, XSS, etc.
    - size constraints
    - geo-match (block specific countries)
    - rate-based rules for DDoS protection
- web ACLS are regional except for CloudFront

## WAF - Fixed IP for ALB
- you can use a Globla Accelerator for fixed IP and then use WAF to protect the ALB

# AWS Shield
- provides DDoS protection
- AWS Shield Standard:
    - free
    - provides basic protection: SYN/UDP flood, Reflection, etc.
- AWS Shield Advanced:
    - paid ($ 3000/month per orginization)
    - provides advanced protection for EC2, ELB, Cloudfront, Global Accelerator and Route53
    - 24/7 DDoS Response Team (DRP)
    - protection against higher fees during DDoS spikes.
# AWS Firewall Manager
- manage rules across accounts in all organizations
- lets you define rules for:
    - WAF rules
    - AWS Shield advanced rules
    - Security Groups for EC2, ALB and ENIs
    - AWS Netowrk Firewall (VPC level)
    - Amazon Route 53 Resolver DNS Firewall
- all policies are created at regional level
- $100/month per policy

# WAF vs Firewall Manager vs Shield
- WAF, Shield and Firewall Manager are used together to provide a comprehensive security strategy
- you can WAF rules for granular protection
- if you want to use WAF rules across accounts and to ensure new resources are automatically protected, use Firewall Manager
-  if you are prone to DDoS attacks, use Shield Advanced which gives you access to Shield Response Team (DRP) and also manages the WAF rules for you.

# Amazon GuardDuty
- intelligent threat detection service
- uses Machine Learning/Anomaly Detection to detect threats
- input data:
    - cloudtrail logs
    - vpc flow logs
    - dns logs
    - optionally, EKS Audit Logs, RDS & Aurora, EBS, Lambda, S3 Data Events etc
- can setup EventBridge rules to forward findings to CloudWatch, Lambda etc
- can protect against cryptocurrency attacks




