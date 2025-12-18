# Other Services

# CloudFormation
declaratively provision and manage AWS resources ie `Infrastructure as Code`

**Notes:**
- You can build,visualize the entire stack and its relationships using **Application Composer**.
- CloudFormation requires a ServiceRole to perform actions on your behalf. The user must have `iam:PassRole` permission which allows CF to assign roles to services/resources as specified in the template.

## EXAM - CloudFormation: Waiting for dependencies to be ready
- Use the `cfn-signal`in combination with `CreationPolicy` to explicitly tell CloudFormation when to proceed with stack creation.
    - The CreationPolicy tells Cloudformation to wait for a signal or a timeout before marking the status of a Resource as complete
    - cfn-signal is a helper script that can be invoked by the resource (usually EC2 User Data) to signal CloudFormation that it is ready

# Amazon Simple Email Service (SES)
Apps can send emails using SMTP/API.
allows inbound/outbount emails
flexible IPs

# Amazon Pinpoint
scalable 2-way Marketing communications service
SMS/Email Marketing Campaigns

# Amazon Systems Manager(SSM) - Session Manager
secure shell access to EC2 instances/On-premises servers without SSH, Bastion Hosts
uses SSM agent.

# Amazon Systems Manager(SSM) - Run Command
Execute a document/script across multiple instanaces.(without SSH)

# Amazon Systems Manager(SSM) - Patch Manager
Automate the patching process of instances
Supports Ec2 as well as on-prem VMs.
Linux/MacOs/Windows
On-demand or scheduled
Scan and generate patch compliance reports.


# AWS Instance Scheduler
automatically start/stop EC2 instances based on schedule



# AWS Workdocs
AWS WorkDocs is a fully managed, secure enterprise document storage and collaboration service for creating, sharing, and commenting on files.

