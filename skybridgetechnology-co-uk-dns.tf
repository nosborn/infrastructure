resource "hcloud_zone" "uk_co_skybridgetechnology" {
  name              = "skybridgetechnology.co.uk"
  mode              = "primary"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "uk_co_skybridgetechnology_caa" {
  zone = hcloud_zone.uk_co_skybridgetechnology.name
  name = "@"
  type = "CAA"

  records = [
    {
      value = "0 issue \"letsencrypt.org\""
    },
    {
      value = "0 issuewild \";\""
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "uk_co_skybridgetechnology_dmarc_txt" {
  zone = hcloud_zone.uk_co_skybridgetechnology.name
  name = "_dmarc"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "uk_co_skybridgetechnology_mx" {
  zone = hcloud_zone.uk_co_skybridgetechnology.name
  name = "@"
  type = "MX"

  records = [
    {
      value = "10 mx01.mail.icloud.com."
    },
    {
      value = "10 mx02.mail.icloud.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "uk_co_skybridgetechnology_domainkey_sig1_cname" {
  zone = hcloud_zone.uk_co_skybridgetechnology.name
  name = "sig1._domainkey"
  type = "CNAME"

  records = [
    {
      value = "sig1.dkim.skybridgetechnology.co.uk.at.icloudmailadmin.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "uk_co_skybridgetechnology_txt" {
  zone = hcloud_zone.uk_co_skybridgetechnology.name
  name = "@"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("apple-domain=2YOFYsxUeXxX9mxS")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:icloud.com -all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}
