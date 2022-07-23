terraform {
  required_version = "~> 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "4.27.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.2.0"
    }

    namecheap = {
      source = "namecheap/namecheap"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
  }
}
