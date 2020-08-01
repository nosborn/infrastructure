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
    "google-site-verification=8otHDcgVRYHCq_1KfVQQxfnZeTwN_ZLTpzWbPgq9YZQ",
    "hosted-email-verify=sis8qlms", # Migadu verification record
    "v=spf1 include:spf.migadu.com -all",
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
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
  name    = "0f1893c5e1360b28dd07a5c0f317c7c3.${var.domain_name}"
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

resource "cloudflare_record" "www_CNAME" {
  zone_id = cloudflare_zone.main.id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  value   = module.redirect_bucket.website_endpoint
  proxied = true
}
