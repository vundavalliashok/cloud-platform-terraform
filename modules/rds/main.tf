resource "random_password" "master" {
  length  = 32

  special = true

  override_special = "!#$%&*()-_=+[]{}:?"
}
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Component   = "RDS"
  }
}

resource "aws_db_subnet_group" "this" {
  name = "${var.project_name}-${var.environment}-db-subnet"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-subnet"
    }
  )
}
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds"
  description = "Security group for PostgreSQL RDS."
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-rds-sg"
    }
  )
}
resource "aws_vpc_security_group_ingress_rule" "postgresql" {
  security_group_id = aws_security_group.rds.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"

  description = "PostgreSQL access from VPC."
}
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.rds.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic."
}
resource "aws_db_instance" "postgresql" {
  identifier = "${var.project_name}-${var.environment}-postgres"

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.master_username
  password = random_password.master.result

  port = 5432

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  multi_az = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = "18:00-19:00"
  maintenance_window      = "sun:19:00-sun:20:00"

  auto_minor_version_upgrade = true

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  publicly_accessible = false

  enabled_cloudwatch_logs_exports = [
    "postgresql"
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-postgres"
    }
  )
}
resource "aws_secretsmanager_secret" "database" {
  name = "${var.project_name}/${var.environment}/database"

  description = "Database credentials for ${var.project_name}-${var.environment}."

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}/${var.environment}/database"
    }
  )
}
resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id

  secret_string = jsonencode({
    engine   = "postgres"
    host     = aws_db_instance.postgresql.address
    port     = aws_db_instance.postgresql.port
    database = var.database_name
    username = var.master_username
    password = random_password.master.result
  })
}