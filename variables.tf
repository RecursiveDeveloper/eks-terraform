variable "vpc_name" {}
variable "vpc_cidr" {}
variable "vpc_azs" {}
variable "vpc_private_subnets" {}
variable "vpc_public_subnets" {}

variable "ecr_backend_repo_name" {}
variable "ecr_frontend_repo_name" {}

variable "eks_cluster_name" {}
variable "eks_managed_node_groups" {}