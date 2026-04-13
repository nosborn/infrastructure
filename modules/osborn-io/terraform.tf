terraform { # tflint-ignore: terraform_required_version
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.60.1"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.72.0"
    }
  }
}
