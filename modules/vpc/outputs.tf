output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "vpc_private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}