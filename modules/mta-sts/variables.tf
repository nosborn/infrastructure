variable "container_namespace_id" {
  description = "The unique identifier of the container namespace."
  type        = string
}

variable "container_registry_endpoint" {
  description = "Endpoint reachable by Docker."
  type        = string
}

variable "dependabot_scaleway_api_key" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type = string
}

variable "github_actions_scaleway_api_key" {
  type      = string
  sensitive = true
}

variable "id" {
  type = string

  validation {
    condition     = length(var.id) >= 1 && length(var.id) <= 32 && length(regexall("[^0-9A-Za-z]", var.id)) == 0
    error_message = "The id value must be 1–32 alphanumeric characters."
  }
}

variable "mx_fqdns" {
  type = list(string)
}
