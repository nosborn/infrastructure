terraform {
  required_version = "~> 1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.13.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.23.0"
    }
  }
}
