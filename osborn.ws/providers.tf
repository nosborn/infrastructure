provider "aws" {
  version = "~> 1.56"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}
