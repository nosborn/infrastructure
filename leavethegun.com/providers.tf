provider "aws" {
  version = "~> 2.4"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 2.4"

  region              = "us-east-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-1"
}
