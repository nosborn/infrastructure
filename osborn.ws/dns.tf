locals {
  caa = [
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org"
  ]
  mx = [
    "1 aspmx.l.google.com",
    "5 alt1.aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com"
  ]
  txt = [
    "keybase-site-verification=Ja5bgvX88XlN7aKAcL28I5VAXfNNdy90VAyEvamgkQE",
    "v=spf1 include:_spf.google.com ~all"
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
}

resource "cloudflare_record" "CAA_issue" {
  domain = var.domain_name
  name   = var.domain_name
  type   = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = local.caa[count.index]
  }

  count = length(local.caa)
}

resource "cloudflare_record" "CAA_issuewild" {
  domain = var.domain_name
  name   = var.domain_name
  type   = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = local.caa[count.index]
  }

  count = length(local.caa)
}

resource "cloudflare_record" "MX" {
  domain   = var.domain_name
  name     = var.domain_name
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)

  count = length(local.mx)
}

resource "cloudflare_record" "TXT" {
  domain = var.domain_name
  name   = var.domain_name
  type   = "TXT"
  value  = local.txt[count.index]

  count = length(local.txt)
}

resource "cloudflare_record" "domainkey_google_TXT" {
  domain = var.domain_name
  name   = "google._domainkey.${var.domain_name}"
  type   = "TXT"
  value  = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUP/vIbWUwcSdl9NHS878BrrvqFMmXkg5+wjq2BRak5vEy8a0OCdWuOwbXJ9n4qLr1WCKoejzISEMUtRtBcb/RFpMgTXFyvtlYXC4fWiV89ATeQWR3vhPLIVfZMXJmurlzvUYg+aLhWW56P5aU+qrc8dkC0uh91xdk8d7ZBNJkhXw2UqAUTPk\" \"PJtLOGCvfDxfaovvwKl8QAwYtoRA8PNRI88MamrZapYQR5jCIkizZbcSxhFAG0PUFmC+36Bj3kkgKns6r2eaqG3oofP9xgq1dPYSZxf0pcbC5GQzNTVTMiVG8ZA9DHEX3CtQfNz9R3Ct1741wARgvUGbXYFxznXKQIDAQAB"
}

resource "cloudflare_record" "family_CNAME" {
  domain  = var.domain_name
  name    = "family.${var.domain_name}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
  proxied = true
}

resource "cloudflare_record" "lordbill47_CNAME" {
  domain  = var.domain_name
  name    = "lordbill47.${var.domain_name}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
  proxied = true
}

resource "cloudflare_record" "test_CNAME" {
  domain  = var.domain_name
  name    = "test.${var.domain_name}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
  proxied = true
}

resource "cloudflare_record" "ww1_CNAME" {
  domain  = var.domain_name
  name    = "ww1.${var.domain_name}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
  proxied = true
}

resource "cloudflare_record" "www_CNAME" {
  domain  = var.domain_name
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
  proxied = true
}
