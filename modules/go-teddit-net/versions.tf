terraform {
  required_version = "~> 1.2"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.14"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.25"
    }
  }
}
