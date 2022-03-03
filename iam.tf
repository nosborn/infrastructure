resource "aws_iam_account_alias" "main" {
  account_alias = var.account_alias
}

# tfsec:ignore:aws-iam-set-max-password-age
resource "aws_iam_account_password_policy" "main" {
  allow_users_to_change_password = true
  minimum_password_length        = 14
  password_reuse_prevention      = 10
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "https://github.com/${data.github_user.current.login}",
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
  ]
}

resource "aws_iam_role" "github_actions_workflow" {
  assume_role_policy    = data.aws_iam_policy_document.assume_github_actions_workflow.json
  force_detach_policies = true
  name_prefix           = "github-actions-workflow-"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    aws_iam_policy.terraform_state.arn,
  ]
}

resource "aws_iam_policy" "terraform_state" {
  name_prefix = "terraform-state-"
  policy      = data.aws_iam_policy_document.terraform_state.json
}

data "aws_iam_policy_document" "assume_github_actions_workflow" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    condition {
      test     = "StringLike"
      values   = ["repo:${data.github_user.current.login}/infrastructure:*"]
      variable = "token.actions.githubusercontent.com:sub"
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
  }
}

data "aws_iam_policy_document" "terraform_state" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.terraform.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.terraform.arn}/terraform.tfstate",
    ]
  }
}

data "github_user" "current" {
  username = ""
}
