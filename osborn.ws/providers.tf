provider "aws" {
  version = "~> 2.4"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}
