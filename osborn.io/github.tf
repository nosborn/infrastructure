resource "github_repository" "main" {
  name        = var.domain_name
  description = "Source for [https://${var.domain_name}]."
}

