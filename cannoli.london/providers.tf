provider "archive" {
  version = "~> 1.2"
}

provider "aws" {
  version = "~> 2.4"

  region              = "ca-central-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "ca-central-1"
}

provider "aws" {
  version = "~> 2.4"

  region              = "eu-central-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "eu-central-1"
}

provider "aws" {
  version = "~> 2.4"

  region              = "eu-west-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "eu-west-1"
}

provider "aws" {
  version = "~> 2.4"

  region              = "eu-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
}

provider "aws" {
  version = "~> 2.4"

  region              = "eu-west-3"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "eu-west-3"
}

provider "aws" {
  version = "~> 2.4"

  region              = "us-east-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-1"
}

provider "aws" {
  version = "~> 2.4"

  region              = "us-east-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-east-2"
}

provider "aws" {
  version = "~> 2.4"

  region              = "us-west-1"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-west-1"
}

provider "aws" {
  version = "~> 2.4"

  region              = "us-west-2"
  allowed_account_ids = ["${var.aws_allowed_account_id}"]
  alias               = "us-west-2"
}
