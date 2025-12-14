# More Solution Architectures

# High Performance Computing (HPC)
## Data Management and Transfer
- AWS Direct Connect: move GB/s of data to the cloud over a private connection
- AWS Snowball & Snowmobile: move PB of data to the cloud offline
- AWS DataSync: move large amounts of data to S3, EFS, FSx for Windows

## Compute and Networking
- EC2 instances with high-performance GPUs
- Spot Instances/Spot Fleet
- "Cluster" Placement Group
- EC2 Enhanced Networking (SR-IOV)
    - higher bandwidth, higher PPS, lower latency
    - Option 1: Elastic Network Adapter (ENA) upto 100Gbps
    - Option 2: Intel 82599 VF upto 10Gbps - Legacy
    - Option 3: Elastic Fabric Adapter (EFA) upto 25Gbps - HPC
        - improved ENA for HPC but only works for Linux
        - leverages Message Passing Interface (MPI) for HPC
        
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



