terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.62.0"
    }
  }
}
