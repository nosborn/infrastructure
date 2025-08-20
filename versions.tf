terraform {
  required_version = "~> 1.12"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.10.0"
    }

    github = { # tflint-ignore: terraform_unused_required_providers
      source  = "integrations/github"
      version = "6.6.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.59.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.27.1"
    }
  }
}
