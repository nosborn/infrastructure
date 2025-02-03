terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.49.0"
    }
  }
}
