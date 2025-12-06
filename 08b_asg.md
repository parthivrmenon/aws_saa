# Auto-Scaling Groups (ASG)
An Auto Scaling group is a logical grouping of EC2 instances that allows you to use Auto-scaling features.

## Health Checks
All instances in an ASG start with a health check status of "Healthy". An ASG can receive notifications that an instance is unhealthy from various sources:
* from Amazon EC2
* ELB
* VPC Lattice
* Amazon EBS
* Custom Health checks defined by user

### ASG: ASG may not mark an instance as unhealthy even if a Health Check fails..
- `Health Check Grace Period` has not expired
- `Suspended Processes` list contains HealthCheck, ReplaceUnhealthy, Launch or Terminate
- Instance is in `impaired` status and is still recovering
- Instance is in `not in InService` state.
- Waiting for `ELB connection draining` to complete
- If the failed Health Check is an `ELB Health Check` and Health Check Type is set to EC2 Health Check

## Scaling
### Maintain a fixed number of EC2 instances (default)
The default for an Auto Scaling group is to not have any attached scaling policies or scheduled actions, which causes it to maintain a fixed size.

### Scale manually
You can manually adjust the number of EC2 instances in your Auto Scaling group at any time. Manual scaling is an alternative to auto scaling, especially if you want to make one-time capacity changes.

### Scale based on a schedule
With scheduled scaling, you can set up automatic scaling for your application based on predictable load changes. You create scheduled actions that increase or decrease your group's desired capacity at specific times.
Example:
- On Wednesday morning, one scheduled action increases capacity by increasing the previously set desired capacity of the Auto Scaling group.

- On Friday evening, another scheduled action decreases capacity by decreasing the previously set desired capacity of the Auto Scaling group.

You can use scheduled scaling and scaling policies together to get the benefits of both approaches to scaling. After a scheduled scaling action runs, the scaling policy can continue to make decisions. Current capacity must fall within the minimum and maximum capacity that was set by your scheduled action.

### Scale dynamically based on demand
Amazon EC2 Auto Scaling supports the following types of dynamic scaling policies:

#### Target tracking scaling
Increase and decrease the current capacity of the group based on a Amazon CloudWatch metric and a target value. It works similar to the way that your thermostat maintains the temperature of your home—you select a temperature and the thermostat does the rest.

**Example:**
Maintain an average CPU usage of 50%

#### Step scaling
Increase and decrease the current capacity of the group based on a set of scaling adjustments, known as step adjustments, that vary based on the size of the alarm breach.

**Example:**
- If the average CPU usage of your Auto Scaling group exceeds 70%, add 2 EC2 instances to the group.
- If the average CPU usage of your Auto Scaling group exceeds 80%, add 4 EC2 instances to the group.

##### Instance Warm-Up:
Both `Step-Scaling` and `Target tracking` scaling use the instance warm-up period to prevent premature scale-in actions.
ASG ignores new instances and their metric contributions until the warm-up period is expired. This helps prevent premature Scale-In. Defaults to 300 seconds.



#### Simple scaling
Increase and decrease the current capacity of the group based on a `single` scaling adjustment, with a `cooldown period` (default is 300 seconds) between each scaling activity.

**Example:**
- If the average CPU usage of your Auto Scaling group exceeds 70%, add 2 EC2 instances to the group.

##### Cooldown Period
- The cooldown period is the amount of time, in seconds, after a scaling activity completes before another scaling activity can start. 
- The default cooldown period is 300 seconds.
- Cooldown period prevents premature scaling activities

### Scale proactively
Predictive scaling works by analyzing historical load data to detect daily or weekly patterns in traffic flows
Predictive scaling is well suited for situations where you have:

Cyclical traffic, such as high use of resources during regular business hours and low use of resources during evenings and weekends

Recurring on-and-off workload patterns, such as batch processing, testing, or periodic data analysis

Applications that take a long time to initialize, causing a noticeable latency impact on application performance during scale-out events


## Scaling activities
### Scale-Out
- Always launch new instances in AZs with the fewest instances. 
- If there are multiple AZs with the same number of instances, it will try to break the tie using Allocation Strategy

#### Allocation Strategies:
- On-Demand Allocation Strategy: 
    - `lowest-price` - select pools with highest cost efficiency
    - `prioritized` - provided as a list by user in launch template overrides.

- Spot Allocation Strategy
    - `price-capacity-optimized` (recommended) - select pools which are least likely to be interrupted + has lowest price

    - `capacity-optimized` - select pools with highest available capacity (least likely to be interrupted)
    - lowest price - more prone to interruptions, but costs less.
    - `capacity-optimized-prioritized` -  launch in pools with highest available capacity, but with priority list provided by user once a pool is chosen

### Scale-In - Termination Policy:
`Default` Termination Policy:
1. Choose AZ with the most instances
2. Within an AZ choose an instance based on (in order):
    * outdated configuration (oldest launch template/launch configuration)
    * closes to the next billing hour
    * chose random

Other Termination Policies:
- OldestInstance
- NewestInstance
- OldestLaunchTemplate
- OldestLaunchConfiguration
- ClosestToNextInstanceHour
- AllocationStrategy



## Rebalancing activities
### Availability Zone Rebalancing
Your ASG can become unbalanced between Availability Zones when:
- You change the AZ association of your ASG
- You explicitly terminate or detach or place instances in standby
- An Availability Zone that previously had insufficient capacity recovers and now has additional capacity.
- An Availability Zone that previously had a Spot price above your maximum price now has a Spot price below your maximum price.

When rebalancing, Amazon EC2 Auto Scaling launches new instances before terminating the earlier ones. This way, rebalancing does not compromise the performance or availability of your application.

### Capacity Rebalancing (Spot Instances)
- When using Spot Instances, you can turn on Capacity Rebalancing. 
- This lets Amazon EC2 Auto Scaling attempt to launch a Spot Instance whenever Amazon EC2 reports that a Spot Instance is at an elevated risk of interruption. After launching a new instance, it then terminates an earlier instance



### Others [not refined]
Scale out/in to match increased/decreased load
* ensure we have a min and max number of EC2 instances running
* automatically register new instances to a load-balancer
* re-create EC2 instances that are terminated.
* free (only pay for the underlying EC2 instances)
* Attributes
    * A Launch Template:
        - AMI + Instance Type
        - EC2 User Data
        - EBS Volume
        - Security Groups
        - SSH Key Pair
        - IAM Roles for EC2 instances
        - Network + Subnet Information
        - Load Balancer Information
    * Min/Max/Initial Capacity
* Autoscaling
    * can be integrated with CloudWatch alarms
    * An alarm monitors a metric such as Avg CPU or a custom metric
    * Metrics such as Average CPU are computed for the overall ASG instances
* Scaling Policies
    * Dynamic
        * Target tracking scaling
            * set a target like ASG CPU should stay at around 40%
        * Simple/Step Scaling
            * When a cloudwatch alarm is triggered (eg: CPU > 70%), then add 2 units
            * When a cloudwatch alarm is triggered (eg: CPU < 30%), then remove 1
    * Scheduled Scaling
        * anticipate based on known usage patterns.
        * eg: increase the min capacity to 10 at 5PM on Fridays
    * Predictive Scaling
        * continuously forecast load using historical load trends
        * scale ahead of time 
* Good metrics to scale on
    - Average CpuUtilization across instances
    - Average RequestCountPerTarget 
    - Average Network bytes In/Out 
    - Any custom metric

* Scaling Cooldown
    - after a scaling activity, the ASG waits a cooldown period
    - default is 300 seconds
    - during ASG will not scale-out/in
    - to allow for metrics to stabilize
