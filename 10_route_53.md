# Route 53
a highly available, scalable. fully-managed DNS service
that you can use to manage your domains. (ie. Authoritative DNS server)
- it is also a Domain Registrar
- ability to check the health of your resources
- 100% availability SLA
- "Route 53" is a reference to traditional DNS port

## Route 53 - Records
eg: google.com.             300     IN      A       142.251.222.142
Each record contains:
- Domain/Subdomain Name - google.com.
- Record Type - A
- Value - 142.251.222.142
- Routing Policy
- TTL - Time to live (for caches)

Record Types: 
must know: A/AAAA/CNAME/NS
others: CAA/DS/MX/NAPTR/PTR/SOA/TXT/SPF/SRV

Note: You cannot create a CNAME for Apex domain

## Hosted Zone
Public Hosted Zone contains records that specify how to route traffic on the internet
Private Hosted Zone contains records that specify how you route traffic within one or more VPCs

Note: You pay 0.50$ per month per hosted zone

## Records TTL (Time To Live)
duration of time for which clients will cache a DNS record

## CNAME vs Alias
CNAME
- points a hostname to another hostname. eg: app.mydomain.com -> another.anything.com
- only for non-root or non-apex domains

Alias
- an extension to DNS functionality
- allows you to map a hostname to an AWS resource
- automatically recognizes changes in IP addresses
- same as CNAME in many respects, but works for root or apex domains as well
- type A/AAAA
- free of charge
- has a native health check
- cannot set a TTL
- can target ELB, CloudFront Distributions, API GW, Elastic Beanstalk, VPC Interface Endpoints, Global Accelerator accelerator
- Route 53 record in same Hosted zone
- NOTE: You cannot set an ALIAS record for an EC2 DNS name

## DNS Routing Policies
- Simple
    - used to route traffic to a single resource
    - can return multiple values in the same record ie. client-side load-balanced 
    - when Alias enabled, specify only one AWS resource
    - cannot be associated with Health-checks

- Weighted
    - can be used to load-balance traffic across regions or for testing
    - each record is assigned a 'relative' weight
    - traffic % = weight of record/ sum of weights of all records
    - ALL records must have same Name and Type
    - a record with weight 0 is never used in a response, however if all weights are 0 then all records are returned.

- Failover
    - Usecase: Active-Passive failover
    - Primary is associated with a Health Check (mandatory)
    - If Health Check fails, Route 53 responds with Secondary instance's IP.

- Latency based
    - redirect to resource that is closes to client
    - latency between AWS regions and uSers
    - can have health checks
    - records will have a Region

- Geolocation
    - serve records ubased on user location 
    - location can be specified using Continent, Country, State
    - If there is overlapping the most precise location is selected
    - a "default" record is served in case there is no match
    - Use Cases: website localization, restrict content distribution, load balancing
    - can be associated with Health Checks

- Multi-Value Answer
    - return multiple records
    - can be associated with Health Checks
    - upto 8 Healthy records
    - client-size loadbalancing

- Geoproximity (using Route 53 Traffic Flow feature)
    - Resources can be assigned a 'bias' (1 to 99, -1 to -99)
    - a bias controls the size of the region considered as within proximity
    - +ve values of bias increase the size, -ve values decrease it
    - users within the region of proximity are served that specific record
    - resources can be
        - AWS resources (specifiy AWS region)
        - Non-AWS resources (specify Latitude and Longitude)
    - NOTE: You must use Route 53 Traffic Flow (advanced) to use this feature
    - usecase: shift traffic based on geographic proximity
- IP-based Routing
    - provide a list of CIDRs and the corresponding endpoints/locations
    - optimize performance & reduce network costs
    - eg: route end-users from a particular ISP to a specific endpoint



## Health Checks
- typically for public resources
- usecase: automatic failover
- types:
    - monitor an endpoint (application, server, any other AWS resource)
    - monitor other health checks (Calculated Health Checks)
    - monitor CloudWatch Alarms (eg: throttles of DynamoDB ie. monitor private resources)
- integrated with Cloud Watch metrics

## Health Checks - Monitor an Endpoint
About 15 global health checkers will check endpoint health
- Healthy/UnHealthy Threshold ie nof of health checks that pass - 3 (default)
- Interval of 30 sec (can be set to 10 sec for higher cost)
- supports HTTP, HTTPs and TCP
- if 18% > of health checkers report healthy, endpoint is considerd healthy
- can chose which locations you want route 53 to use

Health checks pass only when the endpoint responds with 2XX or 3XX status codes
Health checks can parse text in the first 5120 bytes of the response
NOTE: router/firewall should allow incoming requests from Health Checkers

## Health Checks - Calculated Health Checks
combine results of multiple Health CHecks into a single Health Check
can use OR, AND, NOT to combine them
can monitor upto 256 Child Health Checks
Specify how many of the childs health checks need to pass to make parent pass
Usage: perform maintenance to your website without causing all health checks to fail

## Health Checks - CLoudWatch metrics
usecase: Monitor private resources
create a CloudWatch Metric and associate CloudWatch Alarm, then create a Health Check that checks the alarm itself



