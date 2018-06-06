data "aws_iam_account_alias" "current" {}

provider "aws" {
  version = "~> 1.22.0"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 1.22.0"

  region              = "us-east-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-1"
}

provider "statuscake" {
  version = "~> 0.1.0"
}
