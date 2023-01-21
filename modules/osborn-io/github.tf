# tfsec:ignore:github-repositories-private
resource "github_repository" "www" {
  name                   = "www.osborn.io"
  description            = "Source for [https://osborn.io]."
  allow_merge_commit     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  license_template       = "mit"
  archive_on_destroy     = true
  topics                 = ["static-website"]
  vulnerability_alerts   = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_branch_default" "www" {
  repository = github_repository.www.name
  branch     = "main"
}

resource "github_branch_protection" "www_main" {
  repository_id           = github_repository.www.node_id
  pattern                 = github_branch_default.www.branch
  enforce_admins          = true
  require_signed_commits  = true
  required_linear_history = true
}

resource "github_repository_environment" "www_live" {
  environment = "Live"
  repository  = github_repository.www.name

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_bucket_name" {
  repository      = github_repository.www.name
  environment     = github_repository_environment.www_live.environment
  secret_name     = "BUCKET_NAME"
  plaintext_value = module.website.content_bucket_id
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_cloudfront_distribution_id" {
  repository      = github_repository.www.name
  environment     = github_repository_environment.www_live.environment
  secret_name     = "CLOUDFRONT_DISTRIBUTION_ID"
  plaintext_value = module.website.cloudfront_distribution_id
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_role_to_assume" {
  repository      = github_repository.www.name
  environment     = github_repository_environment.www_live.environment
  secret_name     = "ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions.arn
}
