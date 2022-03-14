provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.gitlab_account_id}:role/${var.deploy_role}"
  }
}

terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0, < 4.0.0"
    }
  }

  /* backend "s3" {
  } */
}