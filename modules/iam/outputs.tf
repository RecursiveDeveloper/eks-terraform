output "iam_devops_role_arn" {
    description = "ARN of the IAM DevOps role"
    value       = aws_iam_role.iam_devops_role.arn
}