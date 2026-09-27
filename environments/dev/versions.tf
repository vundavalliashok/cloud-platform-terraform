terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "cloud-platform-terraform-state-ACCOUNT_ID"
    key    = "environments/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}