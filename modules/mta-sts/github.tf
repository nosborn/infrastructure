resource "github_repository" "this" { # tfsec:ignore:github-repositories-private
  allow_merge_commit                      = false
  allow_squash_merge                      = false
  allow_update_branch                     = true
  archive_on_destroy                      = true
  delete_branch_on_merge                  = true
  has_discussions                         = false
  has_issues                              = false
  has_projects                            = false
  has_wiki                                = false
  ignore_vulnerability_alerts_during_read = true
  name                                    = "mta-sts.${var.domain_name}"
  visibility                              = "public"
  vulnerability_alerts                    = true

  topics = [
    "static-website",
  ]

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_repository_file" "policy" {
  branch = "main"
  # commit_author       = "Terraform"
  # commit_email        = "terraform@osborn.io"
  commit_message      = "Update MTA-STS policy"
  file                = "html/.well-known/mta-sts.txt"
  overwrite_on_create = true
  repository          = github_repository.this.name

  content = <<EOT
version: STSv1
mode: enforce
%{for fqdn in var.mx_fqdns~}
mx: ${fqdn}
%{endfor~}
max_age: 86400
EOT
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "container_registry_endpoint" {
  plaintext_value = var.container_registry_endpoint
  repository      = github_repository.this.name
  secret_name     = "CONTAINER_REGISTRY_ENDPOINT"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "scaleway_api_key" {
  plaintext_value = var.github_actions_scaleway_api_key
  repository      = github_repository.this.name
  secret_name     = "SCALEWAY_API_KEY"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "container_registry_endpoint" {
  plaintext_value = var.container_registry_endpoint
  repository      = github_repository.this.name
  secret_name     = "CONTAINER_REGISTRY_ENDPOINT"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "scaleway_api_key" {
  plaintext_value = var.dependabot_scaleway_api_key
  repository      = github_repository.this.name
  secret_name     = "SCALEWAY_API_KEY"
}
