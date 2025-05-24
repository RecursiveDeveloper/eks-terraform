module "vpc" {
  source = "./modules/vpc"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  vpc_azs         = var.vpc_azs
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
}

# module "eks" {
#   source = "./modules/eks"

#   vpc_id          = module.vpc.vpc_id
#   vpc_subnet_ids  = module.vpc.vpc_private_subnets
#   eks_cluster_name = var.eks_cluster_name
#   eks-managed_node_groups = var.eks-managed_node_groups
# }