variable "content_security_policy" {
  type = string
}

variable "default_root_object" {
  default     = ""
  type        = string
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
}

variable "domain_name" {
  type = string
}

variable "redirect_domain_names" {
  default = []
  type    = list(string)
}

variable "strict_transport_security_preload" {
  default = true
  type    = bool
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "zone_id" {
  type = string
}
