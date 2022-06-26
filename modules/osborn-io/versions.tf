terraform {
  required_version = "~> 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.17"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.26"
    }
  }
}
