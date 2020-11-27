locals {
  caa = [
    ";",
  ]
  txt = [
    "v=spf1 -all",
  ]
}

resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
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
  value   = "v=DMARC1; p=reject; adkim=s; aspf=s; rua=mailto:${var.dmarc_xml_reporting_address};"
}

resource "cloudflare_record" "domainkey_wildcard_TXT" {
  zone_id = cloudflare_zone.main.id
  name    = "*._domainkey.${var.domain_name}"
  type    = "TXT"
  value   = "v=DKIM1; p="
}
