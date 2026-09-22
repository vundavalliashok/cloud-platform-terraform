variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "cloud-platform"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "cloud-platform-dev"
}

variable "cluster_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.33"
}

variable "node_instance_types" {
  description = "EKS node instance types."
  type        = list(string)

  default = [
    "t3.medium"
  ]
}

variable "node_min_size" {
  description = "Minimum EKS nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum EKS nodes."
  type        = number
  default     = 4
}

variable "node_desired_size" {
  description = "Desired EKS nodes."
  type        = number
  default     = 2
}

variable "github_repository" {
  description = "vundavalliashok/repository format."
  type        = string
  default     = "vundavalliashok/cloud-platform-terraform"
}
variable "database_name" {
  description = "Application database name."
  type        = string
  default     = "platformdb"
}

variable "database_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "database_engine_version" {
  description = "PostgreSQL version."
  type        = string
  default     = "16"
}

variable "database_multi_az" {
  description = "Whether RDS should use Multi-AZ."
  type        = bool
  default     = false
}
