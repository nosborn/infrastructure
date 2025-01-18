terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"

      configuration_aliases = [
        aws.us_east_1,
      ]
    }

    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
