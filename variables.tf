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

variable "pgp_key" {
  type = string
}
