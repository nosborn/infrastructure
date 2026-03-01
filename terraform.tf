terraform {
  required_version = "~> 1.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.31.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.69.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.30.0"
    }
  }
}
