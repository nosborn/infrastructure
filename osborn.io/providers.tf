provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = [var.aws_allowed_account_id]

  default_tags {
    tags = {
      Project = "osborn.io"
    }
  }
}
