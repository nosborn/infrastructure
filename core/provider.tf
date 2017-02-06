data "aws_iam_account_alias" "current" {}

provider "aws" {
  region              = "eu-west-1"
  allowed_account_ids = ["${var.allowed_account_id}"]
}
