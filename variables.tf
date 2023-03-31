variable "account_alias" {
  type      = string
  sensitive = true
}

variable "aws_allowed_account_id" {
  type      = string
  sensitive = true
}

variable "pgp_key" {
  type = string
}

variable "tf_github_token" {
  type      = string
  sensitive = true
}
