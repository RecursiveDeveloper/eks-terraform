module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.32"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true
  authentication_mode = "API"

  vpc_id                   = var.vpc_id
  subnet_ids               = var.vpc_private_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  access_entries = {
    devops_access_entry_1 = {
      principal_arn = var.iam_devops_role_arn

      policy_association = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
        access_scope = {
          namespaces = ["default"]
          type       = "namespace"
        }
      }
    }
  }
}