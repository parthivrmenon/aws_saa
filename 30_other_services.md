# Other Services

# CloudFormation
declaratively provision and manage AWS resources ie `Infrastructure as Code`

**Notes:**
- You can build,visualize the entire stack and its relationships using **Application Composer**.
- CloudFormation requires a ServiceRole to perform actions on your behalf. The user must have `iam:PassRole` permission.
- Use the `cfn-signal`in combination with `CreationPolicy` to explicitly tell CloudFormation to proceed with stack creation.
    - The CreationPolicy tells Cloudformation to wait for a signal or a timeout before marking the status of a Resource as complete
    - cfn-signal is a helper script that can be invoked by the resource to signal CloudFormation that it is ready

# Amazon Simple Email Service (SES)
Apps can send emails using SMTP/API.
allows inbound/outbount emails
flexible IPs

# Amazon Pinpoint
scalable 2-way Marketing communications service
SMS/Email Marketing Campaigns

# SSM Session Manager
secure shell access to EC2 instances/On-premises servers without SSH, Bastion Hosts
uses SSM agent.

# AWS Instance Scheduler
automatically start/stop EC2 instances based on schedule

