# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "aws_allowed_account_id" {
  repository      = "infrastructure"
  secret_name     = "AWS_ALLOWED_ACCOUNT_ID"
  plaintext_value = var.aws_allowed_account_id
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_actions_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}

resource "github_actions_secret" "tf_github_token" {
  repository      = "infrastructure"
  secret_name     = "TF_GITHUB_TOKEN"
  plaintext_value = var.tf_github_token # FIXME
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "aws_allowed_account_id" {
  repository      = "infrastructure"
  secret_name     = "AWS_ALLOWED_ACCOUNT_ID"
  plaintext_value = var.aws_allowed_account_id
}

# tfsec:ignore:github-actions-no-plain-text-action-secrets
resource "github_dependabot_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}

resource "github_dependabot_secret" "tf_github_token" {
  repository      = "infrastructure"
  secret_name     = "TF_GITHUB_TOKEN"
  plaintext_value = var.tf_github_token # FIXME
}
