terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.90.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  vpc_azs             = var.vpc_azs
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets
}

module "eks" {
  source = "./modules/eks"

  devops_user1_arn        = module.iam.devops_user1_arn
  devops_user2_arn        = module.iam.devops_user2_arn
  vpc_id                  = module.vpc.vpc_id
  vpc_private_subnets     = module.vpc.vpc_private_subnet_ids
  eks_cluster_name        = var.eks_cluster_name
  eks_managed_node_groups = var.eks_managed_node_groups
}