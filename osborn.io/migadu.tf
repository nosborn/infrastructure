resource "cloudflare_record" "migadu_verification" {
  zone_id = cloudflare_zone.main.id
  name    = "@"
  type    = "TXT"
  value   = "hosted-email-verify=8dqgaz7q"
}

resource "cloudflare_record" "migadu_mail_exchange" {
  count = 2

  zone_id  = cloudflare_zone.main.id
  name     = "@"
  type     = "MX"
  value    = format("aspmx%d.migadu.com", count.index + 1)
  priority = 10 * (count.index + 1)
}

resource "cloudflare_record" "migadu_dkim" {
  count = 3

  zone_id = cloudflare_zone.main.id
  name    = format("key%d._domainkey", count.index + 1)
  type    = "CNAME"
  value   = format("key%d.%s._domainkey.migadu.com", count.index + 1, cloudflare_zone.main.zone)
}

resource "cloudflare_record" "migadu_spf" {
  zone_id = cloudflare_zone.main.id
  name    = "@"
  type    = "TXT"
  value   = "v=spf1 include:spf.migadu.com -all"
}

resource "cloudflare_record" "migadu_legacy_dmarc" { # do not remove
  zone_id = cloudflare_zone.main.id
  name    = "default._domainkey"
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFByJNY3YVaG7bw3C2+qjr1j0isGbHUZrJluhQWvl80v+szk7L7kWOmoKQFpm/ky9MZoIdMd3MMeVJuVhzP69W9g/qiQItb8An/vOBuxwBbSzZpE3VmXsHw5bgssn9BQKWvMmJGq+qTUE4kl9vV4HlfVw/TVT2sCuM+I9paLihOQIDAQAB"
}

resource "cloudflare_record" "migadu_dmarc" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;"
}

resource "cloudflare_record" "migadu_subdomain_addressing" {
  count = 2

  zone_id  = cloudflare_zone.main.id
  name     = "*"
  type     = "MX"
  value    = cloudflare_record.migadu_mail_exchange[count.index].value
  priority = cloudflare_record.migadu_mail_exchange[count.index].priority
}

resource "cloudflare_record" "migadu_subdomain_spf" {
  zone_id = cloudflare_zone.main.id
  name    = "*"
  type    = "TXT"
  value   = "v=spf1 include:spf.migadu.com -all"
}

resource "cloudflare_record" "migadu_autoconfig" {
  zone_id = cloudflare_zone.main.id
  name    = "autoconfig"
  type    = "CNAME"
  value   = "autoconfig.migadu.com"
}

resource "cloudflare_record" "migadu_autodiscovery" {
  zone_id = cloudflare_zone.main.id
  name    = "_autodiscover._tcp"
  type    = "SRV"

  data = {
    service  = "_autodiscover"
    proto    = "_tcp"
    priority = 0
    weight   = 1
    port     = 443
    target   = "autodiscover.migadu.com"
  }
}
