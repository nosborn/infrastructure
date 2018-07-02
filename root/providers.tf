provider "aws" {
  version = "~> 1.25"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 1.25"

  region              = "us-east-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-1"
}
