provider "aws" {
  version = "~> 3.0"

  region              = "ap-southeast-1"
  allowed_account_ids = [var.aws_allowed_account_id]
}

provider "cloudflare" {
  version = "~> 2.9"
}
