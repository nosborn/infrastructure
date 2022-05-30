resource "github_actions_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}

resource "github_dependabot_secret" "aws_role_to_assume" {
  repository      = "infrastructure"
  secret_name     = "AWS_ROLE_TO_ASSUME"
  plaintext_value = aws_iam_role.github_actions_workflow.arn
}
