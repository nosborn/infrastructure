terraform {
  required_version = "~> 1.11"

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
      version = "2.53.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.0"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.26.0"
    }
  }
}
