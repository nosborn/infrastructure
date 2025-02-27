# data "github_user" "current" {
#   username = ""
# }

# data "http" "openid_configuration" {
#   url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
# }

# data "tls_certificate" "jwks" {
#   url = jsondecode(data.http.openid_configuration.response_body).jwks_uri
# }

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
      data.scaleway_account_project.default.project_id,
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
      data.scaleway_account_project.default.project_id,
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
      data.scaleway_account_project.default.project_id,
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

data "scaleway_account_project" "default" {
  name = "default"
}
