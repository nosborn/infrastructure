variable "content_security_policy" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "redirect_domain_names" {
  default = []
  type    = list(string)
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "zone_id" {
  type = string
}
