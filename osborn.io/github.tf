resource "github_repository" "website" {
  name                   = "osborn.io"
  description            = "Source for [https://osborn.io]."
  visibility             = "public"
  auto_init              = true
  gitignore_template     = "Node"
  license_template       = "mit"
  archive_on_destroy     = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}

resource "github_branch_protection" "website_main" {
  repository_id          = github_repository.website.id
  pattern                = "main"
  require_signed_commits = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
}

resource "github_repository_environment" "website_live" {
  repository  = github_repository.website.name
  environment = "Live"

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_actions_environment_secret" "website_live_aws_access_key_id" {
  repository      = github_repository.website.name
  environment     = github_repository_environment.website_live.environment
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.deploy.id
}

resource "github_actions_environment_secret" "website_live_aws_secret_access_key" {
  repository      = github_repository.website.name
  environment     = github_repository_environment.website_live.environment
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.deploy.secret
}
