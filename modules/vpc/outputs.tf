output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}