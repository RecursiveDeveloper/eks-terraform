module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.32"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    ebs-csi-driver         = {}
  }

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true
  authentication_mode = "API"

  vpc_id                   = var.vpc_id
  control_plane_subnet_ids = var.vpc_public_subnets
  subnet_ids               = var.vpc_private_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  access_entries = {
    devops_access_entry_1 = {
      principal_arn = var.devops_user1_arn
    },
    devops_access_entry_2 = {
      principal_arn = var.devops_user2_arn
    }
  }
}

resource "aws_eks_access_policy_association" "devops_user1_policy_association" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.devops_user1_arn
  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "devops_user2_policy_association" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.devops_user2_arn
  access_scope {
    type = "cluster"
  }
}