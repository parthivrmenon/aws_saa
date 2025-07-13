# AWS Regions

## Regions
cluster of data-centers
How to chose a region?
* Compliance: data governance and legal requirements
* Proximity: to customers to reduce latency
* Available services: new services and new features are not avialable in everyregion
* Pricing: varies from region-to-region

## Availability Zones
* each AZ is one or more discrete datacentgers with redunant power, netwroking connectivty
* seprate from each so that they are isolated from disasters
* Azs are connected with high bandwitch, ultra low latencynetworks
* many (usually 3-6) for every region
* eg: ap-southeast-2 -> ap-southesat-2a/b/c

## PoP
* 400+ rEdge locations and 10+ regional caches
* Edge-focused: closer to users, typically in ISPs' data centers.
* usually used to serve global services with low latency
* Global services
    IAM, ROute53, CloudFront, WAF

