terraform {
  required_version = "~> 1.2.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.19.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.17.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.26.1"
    }
  }
}

provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = [var.aws_allowed_account_id]
}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.aws_allowed_account_id]
  alias               = "us-east-1"
}
