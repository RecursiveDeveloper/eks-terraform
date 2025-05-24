vpc_name              = "devopslab-vpc"
vpc_cidr              = "10.0.0.0/16"
vpc_azs               = ["us-east-1a", "us-east-1b"]
vpc_private_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]

eks_cluster_name       = "devopslab-eks"
eks-managed_node_groups = {
  "devopslab-node-group" = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium", "t3.large"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
  }
}