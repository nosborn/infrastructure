variable "caa_iodef_url" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "dependabot_scaleway_api_key" {
  description = "The secret Key of the IAM API key."
  type        = string
  sensitive   = true
}

variable "dmarc_aggregate_reporting_address" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "github_actions_scaleway_api_key" {
  description = "The secret Key of the IAM API key."
  type        = string
  sensitive   = true
}
