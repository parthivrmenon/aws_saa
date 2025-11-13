# AWS Regions and Availability Zones

## Concepts
* A `Region` is a separate geographic area.
* `Availability Zone` (AZs) are isolated locations within each Region.
* `Local Zones` provide you the ability to place resources, such as compute and storage, in multiple locations closer to your end users.
* `Wavelength Zones` allow developers to build applications that deliver ultra-low latencies to 5G devices and end users. Wavelength deploys standard AWS compute and storage services to the edge of telecommunication carriers' 5G networks.

## Regions
cluster of data-centers
How to chose a region?
* Compliance: data governance and legal requirements
* Proximity: to customers to reduce latency
* Available services: new services and new features are not avialable in everyregion
* Pricing: varies from region-to-region

## Availability Zones
Each `region` has at least 3 `AZs`.

An `AZ` has one or more discrete datacentgers with redunant power, networking connectivty separated from each other so that they are isolated from disasters.

AZs are connected with high bandwitch, ultra low latencynetworks.

## PoP
AWS operates a global network of Points of Presence (PoPs) to provide fast, reliable, and secure access to AWS services like CloudFront. S3, Route53, IAM, WAF etc.

