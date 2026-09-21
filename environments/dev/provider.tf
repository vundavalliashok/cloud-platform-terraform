provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "cloud-platform-terraform"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Ashok"
    }
  }
}