variable "domain_name" {
  type = string
}

variable "redirect_domain_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
