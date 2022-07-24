terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.23"
      configuration_aliases = [aws.us-east-1]
    }

    github = {
      source  = "integrations/github"
      version = ">= 4.27.1"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }
  }
}
