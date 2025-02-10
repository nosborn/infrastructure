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
    data.tls_certificate.jwks.certificates[0].sha1_fingerprint,
  ]
}

resource "aws_iam_role" "github_actions_workflow" {
  assume_role_policy = data.aws_iam_policy_document.assume_github_actions_workflow.json
  name_prefix        = "github-actions-workflow-"
}

resource "aws_iam_role_policy_attachments_exclusive" "github_actions_workflow" {
  role_name = aws_iam_role.github_actions_workflow.name

  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    aws_iam_policy.terraform_state.arn,
  ]
}

resource "aws_iam_role_policy_attachment" "github_actions_workflow" {
  for_each = toset([
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    aws_iam_policy.terraform_state.arn,
  ])

  policy_arn = each.key
  role       = aws_iam_role.github_actions_workflow.name
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
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${data.github_user.current.login}/infrastructure:*",
      ]
    }

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn,
      ]
    }
  }
}

data "aws_iam_policy_document" "terraform_state" {
  statement {
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]

    resources = [
      # "arn:aws:kms:example-region-1:123456789098:key/111aa2bb-333c-4d44-5555-a111bb2c33dd",
      "*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.terraform.arn,
    ]
  }

  statement {
    actions = [
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

data "http" "openid_configuration" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

data "tls_certificate" "jwks" {
  url = jsondecode(data.http.openid_configuration.response_body).jwks_uri
}

resource "scaleway_iam_application" "dependabot" {
  name = "Dependabot"
}

resource "scaleway_iam_policy" "dependabot_organization" {
  application_id = scaleway_iam_application.dependabot.id
  name           = "Dependabot (Organization)"

  rule {
    organization_id = scaleway_iam_application.dependabot.organization_id

    permission_set_names = [
      "IAMReadOnly",
      "ProjectReadOnly",
    ]
  }
}

resource "scaleway_iam_policy" "dependabot_resources" {
  application_id = scaleway_iam_application.dependabot.id
  name           = "Dependabot (Resources)"

  rule {
    permission_set_names = [
      "ContainerRegistryReadOnly",
      "ContainersReadOnly",
      "DomainsDNSReadOnly",
    ]

    project_ids = [
      var.scw_project_id,
    ]
  }
}

resource "scaleway_iam_api_key" "dependabot" {
  application_id = scaleway_iam_application.dependabot.id
}

resource "scaleway_iam_application" "dns_updater" {
  name = "DNS Updater"
}

resource "scaleway_iam_policy" "dns_updater" {
  application_id = scaleway_iam_application.dns_updater.id
  name           = "DNS Updater"

  rule {
    permission_set_names = [
      "DomainsDNSFullAccess",
    ]

    project_ids = [
      var.scw_project_id,
    ]
  }
}

resource "scaleway_iam_api_key" "dns_updater" {
  application_id = scaleway_iam_application.dns_updater.id
}

resource "scaleway_iam_application" "github_actions" {
  name = "GitHub Actions"
}

resource "scaleway_iam_policy" "github_actions_organization" {
  application_id = scaleway_iam_application.github_actions.id
  name           = "GitHub Actions (Organization)"

  rule {
    organization_id = scaleway_iam_application.github_actions.organization_id

    permission_set_names = [
      "IAMReadOnly",
      "ProjectReadOnly",
    ]
  }
}

resource "scaleway_iam_policy" "github_actions_resources" {
  application_id = scaleway_iam_application.github_actions.id
  name           = "GitHub Actions (Resources)"

  rule {
    permission_set_names = [
      "ContainerRegistryFullAccess",
      "ContainersReadOnly",
      "DomainsDNSReadOnly",
    ]

    project_ids = [
      var.scw_project_id,
    ]
  }
}

resource "scaleway_iam_api_key" "github_actions" {
  application_id = scaleway_iam_application.github_actions.id
  expires_at     = time_rotating.every_90_days.rotation_rfc3339
}

resource "time_rotating" "every_90_days" {
  rotation_days = 90
}
