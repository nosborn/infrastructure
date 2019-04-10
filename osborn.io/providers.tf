provider "aws" {
  version = "~> 2.5"

  region              = "ap-southeast-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "netlify" {
  version = "~> 0.1"
}
