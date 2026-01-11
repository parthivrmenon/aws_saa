# IAM Advanced

# AWS Organizations
- provides a centralized way to manage all of your AWS accounts.

## Service Control Policies (SCP)
- specified tha maximum permissions that can be used by users and roles within an AWS account.
- Note: An SCP does not grant permissions, it simply a boundary/guardrail. You must still use IAM to grant permissions.
- When SCP is enabled, the root OU automatically starts with a FullAWSAccess policy.(ie. No permission boundary set for the root OU or any member OU under it.) SCPs are inherited by child OUs and accounts unless explicitly overridden.

## Tag Policies
- standardize tagging across your organization
- you define tag keys and their allowes values
- AWS Cost Allocation Tags and Attribute-based Access Control

## IAM Conditions
- use with IAM policies to add logic to your permissions
- can be used to restrict access based on time, IP address, request method, etc.
- aws:SourceIp for IP-based restrictions on clients
- aws:RequestedRegion for region-based restrictions
- aws:CurrentTime for time-based restrictions
- etc

## IAM Permissions Boundary
- set a maximum level of permissions that an IAM user or role can have
- cannot be set to a group.
- useful for granting least-privilege access while allowing flexibility

## IAM Roles vs Resource-Based Policy
Example: Granting access to an S3 bucket in Account B for a User in Account A
- attaching a resource-based policy to the S3 bucket that allows the principal of the user in Account A
- letting user in Account A assume a role in account B that has access to the S3 bucket.
- *Note*: In the second option, the principal ONLY has permissions of the assumed role.
- *Note*: S3, SNS, SQS, Lambda, ECR, API Gateway, and KMS support resource-based policies. For other services, you will need to assume role.

# AWS IAM Identity Center (successor to AWS Single Sign-On)
- Single Sign-On for 
    - all AWS accounts within your AWS Organization
    - Business cloud apps (Salesforce, Microsoft 365 etc)
    - SAML 2.0 enabled apps
    - EC2 Windows instances 
- Identity Providers:
    - built-in identity store within IAM Identity Center
    - 3rd party: Active Directory, OneLogin, Okta etc

## Identity Providers
- **IAM Identity Center Built-In Identity Store**: enabled by default.
- **External IdPs using SAML 2.0**:
    - Azure AD
    - Okta
    - OneLogin
    - Auth0
    - any SAML 2.0 enabled apps
- **Active Directory** (via AWS Directory Service or External AD)

## Access to externally authenticated users (Identity Federation)
- Cognito: Mobile/Web Apps (customer-facing) 
- External Web/Social IdPs: Apps which rely on external social IdPs (Google, Facebook etc) using OIDC.
- Enterprise SSO: Orgs managing their own IdPs like Active Directory using SAML 2.0.
- Custom identity broker: When your IdP does not support SAML or OIDC, you can use a custom identity broker to authenticate users.

## Attribute-Based Access Control (ABAC)
- define **PermissionSets** once
- define fine-grained permissions based on user attributes (retrieved from Identity store)
- apply these permissions to users based on their attributes rather than individual policies


# AWS Directory Services
- AWS Managed Microsoft AD:
    - create your own AD in AWS and manage users locally
    - establish trust with on-prem AD
    - supports MFA
- AD Connector
    - proxies authentication requests to on-prem AD
    - supports MFA
    - users are only managed on on-prem AD
- Simple AD
    - AD-compatible managed directory on AWS
    - cannot join an on-prem AD
    
# AWS Control Tower
- build on top of AWS Organizations
- automate setup of your environment using Automated **Landing Zone** Setup
- automate policy management using **Guardrails**
- detect policy violations and remidiate them
- monitor compliance through an interactive dashboard

## Guardrails
### Preventive Guardrails
- Enforced using Service Control Policies (SCPs)
- Block non-compliant actions in real time
- Prevent violations before they occur
- Applied at the OU level
- Examples:
  - Restrict accounts to specific AWS Regions
  - Deny disabling CloudTrail
  - Block creation of public S3 buckets

### Detective Guardrails
- Implemented using AWS Config rules
- Continuously monitor for violations
- Do not block actions; they detect and report non-compliance
- Findings appear in Control Tower and Config dashboards
- Examples:
  - Identify untagged resources
  - Detect if MFA is not enabled for IAM users
  - Check if S3 buckets are publicly accessible


## AWS Resource Access Manager
- easily and securely  share AWS resources across accounts under your AWS Organizations
- centrally manage resources you own across your estate
- you can share:
    - transit gateways
    - subnets
    - AWS License Manager configurations
    - Amazon Route53 Resolver rules