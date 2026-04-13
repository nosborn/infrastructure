terraform { # tflint-ignore: terraform_required_version
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.11.1"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.60.1"
    }
  }
}
