terraform {
  required_version = "~> 1.0.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.51"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.69"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.6"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.24"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.12.2"
    }
  }
}
