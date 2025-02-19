# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "scw_access_key" {
  plaintext_value = var.scw_access_key
  repository      = "infrastructure"
  secret_name     = "SCW_ACCESS_KEY"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "scw_organization_id" {
  plaintext_value = var.scw_organization_id
  repository      = "infrastructure"
  secret_name     = "SCW_ORGANIZATION_ID"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "scw_project_id" {
  plaintext_value = var.scw_project_id
  repository      = "infrastructure"
  secret_name     = "SCW_PROJECT_ID"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "scw_secret_key" {
  plaintext_value = var.scw_secret_key
  repository      = "infrastructure"
  secret_name     = "SCW_SECRET_KEY"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "tf_github_token" {
  plaintext_value = var.tf_github_token
  repository      = "infrastructure"
  secret_name     = "TF_GITHUB_TOKEN"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "scw_access_key" {
  plaintext_value = var.scw_access_key
  repository      = "infrastructure"
  secret_name     = "SCW_ACCESS_KEY"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "scw_organization_id" {
  plaintext_value = var.scw_organization_id
  repository      = "infrastructure"
  secret_name     = "SCW_ORGANIZATION_ID"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "scw_project_id" {
  plaintext_value = var.scw_project_id
  repository      = "infrastructure"
  secret_name     = "SCW_PROJECT_ID"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "scw_secret_key" {
  plaintext_value = var.scw_secret_key
  repository      = "infrastructure"
  secret_name     = "SCW_SECRET_KEY"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "tf_github_token" {
  plaintext_value = var.tf_github_token
  repository      = "infrastructure"
  secret_name     = "TF_GITHUB_TOKEN"
}
