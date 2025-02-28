variable "caa_iodef_url" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "vultr_firewall_allow_v4" { # tflint-ignore: terraform_documented_variables
  type = string

  validation {
    condition     = strcontains(var.vultr_firewall_allow_v4, "/")
    error_message = "The vultr_firewall_allowed_v4 value must be a CIDR block."
  }
}

variable "vultr_firewall_allow_v6" { # tflint-ignore: terraform_documented_variables
  type = string

  validation {
    condition     = strcontains(var.vultr_firewall_allow_v6, "/")
    error_message = "The vultr_firewall_allowed_v6 value must be a CIDR block."
  }
}
