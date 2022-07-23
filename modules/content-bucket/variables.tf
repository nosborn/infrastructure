variable "domain_name" {
  type = string
}

variable "origin_access_identity_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
