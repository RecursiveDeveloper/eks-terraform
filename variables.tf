variable "aws_region" {
  description = "AWS region to deploy the EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {}
variable "vpc_cidr" {}
variable "vpc_azs" {}
variable "vpc_private_subnets" {}
variable "vpc_public_subnets" {}

variable "eks_cluster_name" {}
variable "eks-managed_node_groups" {}