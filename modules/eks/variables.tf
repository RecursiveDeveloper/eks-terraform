variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be created"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "The subnet IDs where the EKS cluster will be created"
  type        = list(string)
}

variable "eks-managed_node_groups" {
  description = "EKS managed node groups configuration"
  type        = map(object({
    ami_type       = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
  }))
}