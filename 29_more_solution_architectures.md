# More Solution Architectures

# High Performance Computing (HPC)

## EC2 Enhanced Networking (SR-IOV)

- higher bandwidth, higher PPS, lower latency
- **Elastic Network Adapter (ENA)**:
    - default and recommended
    - upto 100Gbps
    - supports all OS's and new generation instances.

- **Elastic Fabric Adapter (EFA)**
    - built on top of ENA to support HPC, MPI, or tightly coupled workloads
    - ONLY works for **Linux**
    - upto 25Gbps
- **Intel 82599 Virtual Function (VF)**
    - legacy
    - upto 10Gbps
    - only C3, M3, R3, etc. (legacy instances)
        
## Storage
Instance attached 
- Instance Store Volumes for 1M IOPS but ephemeral
- EBS (io2 Block Express) for 256k IOPS

Network
- Amazon S3
- EFS (FSx for Lustre)

## Automation and Orchestration
- AWS Batch
    - run single batch jobs that automatically span across multiple EC2 instances
- AWS ParallelCluster
    - open-source cluster management tool to deploy HPC on AWS
    - configured with text files
    - can enable EFA to improve performance



