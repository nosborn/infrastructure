variable "domain_name" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "scaleway_dns_zone" {
  description = "The DNS zone of the domain."
  type        = string
}

variable "statichost_site_name" { # tflint-ignore: terraform_documented_variables
  type = string
}
