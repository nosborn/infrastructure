terraform {
  required_version = ">= 1.1.7"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.9.1"
    }

    github = {
      source  = "integrations/github"
      version = ">= 4.20.0"
    }
  }
}
