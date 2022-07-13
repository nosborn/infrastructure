resource "github_actions_secret" "aws_allowed_account_id" {
  repository      = "infrastructure"
  secret_name     = "AWS_ALLOWED_ACCOUNT_ID"
  plaintext_value = var.aws_allowed_account_id
}

resource "github_actions_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}

resource "github_actions_secret" "cloudflare_account_id" {
  repository      = "infrastructure"
  secret_name     = "CLOUDFLARE_ACCOUNT_ID"
  plaintext_value = var.cloudflare_account_id
}

resource "github_dependabot_secret" "aws_allowed_account_id" {
  repository      = "infrastructure"
  secret_name     = "AWS_ALLOWED_ACCOUNT_ID"
  plaintext_value = var.aws_allowed_account_id
}

resource "github_dependabot_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}

# resource "github_dependabot_secret" "b2_application_key" {
#   repository      = "infrastructure"
#   secret_name     = "B2_APPLICATION_KEY"
#   plaintext_value = b2_application_key.dependabot.application_key
# }

# resource "github_dependabot_secret" "b2_application_key_id" {
#   repository      = "infrastructure"
#   secret_name     = "B2_APPLICATION_KEY_ID"
#   plaintext_value = b2_application_key.dependabot.application_key_id
# }

resource "github_dependabot_secret" "cloudflare_account_id" {
  repository      = "infrastructure"
  secret_name     = "CLOUDFLARE_ACCOUNT_ID"
  plaintext_value = var.cloudflare_account_id
}

resource "github_dependabot_secret" "cloudflare_api_token" {
  repository      = "infrastructure"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = cloudflare_api_token.dependabot.value
}

resource "github_dependabot_secret" "tf_github_token" {
  repository      = "infrastructure"
  secret_name     = "TF_GITHUB_TOKEN"
  encrypted_value = var.dependabot_secret_tf_github_token
}

data "github_ip_ranges" "main" {}
