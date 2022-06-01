resource "cloudflare_api_token" "dependabot" {
  name = "Dependabot"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.main.permissions["DNS Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["SSL and Certificates Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }
}

data "cloudflare_api_token_permission_groups" "main" {}
