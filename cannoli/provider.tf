provider "aws" {
  region              = "eu-west-2"
  allowed_account_ids = ["${data.terraform_remote_state.core.allowed_account_id}"]
}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["${data.terraform_remote_state.core.allowed_account_id}"]
  alias               = "us-east-1"
}

provider "statuscake" {}
