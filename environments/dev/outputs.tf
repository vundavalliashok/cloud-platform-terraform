output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN."
  value       = module.iam.github_actions_role_arn
}

output "eks_workload_role_arn" {
  description = "EKS workload IAM role ARN."
  value       = module.iam.eks_workload_role_arn
}
output "database_endpoint" {
  description = "PostgreSQL RDS endpoint."
  value       = module.rds.db_endpoint
}

output "database_port" {
  description = "PostgreSQL port."
  value       = module.rds.db_port
}

output "database_secret_arn" {
  description = "Database credentials secret ARN."
  value       = module.rds.db_secret_arn
}