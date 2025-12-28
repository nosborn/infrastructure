terraform {
  required_version = "~> 1.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.10.0"
    }

    github = { # tflint-ignore: terraform_unused_required_providers
      source  = "integrations/github"
      version = "6.9.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.65.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.28.0"
    }
  }
}
