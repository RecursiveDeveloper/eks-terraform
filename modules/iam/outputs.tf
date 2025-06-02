output "devops_user1_arn" {
    description = "ARN of the IAM DevOps user 1"
    value       = aws_iam_user.devops_user1.arn
}

output "devops_user2_arn" {
    description = "ARN of the IAM DevOps user 2"
    value       = aws_iam_user.devops_user2.arn
}