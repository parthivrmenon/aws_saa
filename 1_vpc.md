# Virtual Private Cloud (VPC)
A `VPC` is a logically isolated virtual network that you can define which spans all `Availability Zones` (AZs) in a region.
A VPC closely resembles a private network in your datacenter.

## VPCs and Subnets
A `Subnet` is a range of IP addresses in your VPC. You launch AWS resources, such as Amazon EC2 instances, into your subnets. You can connect a subnet to the internet, other VPCs, and your own data centers, and route traffic to and from your subnets using route tables.

## Default VPC
All new AWS accounts comes with a default VPC in each region. A default VPC has:
- one Public subnet in each AZ
- an IGW 
- DNS resilution enabled

All EC2 instances are launched in the default VPC if no other VPC is specified and get both a private and public IP address along with DNS names.


## Network ACLs
A network access control list (NACL) allows or denies specific inbound or outbound traffic at the subnet level. NACLs are stateless and are enforced at the subnet level during ingress and egress.

Rules are evaluated in order, starting with the lowest numbered rule, when deciding whether allow or deny traffic. If the traffic matches a rule, the rule is applied and we do not evaluate any additional rules. 

Each subnet in your VPC must be associated with a network ACL. If none are specified, the default network ACL is used.
The default network ACL allows all inbound and outbound traffic.

You can create a custom network ACL and associate it with a subnet to allow or deny specific inbound or outbound traffic at the subnet level.

You can associate a network ACL with multiple subnets. However, a subnet can be associated with only one network ACL at a time. When you associate a network ACL with a subnet, the previous association is removed.

## Security Groups
A security group controls the traffic that is allowed to reach and leave the resources that it is associated with. For example, after you associate a security group with an EC2 instance, it controls the inbound and outbound traffic for the instance.

Security groups are stateful. For example, if you send a request from an instance, the response traffic for that request is allowed to reach the instance regardless of the inbound security group rules.

## Route Tables
A route table contains a set of rules, called routes, that are used to determine where network traffic from your VPC is directed. You can explicitly associate a subnet with a particular route table. Otherwise, the subnet is implicitly associated with the main route table.

Each route in a route table specifies the 
- `destination` - range of IP addresses where you want the traffic to go and
- `target` - gateway, network interface, or connection through which to send the traffic.


## Internet Gateway
An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet.

If a subnet is associated with a route table that has a route to an internet gateway, it's known as a `public subnet`. 

If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a `private subnet`.

To enable communication over the internet for IPv4, your instance must have a public IPv4 address. You can either configure your VPC to automatically assign public IPv4 addresses to your instances, or you can assign Elastic IP addresses to your instances. 

The internet gateway logically provides the one-to-one NAT on behalf of your instance, so that when traffic leaves your VPC subnet and goes to the internet, the reply address field is set to the public IPv4 address or Elastic IP address of your instance, and not its private IP address. Conversely, traffic that's destined for the public IPv4 address or Elastic IP address of your instance has its destination address translated into the instance's private IPv4 address before the traffic is delivered to the VPC.

## NAT Gateway
A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services can't initiate a connection with those instances.

When you create a NAT gateway, you specify one of the following connectivity types:
- `Public` – (Default) Instances in private subnets can connect to the internet through a public NAT gateway, but the instances can't receive unsolicited inbound connections from the internet. 

You create a public NAT gateway in a public subnet and must associate an Elastic IP address with the NAT gateway at creation. You route traffic from the NAT gateway to the internet gateway for the VPC. Alternatively, you can use a public NAT gateway to connect to other VPCs or your on-premises network. In this case, you route traffic from the NAT gateway through a transit gateway or a virtual private gateway.

- `Private` – Instances in private subnets can connect to other VPCs or your on-premises network through a private NAT gateway, but the instances can't receive unsolicited inbound connections from the other VPCs or the on-premises network. 

You can route traffic from the NAT gateway through a transit gateway or a virtual private gateway. You can't associate an Elastic IP address with a private NAT gateway. You can attach an internet gateway to a VPC with a private NAT gateway, but if you route traffic from the private NAT gateway to the internet gateway, the internet gateway drops the traffic


## Use with other AWS services
### Private Link (VPC Endpoints)
AWS PrivateLink establishes private connectivity between virtual private clouds (VPC) and
* supported AWS services
* services hosted by other AWS accounts,
* on-premises resources

One of the key benefits of using AWS PrivateLink is the ability to establish secure, private connectivity without the need for traditional networking constructs like internet gateways, NAT devices, or VPN connections. 

#### VPC Endpoints
Interface, Resource, Service network, and Gateway Load Balancer endpoints are powered by AWS PrivateLink and use an Elastic Network Interface (ENI) as an entry point for traffic destined to the service. Interface endpoints are typically accessed using the public or private DNS name associated with the service. Resource endpoints connect to resources like RDS databases, and Service network endpoints connect to VPC Lattice services or service networks.

Gateway endpoints provide reliable connectivity to Amazon S3 and DynamoDB without requiring an internet gateway or a NAT device for your VPC. Gateway endpoints do not use AWS PrivateLink.




