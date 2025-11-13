# AWS CloudFront
is a managed Content Delivery Network (CDN)

## Usecases/Benefits:
- improve user experience as content is served from the closest edge location
- DDoS protection (integration with Shield, AWS Web Application Firewall)

## Distribution
You create a `distribution` to tell where the content is delivered from. The distribution uses the edge locations to serve content from. You can create 
- `standard distribution` to host a single website 
- `multi-tenant distribution` to host multiple websites - typically used by SaaS providers.

## Origins
#### S3 Origin
- for distributing files and caching them at the edge
- for uploading files to S3 through Cloudfront (using Cloudfront signed URLs or signed cookies  )
- secured using OAC - Origin Access Control (all requests via Cloudfront are signed and you setup bucket policies to trust these requests.)

#### VPC Origin
- to deliver content from applications hosted in VPC private subnets
- can deliver traffic to 
    * ALB
    * NLB
    * EC2 instances

#### Custom Origin
- S3 website (must enable bucket as a static S3 website)
- Any public HTTP backend.

### Cloudfront vs S3 cross-region replication
|Cloudfront|S3 Cross-Region Replication|
|---|---|
|leverages the Global Edge Network| Replication should be setup independently for each region|
|Files are cached for a TTL| Replication in near real-time|
|good for static content| good for dynamic content|

## AWS CloudFront - ALB or EC2 as Origin (using VPC Origin)
allows you to deliver content from your applications hosted on your VPC's private subnets without exposing them to the public internet.

## Geo Restriction
You can restrict who can access your distribution
- Allowlist: allow users to access content if they are in one of the countries on a pre-approved list
- Blocklist: deny users if they are from a list of banned countries
- 'country' is determined using a 3rd party Geo-IP database
- usecase: Copyright Laws to control access to content


## Pricing
CloudFront charges you for 
- `data transfers` out from it's `edge locations` along with HTTP/HTTPS `requests`.
You are `not charged for data transfer from origin to edge` locations when using AWS Origins

### CloudFront - Price Classes
The cost of data out varies based on the region of the edge location and total data transfer out.
You pay less per unit data the more data you transfer out.

You can reduce the cost by reducing the number of edge locations:

1. Price Class All: all regions - best performance
2. Price Class 200: most regions, but excludes most expensive regions
3. Price Class 100: only the least expensive regions


## Cache Invalidation
- by default Cloudfront respects Cache-Control headers sent by Origin (this setting can be toggled)
- if no Cache-Control headers are sent by Origin, Cloudfront will use the default TTL
- minimul TTL and maximum TTL can be configured to override the default TTL (and any cache headers from origin)
- by default, content is refreshed only after the TTL expires
- bypass TTL by using Cloudfront Invalidation.
    - full (\*)  
    - partial (/images/*)

## Exam - AWS Cloudfront Signed URLs and Signed Cookies
Many companies want to restrict access to certain content to specific users (eg: Paid subsribers). To do this you could you can use Cloudfront Signed URLs or Signed Cookies.

### Signed URL vs Signed Cookie
|Feature|Signed URL|Signed Cookie|
|---|---|---|
|Access control granularity|Per Object|Multiple Objects/Path|
|Client Type| Any HTTP client|Requires Browser support (cookies)
|Mechanism|A generated signed URL is distributed to the user|Cookie with additional attributes
|Best suited for| single file downloads, APIs, mobile clients that require access to a few resources|Web Apps that require to access multiple objects once authenticated

** Note: RTMP (Adobe's Real-Time Messaging Protocol) - an older way used for streaming video/audio cannot use Cookies



|Use Case|Single object access|Multiple object access|
|URL Format|Long, complex URL with signature|Shorter URL with cookie|
|Security|URL contains signature|Cookie contains signature|
|Expiration|URL has expiration time|Cookie has expiration time|

## AWS Global Accelerator
- 2 global Anycast IP are created for your application
- the Anycast IP will send traffic directly to Edge locations closest to them
- Edge locations will leverage AWS internal network to route traffic to your application
- works with Elastic IP, EC2, ALB, NLB (private or public)
- Consistent Performance
    - intelligent routing to lowest latency edge
    - fast regional failover
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
- both leverage Global Network and Edge Locations
- both integrate with AWS Shield for DDoS protection

Differences:
|CloudFront|Global Accelerator|
|---|---|
|improves performance for both static content (images, videos) and dynamic content (API acceleration)|improves performance for wider range of applications over TCP/UDP|
|best suited for Content Delivery|best suited for Application Delivery Optimization|
|HTTP/HTTPS|non HTTP usecases like Gaming(UDP), IoT(MQTT), VoIP| 
|Content is served from the Edge usually (Caching)|Proxies packets to the Application|
|Dynamic IP|Static IP (for HTTP usecases) or for fast regional failover|














