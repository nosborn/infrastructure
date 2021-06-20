locals {
  caa = [
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org",
  ]
}

resource "cloudflare_zone" "main" {
  zone = "osborn.io"
  plan = "free"
}

resource "cloudflare_zone_dnssec" "main" {
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_zone_settings_override" "main" {
  zone_id = cloudflare_zone.main.id

  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    email_obfuscation        = "on"
    hotlink_protection       = "on"
    http2                    = "on"
    http3                    = "on"
    ipv6                     = "on"
    ssl                      = "flexible"
    tls_1_3                  = "zrt"
    websockets               = "off"
    zero_rtt                 = "on"

    security_header {
      enabled            = true
      preload            = true
      max_age            = 31536000
      include_subdomains = true
      nosniff            = true
    }
  }
}

resource "cloudflare_record" "CAA_issue" {
  count = length(local.caa)

  zone_id = cloudflare_zone.main.id
  name    = cloudflare_zone.main.zone
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = local.caa[count.index]
  }
}

resource "cloudflare_record" "CAA_issuewild" {
  zone_id = cloudflare_zone.main.id
  name    = cloudflare_zone.main.zone
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }
}

resource "cloudflare_record" "bing_verification" {
  zone_id = cloudflare_zone.main.id
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9"
  type    = "CNAME"
  value   = "verify.bing.com"
}

resource "cloudflare_record" "google_verification" {
  zone_id = cloudflare_zone.main.id
  name    = "@"
  type    = "TXT"
  value   = "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI"
}

resource "cloudflare_record" "keybase_verification" {
  zone_id = cloudflare_zone.main.id
  name    = "_keybase.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
}

resource "cloudflare_record" "tombstone_A" {
  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${cloudflare_zone.main.zone}"
  type    = "A"
  value   = "127.0.0.1" # initial value only
  ttl     = 60

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "cloudflare_record" "tombstone_AAAA" {
  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${cloudflare_zone.main.zone}"
  type    = "AAAA"
  value   = "::1" # initial value only
  ttl     = 60

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "cloudflare_record" "tombstone_CAA_issue" {
  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${cloudflare_zone.main.zone}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
}

resource "cloudflare_record" "tombstone_CAA_issuewild" {
  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${cloudflare_zone.main.zone}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }
}

resource "cloudflare_record" "unifi_CAA_issue" {
  zone_id = cloudflare_zone.main.id
  name    = "unifi.${cloudflare_zone.main.zone}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
}

resource "cloudflare_record" "unifi_CAA_issuewild" {
  zone_id = cloudflare_zone.main.id
  name    = "unifi.${cloudflare_zone.main.zone}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }
}
