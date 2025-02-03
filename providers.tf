provider "aws" {
  region = "ap-southeast-1"

  allowed_account_ids = [
    var.aws_allowed_account_id,
  ]
}

provider "aws" {
  alias = "us_east_1"

  region = "us-east-1"

  allowed_account_ids = [
    var.aws_allowed_account_id,
  ]
}

provider "scaleway" {
  access_key      = var.scw_access_key
  organization_id = var.scw_organization_id
  project_id      = var.scw_project_id
  region          = "nl-ams"
  secret_key      = var.scw_secret_key
}
