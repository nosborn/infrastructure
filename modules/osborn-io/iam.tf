resource "aws_iam_role" "github_actions" {
  assume_role_policy    = data.aws_iam_policy_document.github_actions_trust.json
  force_detach_policies = true
  managed_policy_arns   = [aws_iam_policy.github_actions.arn]
  name_prefix           = "github-actions-"
  tags                  = var.tags

  inline_policy {}
}

resource "aws_iam_policy" "github_actions" {
  name_prefix = "github-actions-"
  policy      = data.aws_iam_policy_document.github_actions.json
  tags        = var.tags
}

data "aws_iam_policy_document" "github_actions" {
  statement {
    actions   = ["cloudfront:CreateInvalidation"]
    resources = [module.website.cloudfront_distribution_arn]
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.website.content_bucket_arn]
  }

  # tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    actions   = ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"]
    resources = ["${module.website.content_bucket_arn}/*"]
  }
}

data "aws_iam_policy_document" "github_actions_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringEquals"
      values   = ["repo:${github_repository.www.full_name}:environment:${github_repository_environment.www_live.environment}"]
      variable = "token.actions.githubusercontent.com:sub"
    }

    principals {
      type        = "Federated"
      identifiers = [var.github_openid_connect_provider_arn]
    }
  }
}
