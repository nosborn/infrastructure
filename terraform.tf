terraform {
  required_version = "~> 1.15"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.68.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.14.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.32.0"
    }
  }
}
