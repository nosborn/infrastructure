locals {
  mx = [
    "10 aspmx1.migadu.com",
    "20 aspmx2.migadu.com",
  ]
  txt = [
    "hosted-email-verify=huw3rllc", # Migadu verification record
    "v=spf1 include:spf.migadu.com -all",
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
}

resource "cloudflare_zone_settings_override" "main" {
  zone_id = cloudflare_zone.main.id

  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    email_obfuscation        = "on"
    hotlink_protection       = "on"
    ssl                      = "flexible" # TODO: "full"
    tls_1_3                  = "on"
    websockets               = "off"

    security_header {
      enabled            = true
      include_subdomains = true
      max_age            = 31536000
      nosniff            = true
      preload            = true
    }
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

resource "cloudflare_record" "dmarc_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"
  value   = "v=DMARC1; p=reject;"
}

resource "cloudflare_record" "domainkey_CNAME" {
  count = 3

  zone_id = cloudflare_zone.main.id
  name    = "key${count.index + 1}._domainkey.${var.domain_name}"
  type    = "CNAME"
  value   = "key${count.index + 1}.${var.domain_name}._domainkey.migadu.com"
}
