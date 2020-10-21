terraform {
  required_version = "~> 0.13.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.11"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.12"
    }
  }
}
