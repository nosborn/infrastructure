resource "cloudflare_api_token" "dependabot" {
  name = "Dependabot"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.main.permissions["API Tokens Read"],
    ]
    resources = {
      "com.cloudflare.api.user.${var.cloudflare_account_id}" = "*"
    }
  }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.main.permissions["DNS Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["SSL and Certificates Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["Zone Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["Zone Settings Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${var.cloudflare_account_id}" = "*"
    }
  }
}

data "cloudflare_api_token_permission_groups" "main" {}
