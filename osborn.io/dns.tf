locals {
  caa = [
    "comodoca.com",
    "digicert.com",
    "letsencrypt.org"
  ]
  mx = [
    "10 aspmx1.migadu.com",
    "20 aspmx2.migadu.com"
  ]
  txt = [
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "v=spf1 mx a include:spf.migadu.com ~all"
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
}

resource "cloudflare_zone_settings_override" "main" {
  name = var.domain_name
}

resource "cloudflare_record" "CNAME" {
  domain  = var.domain_name
  name    = var.domain_name
  type    = "CNAME"
  value   = aws_s3_bucket.content.website_endpoint
  proxied = true
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

resource "cloudflare_record" "bing_CNAME" {
  domain = var.domain_name
  name   = "7f33c9bdcbfc881a50d3f5db24af19e9.${var.domain_name}"
  type   = "CNAME"
  value  = "verify.bing.com"
}

resource "cloudflare_record" "dmarc_TXT" {
  domain = var.domain_name
  name   = "_dmarc.${var.domain_name}"
  type   = "TXT"
  value  = "v=DMARC1; p=none; fo=1; rua=mailto:nosborn-d@dmarc.report-uri.com"
}

resource "cloudflare_record" "domainkey_default_TXT" {
  domain = var.domain_name
  name   = "default._domainkey.${var.domain_name}"
  type   = "TXT"
  value  = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFByJNY3YVaG7bw3C2+qjr1j0isGbHUZrJluhQWvl80v+szk7L7kWOmoKQFpm/ky9MZoIdMd3MMeVJuVhzP69W9g/qiQItb8An/vOBuxwBbSzZpE3VmXsHw5bgssn9BQKWvMmJGq+qTUE4kl9vV4HlfVw/TVT2sCuM+I9paLihOQIDAQAB"
}

resource "cloudflare_record" "keybase_TXT" {
  domain = var.domain_name
  name   = "_keybase.${var.domain_name}"
  type   = "TXT"
  value  = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
}

resource "cloudflare_record" "mediastreamer_A" {
  domain  = var.domain_name
  name    = "mediastreamer.${var.domain_name}"
  type    = "A"
  value   = "0.0.0.0"
  proxied = false

  lifecycle {
    ignore_changes = ["value"]
  }
}

resource "cloudflare_record" "mediastreamer_CAA_issue" {
  domain = var.domain_name
  name   = "mediastreamer.${var.domain_name}"
  type   = "CAA"

  data = {
    flags = 0
    tag   = "issue"
    value = ";"
  }
}

resource "cloudflare_record" "mediastreamer_CAA_issuewild" {
  domain = var.domain_name
  name   = "mediastreamer.${var.domain_name}"
  type   = "CAA"

  data = {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }
}

resource "cloudflare_record" "nick_MX" {
  domain   = var.domain_name
  name     = "nick.${var.domain_name}"
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)

  count = length(local.mx)
}

resource "cloudflare_record" "nick_TXT" {
  domain = var.domain_name
  name   = "nick.${var.domain_name}"
  type   = "TXT"
  value  = "v=spf1 mx a include:spf.migadu.com ~all"
}

resource "cloudflare_record" "nick_domainkey_default_TXT" {
  domain = var.domain_name
  name   = "default._domainkey.nick.${var.domain_name}"
  type   = "TXT"
  value  = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsH9zwOVNT9NobOAvbZnB3N2rTaywltT2rxI4N7+SGEmDgbOmP4LRf0qIUcUskohrEAo76b/1Ogkw5Oq0eep5+vKi8AwJSW8uoykvWEDrswoKECvxriG0sByuFYi53RkYei1hDkL1tjnIJCjRUPAN2MyzeLzUcnoR0v3ha5xGINQIDAQAB"
}

resource "cloudflare_record" "tombstone_MX" {
  domain   = var.domain_name
  name     = "tombstone.${var.domain_name}"
  type     = "MX"
  value    = element(split(" ", local.mx[count.index]), 1)
  priority = element(split(" ", local.mx[count.index]), 0)

  count = length(local.mx)
}

resource "cloudflare_record" "tombstone_TXT" {
  domain = var.domain_name
  name   = "tombstone.${var.domain_name}"
  type   = "TXT"
  value  = "v=spf1 mx a include:spf.migadu.com ~all"
}

resource "cloudflare_record" "tombstone_domainkey_default_TXT" {
  domain = var.domain_name
  name   = "default._domainkey.tombstone.${var.domain_name}"
  type   = "TXT"
  value  = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwEQBLDX8DjNiVHYkc+znhgAeZx3ffIsm66y+i7y/Ocf+kWZXruClDJeijgaZ4V37Y3CTVeORwu2vSq1hju1K9/cToXvtMDtg7ItNcTpHB+WeyMt/QOVCiqPBibIAFbTIHj5S/SjTPu+2CHkvpBXV7vhdzbo1wG1SGkqA7UfGm/wIDAQAB"
}

resource "cloudflare_record" "www_CNAME" {
  domain  = var.domain_name
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  value   = aws_s3_bucket.content.website_endpoint
  proxied = true
}
