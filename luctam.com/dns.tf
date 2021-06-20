resource "cloudflare_zone" "main" {
  zone = "luctam.com"
  plan = "free"
}

resource "cloudflare_zone_dnssec" "main" {
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_zone_settings_override" "main" {
  zone_id = cloudflare_zone.main.id

  settings {
    ssl           = "off"
    universal_ssl = "off"

    security_header {
      enabled            = true
      preload            = false
      max_age            = 0
      include_subdomains = true
      nosniff            = true
    }
  }
}

resource "cloudflare_record" "CAA" {
  for_each = toset(["issue", "issuewild"])

  zone_id = cloudflare_zone.main.id
  name    = cloudflare_zone.main.zone
  type    = "CAA"

  data = {
    flags = 0
    tag   = each.key
    value = ";"
  }
}

resource "cloudflare_record" "MX" {
  zone_id  = cloudflare_zone.main.id
  name     = cloudflare_zone.main.zone
  type     = "MX"
  value    = "."
  priority = 0
}

resource "cloudflare_record" "TXT" {
  zone_id = cloudflare_zone.main.id
  name    = cloudflare_zone.main.zone
  type    = "TXT"
  value   = "v=spf1 -all"
}

resource "cloudflare_record" "dmarc_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = "v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s; sp=none;"
}

resource "cloudflare_record" "domainkey_wildcard_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "*._domainkey.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = "v=DKIM1; p="
}

resource "cloudflare_record" "wildcard_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "*.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = "v=spf1 -all"
}
