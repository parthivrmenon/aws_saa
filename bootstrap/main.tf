terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {}

# bootstrap VPC, subnets, IGW
module "network" {
  source = "./modules/network"

}
