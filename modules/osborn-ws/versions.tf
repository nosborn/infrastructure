terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.49.0"
    }
  }
}
