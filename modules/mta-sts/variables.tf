variable "domain_name" {
  type = string
}

variable "id" {
  type = string

  validation {
    condition     = length(var.id) >= 1 && length(var.id) <= 32 && length(regexall("[^0-9A-Za-z]", var.id)) == 0
    error_message = "The id value must be 1–32 alphanumeric characters."
  }
}

variable "strict_transport_security_preload" {
  default = true
  type    = bool
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "tls_json_reporting_address" {
  type = string
}

variable "zone_id" {
  type = string
}
