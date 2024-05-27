terraform {
  required_version = "~> 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.1"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "6.2.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
