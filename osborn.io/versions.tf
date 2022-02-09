terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.1"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.7.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.8.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.20.0"
    }
  }
}
