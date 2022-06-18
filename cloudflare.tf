resource "cloudflare_api_token" "dependabot" {
  name = "Dependabot"

  # policy {
  #   permission_groups = [
  #     data.cloudflare_api_token_permission_groups.main.permissions["API Tokens Read"],
  #     data.cloudflare_api_token_permission_groups.main.permissions["User Details Read"],
  #   ]
  #   resources = {
  #     "com.cloudflare.api.user.${var.cloudflare_account_id}" = "*"
  #   }
  # }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.main.permissions["DNS Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["SSL and Certificates Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["Zone Read"],
      data.cloudflare_api_token_permission_groups.main.permissions["Zone Settings Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${module.go_teddit_net.cloudflare_zone_id}" = "*"
      "com.cloudflare.api.account.zone.${module.osborn_io.cloudflare_zone_id}"     = "*"
      "com.cloudflare.api.account.zone.${module.osborn_ws.cloudflare_zone_id}"     = "*"
    }
  }
}

data "cloudflare_api_token_permission_groups" "main" {}
