terraform {
  required_version = "~> 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.19"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.14"
    }
  }
}
