terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.11.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.69.0"
    }
  }
}
