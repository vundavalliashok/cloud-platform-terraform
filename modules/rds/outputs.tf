output "db_instance_id" {
  description = "RDS instance ID."
  value       = aws_db_instance.postgresql.id
}

output "db_instance_arn" {
  description = "RDS instance ARN."
  value       = aws_db_instance.postgresql.arn
}

output "db_endpoint" {
  description = "RDS endpoint."
  value       = aws_db_instance.postgresql.address
}

output "db_port" {
  description = "RDS port."
  value       = aws_db_instance.postgresql.port
}

output "db_name" {
  description = "Database name."
  value       = var.database_name
}

output "db_secret_arn" {
  description = "Secrets Manager ARN containing database credentials."
  value       = aws_secretsmanager_secret.database.arn
}