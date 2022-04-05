resource "cloudflare_zone" "this" {
  zone = "go-teddit.net"
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
    "v=spf1 include:spf.messagingengine.com -all",
  ])

  zone_id = cloudflare_zone.this.id
  name    = "@"
  type    = "TXT"
  value   = each.key
}

resource "cloudflare_record" "dmarc_txt" {
  zone_id = cloudflare_zone.this.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=reject; adkim=s; aspf=s;"
}

resource "cloudflare_record" "fastmail_dkim_cname" {
  count = 3

  zone_id = cloudflare_zone.this.id
  name    = format("fm%d._domainkey", count.index + 1)
  type    = "CNAME"
  value   = format("fm%d.go-teddit.net.dkim.fmhosted.com", count.index + 1)
}
