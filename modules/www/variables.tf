variable "container_namespace_id" {
  description = "The unique identifier of the container namespace."
  type        = string
}

variable "container_registry_endpoint" {
  description = "Endpoint reachable by Docker."
  type        = string
}

variable "dependabot_scaleway_api_key" {
  description = "The secret Key of the IAM API key."
  type        = string
  sensitive   = true
}

variable "domain_name" { # tflint-ignore: terraform_documented_variables
  type = string
}

variable "github_actions_scaleway_api_key" {
  description = "The secret Key of the IAM API key."
  type        = string
  sensitive   = true
}

variable "scaleway_dns_zone" {
  description = "The DNS zone of the domain."
  type        = string
}
