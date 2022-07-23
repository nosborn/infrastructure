variable "account_alias" {
  type = string
}

variable "aws_allowed_account_id" {
  type = string
}

variable "pgp_key" {
  type = string
}

variable "tf_github_token" {
  type      = string
  sensitive = true
}
