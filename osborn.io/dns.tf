locals {
  caa = [
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org",
  ]
  mx = [
    "10 aspmx1.migadu.com",
    "20 aspmx2.migadu.com",
  ]
  txt = [
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "hosted-email-verify=8dqgaz7q", # Migadu verification record
    "v=spf1 include:spf.migadu.com -all",
  ]
  txt_nick = [
    "hosted-email-verify=z8sz4kpr", # Migadu verification record
    "v=spf1 include:spf.migadu.com -all",
  ]
  txt_tombstone = [
    "hosted-email-verify=5g43axig", # Migadu verification record
    "v=spf1 include:spf.migadu.com -all",
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
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
    tls_1_3                  = "on"
    websockets               = "off"

    security_header {
      enabled            = true
      preload            = true
      max_age            = 31536000
      include_subdomains = true
      nosniff            = true
    }
  }
}

resource "cloudflare_record" "CNAME" {
  zone_id = cloudflare_zone.main.id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.content_bucket.website_endpoint
  proxied = true
}

resource "cloudflare_record" "CAA_issue" {
  count = length(local.caa)

  zone_id = cloudflare_zone.main.id
  name    = var.domain_name
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = local.caa[count.index]
  }
}

resource "cloudflare_record" "CAA_issuewild" {
  count = length(local.caa)

  zone_id = cloudflare_zone.main.id
  name    = var.domain_name
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = local.caa[count.index]
  }
}

resource "cloudflare_record" "MX" {
  count = length(local.mx)

  zone_id  = cloudflare_zone.main.id
  name     = var.domain_name
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)
}

resource "cloudflare_record" "TXT" {
  count = length(local.txt)

  zone_id = cloudflare_zone.main.id
  name    = var.domain_name
  type    = "TXT"
  value   = local.txt[count.index]
}

resource "cloudflare_record" "bing_CNAME" {
  zone_id = cloudflare_zone.main.id
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9.${var.domain_name}"
  type    = "CNAME"
  value   = "verify.bing.com"
}

resource "cloudflare_record" "dmarc_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"
  value   = "v=DMARC1; p=reject;" # Reject 100% of non-aligned messages
}

resource "cloudflare_record" "domainkey_CNAME" {
  count = 3

  zone_id = cloudflare_zone.main.id
  name    = "key${count.index + 1}._domainkey.${var.domain_name}"
  type    = "CNAME"
  value   = "key${count.index + 1}.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "domainkey_default_TXT" { # Legacy but do not remove
  zone_id = cloudflare_zone.main.id
  name    = "default._domainkey.${var.domain_name}"
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFByJNY3YVaG7bw3C2+qjr1j0isGbHUZrJluhQWvl80v+szk7L7kWOmoKQFpm/ky9MZoIdMd3MMeVJuVhzP69W9g/qiQItb8An/vOBuxwBbSzZpE3VmXsHw5bgssn9BQKWvMmJGq+qTUE4kl9vV4HlfVw/TVT2sCuM+I9paLihOQIDAQAB"
}

resource "cloudflare_record" "keybase_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_keybase.${var.domain_name}"
  type    = "TXT"
  value   = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
}

resource "cloudflare_record" "nick_MX" {
  count = length(local.mx)

  zone_id  = cloudflare_zone.main.id
  name     = "nick.${var.domain_name}"
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)
}

resource "cloudflare_record" "nick_TXT" {
  count = length(local.txt_nick)

  zone_id = cloudflare_zone.main.id
  name    = "nick.${var.domain_name}"
  type    = "TXT"
  value   = local.txt_nick[count.index]
}

resource "cloudflare_record" "nick_dmarc_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc.nick.${var.domain_name}"
  type    = "TXT"
  value   = "v=DMARC1; p=reject;" # Reject 100% of non-aligned messages
}

resource "cloudflare_record" "nick_domainkey_CNAME" {
  count = 3

  zone_id = cloudflare_zone.main.id
  name    = "key${count.index + 1}._domainkey.nick.${var.domain_name}"
  type    = "CNAME"
  value   = "key${count.index + 1}.nick.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "tombstone_A" {
  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${var.domain_name}"
  type    = "A"
  value   = "223.25.71.172"
}

resource "cloudflare_record" "tombstone_MX" {
  count = length(local.mx)

  zone_id  = cloudflare_zone.main.id
  name     = "tombstone.${var.domain_name}"
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)
}

resource "cloudflare_record" "tombstone_TXT" {
  count = length(local.txt_tombstone)

  zone_id = cloudflare_zone.main.id
  name    = "tombstone.${var.domain_name}"
  type    = "TXT"
  value   = local.txt_tombstone[count.index]
}

resource "cloudflare_record" "tombstone_dmarc_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc.tombstone.${var.domain_name}"
  type    = "TXT"
  value   = "v=DMARC1; p=reject;" # Reject 100% of non-aligned messages
}

resource "cloudflare_record" "tombstone_domainkey_CNAME" {
  count = 3

  zone_id = cloudflare_zone.main.id
  name    = "key${count.index + 1}._domainkey.tombstone.${var.domain_name}"
  type    = "CNAME"
  value   = "key${count.index + 1}.tombstone.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "unifi_CAA_issue" {
  zone_id = cloudflare_zone.main.id
  name    = "unifi.${var.domain_name}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
}

resource "cloudflare_record" "unifi_CAA_issuewild" {
  zone_id = cloudflare_zone.main.id
  name    = "unifi.${var.domain_name}"
  type    = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }
}

resource "cloudflare_record" "www_CNAME" {
  zone_id = cloudflare_zone.main.id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  value   = module.content_bucket.website_endpoint
  proxied = true
}
