variable "account_alias" {
  type      = string
  sensitive = true
}

variable "aws_allowed_account_id" {
  type      = string
  sensitive = true
}

variable "tf_github_token" {
  type      = string
  sensitive = true
}

variable "tombstone_ipv4_address" {
  type      = string
  sensitive = true
}

variable "vultr_api_key" {
  type      = string
  sensitive = true
}

variable "vultr_ssh_key" {
  type      = string
  sensitive = true
}
