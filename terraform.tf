terraform {
  required_version = "~> 1.15"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.1"
    }

    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.62.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}
