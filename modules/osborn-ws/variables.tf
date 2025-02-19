variable "caa_iodef_url" {
  type = string
}

variable "dependabot_scaleway_api_key" {
  type      = string
  sensitive = true
}

variable "dmarc_aggregate_reporting_address" {
  type = string
}

variable "github_actions_scaleway_api_key" {
  type      = string
  sensitive = true
}
