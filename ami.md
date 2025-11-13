# Amazon Machine Image (AMI)
is an image that provides the software required to launch an EC2 instance. It also has block device mapping that specifies the storage configuration for the instance.

## Characteristics
You can select an AMI based on:
- Region
- Operating System
- Processor Architecture
- Launch Permission
- Root volume type
- Virtualization type

## Launch Permission
determines who can use the AMI to launch EC2 instances. Launch permission can be one of three types:
* `public`: Any AWS account can launch the AMI
* `explicit`: Only the specified AWS account(s), Organization(s) or OU(s) can launch the AMI
* `implicit`: The owner of the AMI can launch the AMI

## Root Volume Type
Amazon EBS-Backed AMI: the root volume of an instance launched from this AMI is an EBS volume created from an EC2 Snapshot. Supported for both Linux and Windows.
Amazon S3-Backed AMI: the root volume of an instance launched from this AMI is an Instance store volume  created from a template stored in an S3 Bucket. Supported for Linux only.