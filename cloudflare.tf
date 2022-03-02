resource "cloudflare_api_token" "tombstone" {
  name = "Tombstone"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.permissions["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${module.osborn_io.cloudflare_zone_id}" = "*"
    }
  }
}

data "cloudflare_api_token_permission_groups" "all" {}
