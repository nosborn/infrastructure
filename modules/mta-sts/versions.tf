terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.53.0"
    }
  }
}
