terraform {
  required_version = "~> 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "4.29.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.0.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.1"
    }
  }
}
