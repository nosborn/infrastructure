terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.0"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "6.0.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.18.0"
    }
  }
}
