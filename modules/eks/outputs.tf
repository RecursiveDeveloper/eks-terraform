output "cluster_oidc_issuer_url" {
  description = "value of the OIDC issuer URL for the EKS cluster"
  value = module.eks.cluster_oidc_issuer_url
}

output "cluster_oidc_provider_arn" {
  description = "value of the OIDC provider ARN for the EKS cluster"
  value = module.eks.oidc_provider_arn
}