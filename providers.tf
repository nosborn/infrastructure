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
