terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "5.22.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}
