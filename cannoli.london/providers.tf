provider "aws" {
  version = "~> 2.14"

  region              = "ap-southeast-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 2.14"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "eu-west-2"
}

provider "cloudflare" {
  version = "~> 1.15"
}
