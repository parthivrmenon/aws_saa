# Amazon EC2

Elastic Cloud Compute let's you launch a Linux/Win/Mac based virtual machine. 



Capabilities
* Rentint Vms
* Virtual drives EBS
* Load distribution ELB
* Auto-scaling groups ASG

## Sizing & Configuration
* OS: Linux, Win, MacOS
* How much compute power & no of cores CPU
* How much random access memory RAM
* storage: 
    * EBS, EFS
    * EC2 Instance store
* Network card: speed, public IP address
* Firewall rules: Security Group
* Bootstrap script (configure at first launch) EC2 User Data

## EC2 User Data
* automate boot tasks like
    * install updates/softwares
    * runs with root user (sudo)

# EC2 -  Instance Type
* Instance Names -> m5.2xlarge
    * m: instance class
    * 5: generation
    * 2xlarge: size within instance class
* General Purpose (t' and m')
* Compute Optimized (c')
* Memory Optimized (r')
* Storage Optimized (d')
* Accelerated Computing (p-type and g-type)

## Security Groups
* controls how traffic is allowed in or out of EC2 instances
* locked down to region/VPC
* only contain 'allow' rules
* can reference by IP or by SecurityGroup
* Many to Many relationship between SG and EC2
* lives 'outside' EC2 instance; you would see a 'timeout' not 'connection refused'
* by default all inbound is blocked, all outbound access is allowed

## Classic ports to know
* 22 = SSH (Secure Shell) (log into Linux instance)
* 3389 - RDP (log into Win instance)
* 21 = File Transfer Protocol
* 22 = SFTP (Secure FTP)
* 80,443 = HTTP/HTTPs

# EC2 -  Purchase Options
|Purcahse Option|Cost|Commitment|Upfront Payment|Recommended For|Limits|Other Notes|
|---|---|---|---|---|---|---|
On-Demand|Highest cost; pay-per-use|No|No|Short un-interrupted workloads where app behavior cannot be predicted|vCPU limit per region per instance type|-|
Reserved Instances|upto 72% discount; reserved|Yes (1-3 years)|Yes/Partial|Steady-state long running usage patterns like a database|20 per region|Convertible Reserved Instances (can change type, instance family, OS, scope etc) but you get less discount than Reserved.|
Savings Plans|upto 72% discount; reserved + pay-per-use|Yes (1-3 years)|Yes/Partial|Steady-state long running workloads that don't need capacity reservation and requires flexibility within an instance family|None|locked in to a specific instance family but can change size, OS and tenancy|
Spot Instances|upto 90% discount|No|No|Fault-tolerant workloads|Dynamic Spot limit per region|-|

### On-Demand instances
Pay for what you use. 

For `Linux/Windows` instances you are `billed per second`, after the first minute.
For other OS's you are `billed per hour`.

* has the `highest cost` but `no upfront payment` or `long-term commitment`

* Recommended for `short un-interrupted workloads where app behavior cannot be predicted`

* has a `vCPU limit per region per instance type` which can be increased by submitting a request.

### Reserved Instances
You can `reserve` a specific instance type, region, tenancy, OS allowing you to get upto `72% discounts`.

The reservation period is `1 to 3 years`.

You can purchase Reserved Instances in the following ways : `No Upfront`, `Partial Upfront`, `All Upfront`.

Discount increases with increased commitment.

Recommended for `steady-state long running usage patterns` like a database.

You can `buy/sell Reserved Instance Marketplace`.

You are limited to `20 Reserved Instances per region`.

#### Convertible Reserved Instances
can `change type, instance family, OS, scope etc` but you get `less discount than Reserved`.

### Savings Plan
same discount as Reserved Instance but instead of reserving an instance, you `commit to certain type usage pattern`

Example: `commit to $10/hr for 1 or 3 years`.

Usage beyond the plan is billed at On-Demand price.

You are locked to a specific `instance family`, but you can change the size, OS and tenancy.

### Spot Instances 
You can `bid for unused capacity`.

You can get `up to 90% discount` on On-Demand price. These are the most cost-efficient.

You can lose any point of time if max price is less than current cost price

Recommended for `fault-tolerant (batch jobs, data analysis)`

Limit: dynamic spot limit per region.

### Dedicated Hosts
You can `book a whole physical server`.
Recommended when you have `compliance requirements and use your existing server bound licenses (BYOL)`
You have two Options:
    * On-Demand
    * Reserved
    * The most expensive

### Dedicated Instances
You can `run on hardware dedicated to you`.
    * share hardware within same account
    * no control on hardware
    * no other customers will share your hardware

### Capacity Reservations
You can `reserve capacity in a specific AZ for any duration`.There is `no time commitment` , `no billing discounts`

You can `combine with Regional Reserved Insances and Savings plan`

You are `charged at On-Demand whether you run or not`

Recommended for `mission-critical workloads with short-term usage`

# CloudWatch Metrics for EC2
### AWS provided metrics
by default, AWS provides CPU, Network, Disk and Status Check metrics for your instances.

Basic Monitoring (default) collects these metrics at 5 min interval.
You can enable Detailed Monitoring to collect metrics at 1 min interval but this is a paid feature.

### Custom metrics
If you want additional metrics like Memory Utilization, you can use CloudWatch Agent to collect and send custom metrics to CloudWatch.
You can have Basic resolution (1min) or High resolution (upto 1 second).

## Spot Instances
Define max spot price and get instance while current spot price < max
hourly sport price varies based on offer and cap
if sport price > max
    - stop or teminate (2 min grace)
Spot Block
- block for 1-6 hours wihout interruptions
- NOTE: when stopping Spot Instances for good, first make sure the Spot Request is cancelled

## Spot Fleets
* set of Spot Instances + (optional) On-Demand Instances
* The Spot Fleet will try to meet the target capacity with price constraints:
    * Define possible launch pools: instance types, OS, AZs
    * can have multiple launch pools to choose from
    * Spot Fleet stops launching instances when reaching capacity or max cost
* Strategies to allocate Spot Instances:
    * lowestPrice: from the pool with lowest price(cost optimization)
    * diversified: distribute across all pools (availability)
    * capacityOptimized: pool with optimal capacity for number of instances
    * priceCapacityOptimized(recommended): pools with highest capcaity, then select the pool with the lowest price (best choice for most workloads)

## Elastic IP
fixed public IPv4 address for your EC2 instance
you can remap EIP across instances within your account
can only have 5 EIPs per region per account ( you can ask AWS to increase)
can attach to one instance at a time

## Placement Group
* cluster - clustred in a low latency group in a single AZ
* spread - spread across different hardware (max 7 instances per group per AZ) - Critical Apps
* partition - spreads instances across partitions (which rely on different racks) within AZ. Scales to 100s of Ec2 instancces per group (Hadoop, Cassandra, Kafka)

## Cluster
* 10Gbps bandwidth between instances; low latency
* No fault tolerance; single AZ
* useful for BigData jobs, apps that need extreme low latency

## Spread
* high fault-tolerance; across AZs; across physical hardwares
* limited to 7 instances/AZ/placement group
* applications that require maximized HA; failure isolation from each other

## Partition
* upto 7 partitions per AZ
* each partition sits on one rack
* Each partition can have multiple EC2s
* upto 100s of EC2 instances
* partitions are isolated from failure
* EC2 can access partition info with metadata service
* HDFS, Cassandra, Kafka

## Placement Groups Comparison
|Feature|Cluster|Spread|Partition|
|---|---|---|---|
|Throughput|Highest|Average|High within a partition|
|Fault Tolerance|Lowest|Highest|High|
|Max Instances/AZ|Unlimited|max 7 instances|max 7 partition but each partition can have hundreds of instances|
|Recommended for|High performance computing, BigData|High availability, mission-critical|Distributed and replicated workloads, cassandra, kafka, HDFS|

## Elastic Network Interface (ENI)
A virtual network card
* logical component within a VPC
* bound to an AZ
* instance-agnostic: can be detached and attached to different instances
* useful for fast failovers within an AZ
* An ENI can have:
    * 1 Primary private IPv4 address (Mandatory)
    * 1 or more secondary IPv4 addresses (Optional)
    * 1 EIP (IPv4) tied to the primary private IPv4 address (optional)
    * One or more Security Groups
    * a MAC address
* bound to a specific AZ
* https://aws.amazon.com/blogs/aws/new-elastic-network-interfaces-in-the-virtual-private-cloud/

## EC2 Hibernate
* RAM is preserved; RAM state is written to a file in root EBS volume
* boot is faster as OS is not stopped/restarted
* ie: root EBS must be envrypted and have enough space to contain the RAM state
* does not support instance store?
* long-running processes that should never be stopped
* speed up boot time
* cannot be hibernated for more than 60 days
