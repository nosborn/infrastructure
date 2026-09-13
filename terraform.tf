terraform {
  required_version = "~> 1.16"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.69.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.14.2"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.32.0"
    }
  }
}
