terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.10.2"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.65.1"
    }
  }
}
