provider "aws" {
  version = "~> 1.22"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}
