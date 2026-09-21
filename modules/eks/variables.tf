variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS."
  type        = list(string)
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS managed nodes."
  type        = list(string)

  default = [
    "t3.medium"
  ]
}

variable "node_min_size" {
  description = "Minimum number of EKS nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of EKS nodes."
  type        = number
  default     = 4
}

variable "node_desired_size" {
  description = "Desired number of EKS nodes."
  type        = number
  default     = 2
}