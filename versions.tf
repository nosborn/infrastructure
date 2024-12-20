terraform {
  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.1"
    }

    # cloudinit = {
    #   source  = "hashicorp/cloudinit"
    #   version = "2.3.5"
    # }

    # b2 = {
    #   source  = "Backblaze/b2"
    #   version = "0.8.1"
    # }

    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }

    random = { # tflint-ignore: terraform_unused_required_providers
      source  = "hashicorp/random"
      version = "3.6.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.23.1"
    }
  }
}
