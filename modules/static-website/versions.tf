terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.23"
      configuration_aliases = [aws.us-east-1]
    }
  }
}
