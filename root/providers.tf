provider "aws" {
  version = "~> 3.0"

  region              = "ap-southeast-1"
  allowed_account_ids = [var.aws_allowed_account_id]
}

provider "aws" {
  version = "~> 3.0"

  region              = "us-east-1"
  allowed_account_ids = [var.aws_allowed_account_id]
  alias               = "us-east-1"
}
