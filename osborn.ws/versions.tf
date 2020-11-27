terraform {
  required_version = "~> 0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.18"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.13"
    }
  }
}
