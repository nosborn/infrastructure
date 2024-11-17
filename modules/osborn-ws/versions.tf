terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.23"

      configuration_aliases = [
        aws.us_east_1,
      ]
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.4"
    }
  }
}
