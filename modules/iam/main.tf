resource "aws_iam_user" "devops-user1" {
  name = "devops-user1"
  path = "/devops/"
}

resource "aws_iam_user" "devops-user2" {
  name = "devops-user2"
  path = "/devops/"
}

resource "aws_iam_role" "iam_devops_role" {
  name = "iam_devops_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = [
            aws_iam_user.devops-user1.arn,
            aws_iam_user.devops-user2.arn
          ]
        }
      }
    ]
  })
}