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
  zone_id = cloudflare_zone.main.id
  name    = cloudflare_zone.main.zone
  type    = "CAA"

  data {
    flags = 0
    tag   = "issue"
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
  value   = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
}

resource "cloudflare_record" "domainkey_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "*._domainkey.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = "v=DKIM1; p="
}
