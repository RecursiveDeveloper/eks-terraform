resource "aws_iam_group" "devops_group" {
  name = "devops"
  path = "/devops/"
}

resource "aws_iam_user" "devops-user1" {
  name = "devops-user1"
  path = "/devops/"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_iam_user" "devops-user2" {
  name = "devops-user2"
  path = "/devops/"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_iam_group_policy" "devops_group_policy" {
  name  = "devops_group_policy"
  group = aws_iam_group.devops_group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_group_membership" "aws_iam_user1_add_to_devops_group" {
  user = aws_iam_user.devops-user1.name

  groups = [
    aws_iam_group.devops.name,
  ]
}

resource "aws_iam_user_group_membership" "aws_iam_user2_add_to_devops_group" {
  user = aws_iam_user.devops-user2.name

  groups = [
    aws_iam_group.devops.name,
  ]
}