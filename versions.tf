terraform {
  required_version = "~> 1.2.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.16.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.26.0"
    }
  }
}
