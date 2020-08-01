variable "account_alias" {
  type = string
}

variable "aws_allowed_account_id" {
  type = string
}

variable "trusted_ip_addresses" {
  type    = list(string)
  default = []
}
