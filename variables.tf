variable "account_alias" { # tflint-ignore: terraform_documented_variables
  type      = string
  sensitive = true
}

variable "aws_allowed_account_id" { # tflint-ignore: terraform_documented_variables
  type      = string
  sensitive = true
}

variable "caa_iodef_url" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "scw_access_key" {
  description = "Scaleway access key"
  type        = string
  sensitive   = true
}

variable "scw_organization_id" {
  description = "The organization ID that will be used as default value for organization-scoped resources."
  type        = string
  sensitive   = true
}

variable "scw_project_id" {
  description = "The project ID that will be used as default value for project-scoped resources."
  type        = string
  sensitive   = true
}

variable "scw_secret_key" {
  description = "Scaleway secret key"
  type        = string
  sensitive   = true
}

variable "tf_github_token" { # tflint-ignore: terraform_documented_variables
  type      = string
  sensitive = true
}
