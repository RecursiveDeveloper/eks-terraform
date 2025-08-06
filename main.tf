module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  vpc_azs             = var.vpc_azs
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
}

module "ecr" {
  source = "./modules/ecr"

  ecr_backend_repo_name = var.ecr_backend_repo_name
  ecr_frontend_repo_name = var.ecr_frontend_repo_name
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source = "./modules/eks"

  devops_user1_arn        = module.iam.devops_user1_arn
  devops_user2_arn        = module.iam.devops_user2_arn
  vpc_id                  = module.vpc.vpc_id
  vpc_public_subnets      = module.vpc.vpc_public_subnet_ids
  vpc_private_subnets     = module.vpc.vpc_private_subnet_ids
  eks_cluster_name        = var.eks_cluster_name
  eks_managed_node_groups = var.eks_managed_node_groups
}

module "load_balancer_controller" {
  source  = "DNXLabs/eks-lb-controller/aws"
  version = "0.11.0"

  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.cluster_oidc_provider_arn
  cluster_name                     = var.eks_cluster_name
}
