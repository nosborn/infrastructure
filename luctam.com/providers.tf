provider "aws" {
  version = "~> 2.13"

  region              = "ap-southeast-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "ns1" {
  version = "~> 1.4"
}
