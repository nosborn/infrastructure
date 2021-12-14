terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.7"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.4"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.19"
    }
  }
}
