terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.4"
    }
  }
}
