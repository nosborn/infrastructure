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
    "v=spf1 mx a include:spf.migadu.com ~all"
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
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

resource "cloudflare_record" "dmarc_TXT" {
  domain = var.domain_name
  name   = "_dmarc.${var.domain_name}"
  type   = "TXT"
  value  = "v=DMARC1; p=none; fo=1; rua=mailto:nosborn-d@dmarc.report-uri.com"
}

# resource "cloudflare_record" "domainkey_default_TXT" {
#   domain = var.domain_name
#   name   = "default._domainkey.${var.domain_name}"
#   type   = "TXT"
#   value  = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDXql1/79wgfBgu3bYrS2Q/5u549MYT+iqn6zW0LrkaUXBV3FcOoJNZORGyjGjWZW3xw6TrTm9kXUHN8KChc5IxGYeaYoB/wyXrGPh0u0P1nd0Q+KnLXrmTQ+cib4GBgdOnYveFIphKOf+redZLz9W59N19UWFnuHem8t4dDRmshwIDAQAB"
# }

resource "cloudflare_record" "www_CNAME" {
  domain  = var.domain_name
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  value   = aws_s3_bucket.redirect.website_endpoint
  proxied = true
}
