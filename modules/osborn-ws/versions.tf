terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"

      configuration_aliases = [
        aws.us_east_1,
      ]
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
