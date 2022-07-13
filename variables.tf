variable "account_alias" {
  type = string
}

variable "aws_allowed_account_id" {
  type = string
}

variable "cloudflare_account_id" {
  type      = string
  sensitive = true
}

variable "dependabot_secret_tf_github_token" {
  type = string
}

variable "pgp_key" {
  type = string
}
