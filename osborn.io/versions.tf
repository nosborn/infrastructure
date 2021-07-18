terraform {
  required_version = ">= 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.23"
    }

    github = {
      source  = "integrations/github"
      version = ">= 4.12.2"
    }
  }
}
