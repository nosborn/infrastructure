terraform {
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.21"
    }
  }
}
