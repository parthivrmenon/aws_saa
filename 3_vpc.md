# Virtual Private Cloud
logically isolated virtual network
You typically use a VPC to
- directly launch EC2 instances in them 
- Elastic Network Interface (ENI) to attach to compute instances like EC2, Lambda, ECS etc

## Core Components
- Internet Gateway (IGW): a gateway that connects your VPC to the Internet
- Virtual Private Gateway (VPN Gateway): a gateway that connects yours VPC to a private external network
- Route Table: determines where to route traffic within a VPC
- NAT Gateway: allows private resources to connect to services outside of VPC over IPv4 (not needed for IPv6)
- Network Access Control Lists (NACLs): stateless virtual firewall for compute within a VPC. Operates at the subnet level with allow and deny rules
- Security Groups (SG): stateful virtual firewall for compute within a VPC. OPerates at instance level with allow rules.
(Technically NACLs and SGs are EC2 components)
- Public Subnets : allow instances to have public IP addresses
- Private Subnets: disallow instances to have public IP addresses
- VPC Endpoints: privately connect to AWS support services
- VPC Peering: connecting one VPC to another
- Transit Gateway?

## Key Features
* VPCs are region-specific. (However you can use VPC Peering to get around that by connecting different VPCs together)
* You can create upto 5 VPCs per region (adjustable)
* Every region comes with a default VPC
* Upto 5 IPv4 or IPv6 CIDR blocks per VPC (adjustable to 50)
* Most components cost nothing: VPCs, Route Tables, NACLs, Interet Gateways,SGs,Subnets, VPC Peering..
* Some things cost money: NAT Gateway, VPN Gateway, VPC Endpoint, IPv4 addresses, Elastic IPs
* DNS Hostnames: turn on DNS names for instances


