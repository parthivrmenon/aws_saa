# Elastic Kubernetes Service
managed K8S clusters on AWS and is an alternative to ECS.

* usecases:
    - already using K8S on-prem/different cloud
    - K8S is cloud-agnostic
* support deploying EC2 worker nodes
* supports Fargate (serverless) mode

## Node Management:
* Managed Node Groups:
    - EKS creates/manages Nodes (EC2 instances) for you
    - EKS manages the Node Group ASG
    - supports On-Demand or Spot instances

* Self-Managed
    - nodes can be created and registered manually or managed by a user managed ASG
    - you can use pre-built AMI -> Amazon EKS optimized AMI
    - supports On-Demand or Spot instances

* Fargate
    - no maintenance required 


## Data Volumes
StorageClass specified in EKS Manifest
(leverages Container Storage Interface or CSI)

Supports:
- EBS, FSx for Lustre, Fsx for NetApp ONTAP
- EFS (Fargate)

## EXAM - Envelope Encryption for Secrets in EKS

- In Amazon EKS, the **control plane (including etcd) is AWS-managed**.
- **By default, etcd is not encrypted at rest**, so Kubernetes Secrets are stored in plaintext.
- To encrypt secrets, you must enable **envelope encryption** using **AWS KMS**:
  - In the **EKS console**, enable **Secrets Encryption** during cluster creation.
  - Or, using **eksctl**, provide an **--encryption-config** file specifying the KMS key.
- Only **Secrets** are encrypted with envelope encryption; other Kubernetes objects (ConfigMaps, Pods, etc.) remain unencrypted in etcd.



