module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.31"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.vpc_subnet_ids
  control_plane_subnet_ids = var.vpc_subnet_ids

  eks_managed_node_groups = var.eks-managed_node_groups

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}