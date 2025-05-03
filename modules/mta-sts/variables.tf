variable "domain_name" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "id" { # tflint-ignore: terraform_documented_variables
  type = string

  validation {
    condition     = length(var.id) >= 1 && length(var.id) <= 32 && length(regexall("[^0-9A-Za-z]", var.id)) == 0
    error_message = "The id value must be 1–32 alphanumeric characters."
  }
}

variable "mx_fqdns" { # tflint-ignore: terraform_documented_variables
  type = list(string)
}

variable "statichost_site_name" { # tflint-ignore: terraform_documented_variables
  type = string
}
