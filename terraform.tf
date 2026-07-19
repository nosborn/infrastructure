terraform {
  required_version = "~> 1.15"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.13.1"
    }

    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.66.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.14.0"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.32.0"
    }
  }
}
