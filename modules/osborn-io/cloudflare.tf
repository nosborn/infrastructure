resource "cloudflare_zone" "this" {
  zone = "osborn.io"
  plan = "free"
}

resource "cloudflare_zone_dnssec" "this" {
  zone_id = cloudflare_zone.this.id

  lifecycle {
    ignore_changes = [
      modified_on,
    ]
  }
}

resource "cloudflare_zone_settings_override" "this" {
  zone_id = cloudflare_zone.this.id

  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    brotli                   = "off"
    hotlink_protection       = "on"
    http2                    = "on"
    http3                    = "on"
    ipv6                     = "on"
    min_tls_version          = "1.2"
    opportunistic_onion      = "on"
    tls_1_3                  = "on"
    universal_ssl            = "on"
    # zero_rtt = "off"

    security_header {
      enabled            = true
      preload            = true
      max_age            = 31536000
      include_subdomains = true
      nosniff            = true
    }
  }
}

# https://support.cloudflare.com/hc/en-us/articles/115000310832-Certification-Authority-Authorization-CAA-FAQ
resource "cloudflare_record" "caa_issue" {
  for_each = toset([
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org",
  ])

  zone_id = cloudflare_zone.this.id
  name    = "@"
  type    = "CAA"

  data {
    flags = 0
    tag   = "issue"
    value = each.key
  }
}

# https://support.cloudflare.com/hc/en-us/articles/115000310832-Certification-Authority-Authorization-CAA-FAQ
resource "cloudflare_record" "caa_issuewild" {
  for_each = toset([
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org",
  ])

  zone_id = cloudflare_zone.this.id
  name    = "@"
  type    = "CAA"

  data {
    flags = 0
    tag   = "issuewild"
    value = each.key
  }
}

resource "cloudflare_record" "mx" {
  for_each = {
    "in1-smtp.messagingengine.com" = 10
    "in2-smtp.messagingengine.com" = 20
  }

  zone_id  = cloudflare_zone.this.id
  name     = "@"
  type     = "MX"
  value    = each.key
  priority = each.value
}

resource "cloudflare_record" "txt" {
  for_each = toset([
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI", # ttl = 86400
    "hosted-email-verify=8dqgaz7q",
    "v=spf1 include:spf.messagingengine.com -all",
  ])

  zone_id = cloudflare_zone.this.id
  name    = "@"
  type    = "TXT"
  value   = each.key
}

resource "cloudflare_record" "bing_cname" {
  zone_id = cloudflare_zone.this.id
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9"
  type    = "CNAME"
  value   = "verify.bing.com"
}

resource "cloudflare_record" "dmarc_txt" {
  zone_id = cloudflare_zone.this.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;"
}

resource "cloudflare_record" "fastmail_dkim_cname" {
  count = 3

  zone_id = cloudflare_zone.this.id
  name    = format("fm%d._domainkey", count.index + 1)
  type    = "CNAME"
  value   = format("fm%d.osborn.io.dkim.fmhosted.com", count.index + 1)
}

resource "cloudflare_record" "keybase_txt" {
  zone_id = cloudflare_zone.this.id
  name    = "_keybase"
  type    = "TXT"
  value   = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
}

resource "cloudflare_record" "mta_sts_txt" {
  zone_id = cloudflare_zone.this.id
  name    = "_mta-sts"
  type    = "TXT"
  value   = "v=STSv1; id=20210925114437Z;"
}

resource "cloudflare_record" "nick_mx" {
  for_each = {
    "in1-smtp.messagingengine.com" = 10
    "in2-smtp.messagingengine.com" = 20
  }

  zone_id  = cloudflare_zone.this.id
  name     = "nick"
  type     = "MX"
  value    = each.key
  priority = each.value
}

resource "cloudflare_record" "registry_caa_issue" {
  for_each = toset([
    "amazon.com",
    "amazontrust.com",
    "awstrust.com",
    "amazonaws.com",
  ])

  zone_id = cloudflare_zone.this.id
  name    = "registry"
  type    = "CAA"

  data {
    flags = 0
    tag   = "issue"
    value = each.key
  }
}

resource "cloudflare_record" "smtp_tls_txt" {
  zone_id = cloudflare_zone.this.id
  name    = "_smtp._tls"
  type    = "TXT"
  value   = "v=TLSRPTv1; rua=mailto:${var.tls_json_reporting_address}"
}

resource "cloudflare_record" "tombstone_a" {
  lifecycle {
    ignore_changes = [value]
  }

  zone_id = cloudflare_zone.this.id
  name    = "tombstone"
  type    = "A"
  value   = "127.0.0.1" # set by ddclient
}
