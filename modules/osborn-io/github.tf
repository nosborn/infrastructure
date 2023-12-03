# tfsec:ignore:github-repositories-private
resource "github_repository" "www" {
  allow_merge_commit                      = false
  allow_squash_merge                      = false
  archive_on_destroy                      = true
  delete_branch_on_merge                  = true
  description                             = "Source for [https://osborn.io]."
  ignore_vulnerability_alerts_during_read = true
  license_template                        = "mit"
  name                                    = "www.osborn.io"
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

resource "github_branch_default" "www" {
  branch     = "main"
  repository = github_repository.www.name
}

resource "github_branch_protection" "www_main" {
  enforce_admins          = true
  pattern                 = github_branch_default.www.branch
  repository_id           = github_repository.www.node_id
  require_signed_commits  = true
  required_linear_history = true
}

resource "github_repository_environment" "www_live" {
  environment = "Live"
  repository  = github_repository.www.name

  deployment_branch_policy {
    custom_branch_policies = false
    protected_branches     = true
  }
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_bucket_name" {
  environment     = github_repository_environment.www_live.environment
  plaintext_value = module.website.content_bucket_id
  repository      = github_repository.www.name
  secret_name     = "BUCKET_NAME"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_cloudfront_distribution_id" {
  environment     = github_repository_environment.www_live.environment
  plaintext_value = module.website.cloudfront_distribution_id
  repository      = github_repository.www.name
  secret_name     = "CLOUDFRONT_DISTRIBUTION_ID"
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_environment_secret" "www_live_role_to_assume" {
  environment     = github_repository_environment.www_live.environment
  plaintext_value = aws_iam_role.github_actions.arn
  repository      = github_repository.www.name
  secret_name     = "ROLE_TO_ASSUME"
}
