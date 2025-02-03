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

variable "scaleway_dns_zone" {
  type = string
}
