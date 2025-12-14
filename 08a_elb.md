# Elastic Load Balancer (ELB)
*a managed loadbalancer service with out-of-the-box integration with many other AWS offerings/services*

**Features:**
* uses Health Checks to judge downstream server (EC2) availability (200 OK)
* eg: protocol:HTTP; Endpoint: /health; Port:4567 
* Types:
    * CLB,2009 (deprecated) -> Classic (v1/Old Generation); 2009 [HTTP, HTTPS, TCP, SSL]
    * ALB, 2016 -> (v2/NewGen) - 2016 [HTTP, HTTPS, WebSocket]
    * NLB,2017 -> v2/NewGen - TCP, TLS, UDP
    * GWLB,2020 -> operates at layer 3 (Network Layer) - IP Protocol
* private/public

## ELB Types
|Type|OSI Layer|Protocols|Features|Cross-Zone|Static IP/EIP|
|--|--|--|--|--|--|
ALB|Layer 7|HTTP/HTTPS, WebSocket|Path-based routing, Container routing, TLS termination|Default|No
NLB|Layer 4|TCP/UDP/TLS|Low latency routing|Optional|Yes
GWLB|Layer 3|IP|Transparent network gateway|Optional|No

## Application Load Balancer
- OSI Layers: Layer 7 (Application Layer)
- Protocols: HTTP/2, WebSocket
- Cross-zone loadbalancing: Default; no additional charges
- Features:
    - hostname, path-based, query-based routing
    - container routing (for Docker, ECS)
    - HTTP/HTTPs redirects and TLS termination
    - full-proxy (client IP,Port,Protocol injected into X-Forwarded-For, X-Forwarded-Port, X-Forwarded-Proto)
    
- Target Groups: 
    - EC2 instances (managed by ASGs)
    - IP addresses
    - Lambda functions
    - ECS tasks (via port mapping)
- Static IP/Elastic IP: No


## Network Load Balancer (NLB)
- OSI: Layer 4
- Protocols: TCP/UDP 
- Cross-zone loadbalancing: Optional; additional charges
- Features:
    - low latency routing
- Targets Groups:
    - EC2 
    - Private IP Addresses
    - ALB
- Static IP/Elastic IP: Yes

## Gateway Load Balancer (GWLB)
- OSI: Layer 3 (Network layer)
- Protocol: IP
- Cross-zone loadbalancing: Optional; additional charges
- Features:
    - transparent network gateway
    - load balance traffic across virtual appliances
    - Use GENEVE protocol on port 6081
- Target Groups:
    - 3rd party virtual appliances
        - EC2
        - IP addresses - Private IPs
- Static IP/Elastic IP: No


## Session Affinity
Application Load Balancer supports two types of cookies:
- Application-based Cookies
    - custom cookies created by the application
    - can be named anything (except AWSALB, AWSALBAPP, AWSALBTG)
    - can include any custom attributes
    - name must be specified individually for each target group
    - don't use reserved names like AWSALB, AWSALBAPP, AWSALBTG
- Duration-based Cookies
  - ALB generates its own cookie called "AWSALB"
  - Cookie TTL is configurable - 1s to 7d
  - If not specified, uses the default TTL of 60 seconds

Network Load Balancer supports: 
- Client IP Affinity:
    - same client IP is routed to same target listener (TCP/UDP/TLS)
    - Stickyness duration can be upto 1d.
    - affinity is per target group.

## Transport Layer Security (TLS)
in-flight encryption between clients and loadbalancer. 
X509 and PKI?
ELBs support TLS termination
x509 certificates can be managed by ACM (AWS Certificate Manager)
* multi-domain support and SNI for multiple certs?
* can support legacy clients (older SSL/TLS versions)
* Server Name Indication (SNI):
  - allows ELB (listener) to serve multiple TLS certificates
  - client indicates hostname of target server in the SSL handshake 
  - if not match is found or if SNI is not supported, ELB returns default certificate
  - supported by v2 generation (ALB, NLB)
  - not supported by v1 generation (CLB)
  
## Connection Draining/Deregisration Delay
* Connection Draining (CLB)
* Deregistration Delay (ALB, NLB)
* the time to complete in-flight-requests while the instance is de-registered or unhealthy
* stop sending new requests to EC2 being de-registered
* Between 1 to 3600 seconds (default: 300 seconds)
* can be disabled by setting value to 9
* set to low value for short lived connections






