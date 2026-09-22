output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN."
  value       = module.iam.github_actions_role_arn
}

output "eks_workload_role_arn" {
  description = "EKS workload IAM role ARN."
  value       = module.iam.eks_workload_role_arn
}