terraform {
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "~> 0.4"
    # }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.21"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.12"
    }
  }
}
