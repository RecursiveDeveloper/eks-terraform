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
    aws-ebs-csi-driver     = {}
  }

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true
  authentication_mode = "API"

  vpc_id                   = var.vpc_id
  control_plane_subnet_ids = var.vpc_public_subnets
  subnet_ids               = var.vpc_private_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  # EBS CSI Driver IAM role
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  access_entries = {
    devops_access_entry_1 = {
      principal_arn = var.devops_user1_arn
    },
    devops_access_entry_2 = {
      principal_arn = var.devops_user2_arn
    }
  }
}

# Attach EBS CSI policy to node group role
resource "aws_iam_role_policy_attachment" "ebs_csi_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = module.eks.eks_managed_node_groups["devopslab-node-group"].iam_role_name
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