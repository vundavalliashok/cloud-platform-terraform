output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN."
  value = var.create_github_oidc ? aws_iam_role.github_actions[0].arn : null
}

output "github_oidc_provider_arn" {
  description = "GitHub OIDC provider ARN."
  value = var.create_github_oidc ? aws_iam_openid_connect_provider.github[0].arn : null
}

output "eks_workload_role_arn" {
  description = "EKS workload IAM role ARN."
  value = var.eks_oidc_provider_arn != "" ? aws_iam_role.eks_workload[0].arn : null
}