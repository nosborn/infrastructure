variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued."
}

variable "subject_alternative_names" {
  default     = []
  type        = set(string)
  description = "Set of domains that should be SANs in the issued certificate."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "A map of tags to assign to the resource."
}

variable "zone_id" {
  type = string
}
