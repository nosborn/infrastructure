provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = [var.aws_allowed_account_id]
}

provider "aws" {
  region              = "eu-west-2"
  allowed_account_ids = [var.aws_allowed_account_id]
  alias               = "eu-west-2"
}
