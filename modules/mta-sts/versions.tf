terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.8.3"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.63.0"
    }
  }
}
