# Networking & VPC

# Virtual Private Cloud (VPC)
- ALL IPv4 addresses within a VPC are private IP addresses
- max 5 VPC's per region (soft limit)
- CIDR blocks can be:
    - smallest  : `/28` (16 IP addresses)
    - largest   : `/16` (65536 IP addresses)
- VPC CIDRs cannot overlap with each other or with on-premises networks

# Default VPC
* All new accounts have a default VPC
* New EC2 instances are launched into default VPC if no other VPC is specified and get's both a private and public IP address along with DNS names.
* Has an Internet Gateway (IGW)
* DNS resolution enabled

# VPC - Subnets
- AWS reserved 5 addresses for each subnet ( first 4 and last one)
- Example: 10.0.0.0/24 -> 
    - 10.0.0.0 is the Network Address
    - 10.0.0.1 is reserved for the VPC router
    - 10.0.0.2 is resrved for mapping AWS provided DNS
    - 10.0.0.3 is resrved for future use
    - 10.0.0.255 is typically the Broadcast Address. (AWS does not support broadcast addresses.)


## Private IP Address
- 10.0.0.0/8
- 172.16.0.0/12 - AWS Default VPC
- 192.168.0.0/16

## Internet Gateway - IGW
- allows resources within a VPC to connect to the internet
- scales horizontally and is redundant/highly available
- 1:1 relation with VPC
- in order to allow internet access
    * the instance must have a public IP address or elastic IP address
    * an IGW must be attached to the VPC
    * a route table associated with a subnet must have a route to the IGW. eg: 0.0.0.0/0 -> igw-id

## Bastion Hosts
- we use a bastion host to SSH into all of our private EC2 instances
- How to setup a bastion host:
    - create the bastion host in a public subnet
    - the bastion host's SG should alllow inbound SSH traffic from your IP address
    - the private EC2 instance's SG should allow inbound SSH traffic from the bastion host's SG
    - the bastion host should also have the SSH private key of the private EC2 instance configured.


## NAT Instance (Discontinued)
- allows EC2 instances within a private subnet to connect to the internet via a NAT instance
How to setup a NAT instance: 
    - create the NAT instance (using a pre-configured AMI) 
    - the NAT instance must be launched in a public subnet
    - the NAT instance must have a public IP address or elastic IP address
    - modify the NAT instance security group to include:
        - ALLOW HTTP/HTTPS traffic from private subnet
    - the NAT instance must have source/destination check disabled
    - the route table for the private subnet must have a route to the NAT instance's network interface ID. eg: 0.0.0.0/0 → eni-xxxxxxxx
    


        
- NAT Gateway must have an elastic IP address
- NAT Gateway must be launched in a public subnet
- route table associated with the private subnet must have a route to the NAT Gateway

## NAT Instance - Additional Notes
- Not highly available or resilient out of the box. You need to create an ASG + user-data script.
- Pre-configured Linux AMI reached end of standard support on Dec 31, 2020
- you must manage Security Groups and rules:
    - Inbound: Allow HTTP/HTTPS traffic coming from Private Subnets. Allow SSH from your home IP address.
    - Outbound: Allow HTTP/HTTPS traffic going to the internet.

## NAT Gateway
- AWS-managed NAT with higher bandwidth and higher availability
    - NAT Gateway is resilient within an Availability Zone
    - you must create multiple NAT Gateway's in multiple AZ's for high availability
    - no need for a failover since if an AZ is down , it doesn't need a NAT anyway.
- Pay per hour for usage and bandwidth
- created in a specific Availability Zone
- uses an Elastic IP address
- can't be used by EC2 instances in the same subnet
- requires an IGW (private subnet -> NAT GW -> IGW)
- 5GBps bandwidth with automatic scalin upto 100GBps
- No Security Groups required

## NAT instance vs NAT gateway:
https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-comparison.html

## Network Access Control List (NACL)
- is like a firewall at the subnet level
- they are stateless. ie both incoming and outgoing traffic is evaluated separately.
- 1:1 relation with Subnet. Every new subnet is associated with a default NACL
- default NACL:
    - allows all inbound and outbound traffic
- NACL rule:
    - rules have a number 1-32766 , 1 being the highest precedence (ie the number dictates order of processing)
    - first matched rule takes effect
    - the last rule is an * which is a default deny if no other rule matches
    - AWS recommends adding rules in incremenets of 100

- NACL is great for blocking specific IP addresses at the subnet level

## NACLs with Ephemeral Ports
https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html
Example: To allow a web server to connect to an RDS Database, 
- Web-NACL will ALLOW outbound TCP on port 3306
- DB-NACL will ALLOW inbound TCP on port 3306
- DB-NACL will ALLOW outbount TCP on port ranges 1024-65535
- Web-NACL will ALLOW inbound TCP on port ranges 1024-65535

## Security Groups vs NACLs

|Security Group|NACL|
|---|---|
|operates at the instance level |operates at the subnet level|
support ALLOW rules only | support ALLOW and DENY rules |
|Stateful|Stateless|
|ALL rules are evaluated before decision | first matched rule takes effect|


## VPC Peering
- privately connect two VPCs using AWS Network
- makes both VPC behave as if they were on the same network
- VPCs must not have overlapping CIDR blocks
- VPC Peering is NOT transitive
- you must update route tables in both VPCs to allow traffic between the VPCs
- you can create peering between two VPCs in different accounts/regions
- you can reference a Security Group in a VPC Peering connection (works across accounts within the same region)
- VPC Peering does NOT support edge-to-edge routing ie if one of the VPCs in the peering connection has one of the following connections, they cannot be extended to the other VPC:
    - A VPN or DX connection to a corporate network
    - an Internet connection through an IGW
    - an Internet connection in a private subnet via NATGW/NAT instance
    - a Gateway VPC Endpoint to an AWS service like S3


## VPC Endpoints
- VPC Endpoints (powered by AWS PrivateLink) allow you to connect to AWS services using a private network instead of using the public internet.
- they are redundance and scale horizontally
- they remove the need for IGW, NATGW etc to access AWS services
- in case of issues:
    - check DNS setting resolution
    - check routing tables

### Types of endpoints
- Interface Endpoints (powered by AWS PrivateLink)
    - provisions an ENI (private IP address) as the entry  point (must attach a Security Group)
    - supports most AWS Services
    - $ per hour + $ per GB of data processed

- Gateway Endpoints
    - provisions a gateway and must be used as a target in a route table (does not use a Security Group)
    - supports S3 and DynamoDB
    - free 

### Gateway vs Interface Endpoints for S3
- Since Gateway Endpoints are free, they are preferred for S3
- Interface Endpoints are preferred when access is required from on-premises (via Site to Site VPN or Direct Connect), a different VPC, or region.

### Lambda in VPC accessing DynamoDB
Option 1: Access from the public internet
- deploy a NAT gateway in a public subnet with an IGW
- not recommended

Option 2: Better and Free - Access from Private Network
- deploy VPC Gateway Endpoint for DynamoDB
- change route table


## VPC Flow Logs
- capture traffic entering and leaving your VPC, to help you monitor and troubleshoot network issues.
    - VPC Flow Logs
    - Subnet Flow Logs
    - ENI Flow Logs
- Flow Log:
    - srcaddr, dstaddr, srcport, dstport, action (success/failure due to NACL, SG)
- Flow logs can be sent to S3, CloudWatch Logs or Kinesis Data Firehose
- flow logs can be queried using Athena on S3, CloudWatch Logs Insights
- can capture network information from other AWS managed interfaces like ELB, RDS, ElastiCache, Redshift, Workspaces, NATGW, Transit Gateway etc.


## AWS Site-to-Site VPN
- create a secure connection between your VPC and on-premises network over the public internet.
- Virtual Private Gateway (VGW) 
    - is created in a VPC
    - it is possible to customize the ASN (Autonomous System Number)
- Customer Gateway (CGW) 
    - is created in on-premises
    - is a software or hardware device that provides a secure connection to your VPC
- CGW IP address can be public or private (behind a NAT)
- Route Propagation MUST be enabled for the Virtual Private Gateway
- If you need to ping your EC2 instance from on-premises, you need to ALLOW ICMP protocol on your inbound security group.

### AWS VPN CloudHub
- provide secure communication between multiple sites where you have VPNs.
- it's a low cost hub and spoke model
- you will have a single VGW and multiple CGWs

## Direct Connect (DX)
Provides a dedicated private connection from on-premises to AWS.

- you need to setup a `Private Virtual Interface (Private VIF)` on your VPC that connects to either a `Virtual Private Gateway (VGW)` or a `Transit Gateway (TGW)`
- **Note:** 
  - VIFs provide VLAN tagging and BGP peering.
  - VGW and TGW acts as routers.
  - For a single account/VPC use an VGW.
  - For multiple accounts/VPCs use a TGW.

- setup  a dedicated connection between your on-premises network and AWS Direct Connect location.
- allows you to access both public and private AWS services over the same connection
- Usecases:
    - increased bandwidth and lower costs when working with very large datasets
    - more consistent network experience when dealing with real-time applications
    - hybrid cloud 
- supports both IPv4 and IPv6

### Direct Connect - Connection Types
- Dedicated Connection
    - 1Gbps or 10Gbps or 100Gbps
    - physical ethernet line dedicated to customer
    - reuqest made to AWS first, then completed by AWS Direct Connect Partners

- Hosted Connection
    - 50Mbps, 500Mbps upto  10Gbps
    - connection requests are made via AWS Direct Connect Partner
    - capacity is shared with other customers
    - capacity can be added/removed on-demand

Lead times for setting up Direct Connect can be upto a month.

### Direct Connect - Encryption
Data in transit, although private is NOT encrypted. 
AWS DX + VPN provides an IP-Sec encrypted connection.

### Direct Connect - Resilience
High Resiliency can be achieved by setting up a single DX connection via multiple locations.

Maximum Resilience can be achieved by setting up multiple DX connections terminating on separate devices via multiple locations.

#### Site-to-Site VPN as a backup
In case DX fails, you can set up a Site-to-Site VPN as a cheaper backup.

## Transit Gateway
- you can have a 'transitive' peering with a hub and spoke model.
- supports peering:
    - VPCs, 
    - DX, 
    - CGW + VPN
    - on-premises networks.
- is a regional resource, but can work cross-region
- can be shared across account using Resource Access Manager (RAM)
- you can use route tables to limit which VPC can talk to each other.
- works with DX and VPN setups
- supports Multicast (only AWS service that supports it)

## AWS Resource Access Manager
- easily and securely  share AWS resources across accounts under your AWS Organizations
- centrally manage resources you own across your estate
- you can share:
    - transit gateways
    - subnets
    - AWS License Manager configurations
    - Amazon Route53 Resolver rules



## Using ECMP with Transit Gateway to increase VPN throughput
- Equal Cost Multi Path (ECMP) allows you to forward packets to multiple paths
- by connecting multiple VPNs to a Transit Gateway, you can use ECMP to increase bandwidth
- you pay for each GB of TGW bandwidth, so there is an added cost to this solution.

## Transit Gateway - share DX between multiple accounts
- you can share a DX connection between multiple acconts/VPCs by connecting a Direct Connect Gateway to a Transit Gateway and then connecting multiple VPCs to it.

## VPC Traffic Mirroring
- non-intrusively capture and inspect VPC traffic
- source ENI: where we want to capture traffic from
- target: an ENI or NLB 
- the source and target needs to be in the same VPC or if VPCs are peered they can be in different VPCs
- usecases: content inspection, threat monitoring, troubleshooting


## IPv6 in VPC
- IPv4 can never be disabled, but you can chose to operate in dual stack mode enabling support for both IPv4 and IPv6
- your EC2 instances will get a private IPv4 address and a public IPv6 address.
- both addresses can communicate with the internet over an IGW.
- Note: If you have dual stack enabled and your EC2 cannot launch, you can add a new IPv4 CIDR block to your VPC. (IPv6 is never going to get exhausted and hence is not going to be the bottleneck)

## Egress-only Internet Gateway
- similar to NATGW, but for IPv6
- allows outbound connection from your VPC to the internet over IPv6.
- you need to modify the route tables to route all outbound traffic to the egress-only IGW.
Example: 

A route table for a public subnet
```
Destination    Target
10.0.0.0/16    local
2001:db8::/32  local
0.0.0.0/0      igw-id
::/0           igw-id
```

A route table for a private subnet
```
Destination    Target
10.0.0.0/16    local
2001:db8::/32  local
0.0.0.0/0      nat-gw-id # NAT gateway will have a route to IGW
::/0           egress-only-igw-id 
```


