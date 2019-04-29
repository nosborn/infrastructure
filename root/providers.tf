provider "aws" {
  version = "~> 2.8"

  region              = "ap-southeast-1"                  # Singapore
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 2.8"

  region              = "us-east-1"                       # N. Virginia
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-1"
}
