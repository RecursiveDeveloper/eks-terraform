resource "aws_iam_user" "devops_user1" {
  name = "devops_user1"
  path = "/devops/"
}

resource "aws_iam_user" "devops_user2" {
  name = "devops_user2"
  path = "/devops/"
}

resource "aws_iam_role" "devops_role" {
  name = "devops_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = [
            aws_iam_user.devops_user1.arn,
            aws_iam_user.devops_user2.arn,
          ]
        }
      }
    ]
  })
}

resource "aws_iam_user_policy" "devops_user1_assume_role" {
  name = "devops_user1-assume-devops-role"
  user = aws_iam_user.devops_user1.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = aws_iam_role.devops_role.arn
      }
    ]
  })
}

resource "aws_iam_user_policy" "devops_user2_assume_role" {
  name = "devops_user2-assume-devops-role"
  user = aws_iam_user.devops_user2.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = aws_iam_role.devops_role.arn
      }
    ]
  })
}

resource "aws_iam_policy" "kubeconfig_policy" {
  name = "kubeconfig_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:ListNodegroups",
          "eks:DescribeNodegroup",
          "eks:ListFargateProfiles",
          "eks:DescribeFargateProfile"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "devops_role_kubeconfig_policy" {
  role       = aws_iam_role.devops_role.name
  policy_arn = aws_iam_policy.kubeconfig_policy.arn
}