terraform {
  required_version = "~> 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.1"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.4"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.3"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.21.0"
    }
  }
}
