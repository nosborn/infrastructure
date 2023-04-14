provider "aws" {
  allowed_account_ids = [var.aws_allowed_account_id]
  region              = "ap-southeast-1"
}

provider "aws" {
  alias = "us_east_1"

  allowed_account_ids = [var.aws_allowed_account_id]
  region              = "us-east-1"
}
