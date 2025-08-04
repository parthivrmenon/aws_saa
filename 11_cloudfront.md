# CloudFront
is a managed Content Delivery Network (CDN)
* [Usecases](#usecases)
* [Edge Network](#edge-network)
* [Origins](#origins)
    * [S3](#s3)
    * [VPC](#vpc)
    * [Custom Origin](#custom-origin)
* [Geo Restriction](#geo-restriction)
* [Price Classes](#price-classes)
* [Cache Invalidation](#cache-invalidations)
* [AWS Global Accelerator](#aws-global-acceleratorlo)
* [AWS Global Accelerator vs CloudFront](#aws-global-accelerator-vs-cloudfront)

## Usecases
- improve read performance and user experience
- DDoS protection (integration with Shield, AWS Web Application Firewall)




## Edge Network
conisists of 216 Points of Presence across the globe that can be used as an edge location to serve content from

## Origins
### S3
- for distributing files and caching them at the edge
- for uploading files to S3 through Cloudfront
- secured using OAC - Origin Access Control

### VPC
- to deliver content from applications hosted in VPC private subnets
- can deliver traffic to 
    * ALB
    * NLB
    * EC2 instances

### Custom Origin
- S3 website (must enable bucket as a static S3 website)
- Any public HTTP backend

## Geo Restriction
You can resist who can access your distribution
- Allowlist: allow users to access content if they are in one of the countries on a pre-approved list
- Blocklist: deny users if they are from a list of banned countries
- 'country' is determined using a 3rd party Geo-IP database
- usecase: Copyright Laws to control access to content

## Price Classes
1. Price Class All: all regions - best performance
2. Price Class 200: most regions, but excludes most expensive regions
3. Price Class 100: only the least expensive regions

## Cache Invalidations
can force an entire (\*) or partial (/images/*) cache refresh to bypass TTL

## AWS Global Accelerator
- 2 `Anycast IP` are created for your application
- the Anycast IP will send traffic directly to Edge locations closest to them
- Edge locations will leverage AWS internal network to route traffic to your application
- works with Elastic IP, EC2, ALB, NLB, private or public
- Consistent Performance
    - intelligent routing to lowest latency edge
    - fasy regional failover
    - client-facing IPs don't change
- Health Checks
    - performs checks against your application
    - failover takes less than 1m for unhealthy applications
    - great for Disaster Recovery
- Security
    - only 2 external IPs needs to be whitelisted
    - DDoS protection thanks to AWS Shield

## AWS Global Accelerator vs CloudFront
Similarities:
- both use AWS Global network and its Edge locations
- both integrate with AWS Shield for DDoS protection

CloudWatch
- improve performance for cacheable content (such as images/videos)
- content is served from the Edge

Global Accelerator
- improve performance for wider range of applications over TCP/UDP
- proxies packets at the edge to applications running on one or more AWS Regions
- good fit for non-HTTP use cases such as gaming (UDP), IoT (MQTT) or VoIP
- good for HTTP usecases that require static IP addresses
- good for HTTP usecases that require deterministic, fast regional failover