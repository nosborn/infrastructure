variable "dmarc_aggregate_reporting_address" {
  type = string
}

variable "key_management_service_arn" {
  type        = string
  description = "Amazon Resource Name (ARN) of the Key Management Service (KMS) Key."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "A map of tags to assign to resources."
}

variable "tls_json_reporting_address" {
  type = string
}

variable "tombstone_ipv4_address" {
  type = string
}
