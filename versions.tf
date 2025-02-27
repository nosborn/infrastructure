terraform {
  required_version = "~> 1.10"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.10.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.49.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.23.1"
    }
  }
}
