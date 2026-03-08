terraform {
  required_version = "~> 1.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.35.1"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.1"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.70.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.30.1"
    }
  }
}
