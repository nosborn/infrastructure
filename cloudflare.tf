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

  condition {
    request_ip {
      in = data.github_ip_ranges.main.dependabot
    }
  }
}

data "cloudflare_api_token_permission_groups" "main" {}
