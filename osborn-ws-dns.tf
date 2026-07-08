resource "hcloud_zone" "ws_osborn" {
  name              = "osborn.ws"
  mode              = "primary"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_caa" {
  zone = hcloud_zone.ws_osborn.name
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

resource "hcloud_zone_rrset" "ws_osborn_dmarc_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "_dmarc"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DMARC1; p=quarantine; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;") # TODO: p=reject
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_domainkey_google_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "google._domainkey"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record(
        join("", [
          "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUP/vIbWUwcSdl9NHS87",
          "8BrrvqFMmXkg5+wjq2BRak5vEy8a0OCdWuOwbXJ9n4qLr1WCKoejzISEMUtRtBcb/RFpMgTXFyvtlYXC4f",
          "WiV89ATeQWR3vhPLIVfZMXJmurlzvUYg+aLhWW56P5aU+qrc8dkC0uh91xdk8d7ZBNJkhXw2UqAUTPkPJt",
          "LOGCvfDxfaovvwKl8QAwYtoRA8PNRI88MamrZapYQR5jCIkizZbcSxhFAG0PUFmC+36Bj3kkgKns6r2eaq",
          "G3oofP9xgq1dPYSZxf0pcbC5GQzNTVTMiVG8ZA9DHEX3CtQfNz9R3Ct1741wARgvUGbXYFxznXKQIDAQAB",
        ])
      )
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_family_cname" {
  zone = hcloud_zone.ws_osborn.name
  name = "family"
  type = "CNAME"

  records = [
    {
      value = "ghs.googlehosted.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_github_pages_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "_github-pages-challenge-nosborn"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("c0ac31227dfd5dc8b09116e614aeab")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_lordbill47_cname" {
  zone = hcloud_zone.ws_osborn.name
  name = "lordbill47"
  type = "CNAME"

  records = [
    {
      value = "ghs.googlehosted.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_mx" {
  zone = hcloud_zone.ws_osborn.name
  name = "@"
  type = "MX"

  records = [
    {
      value = "1 aspmx.l.google.com."
    },
    {
      value = "5 alt1.aspmx.l.google.com."
    },
    {
      value = "5 alt2.aspmx.l.google.com."
    },
    {
      value = "10 alt3.aspmx.l.google.com."
    },
    {
      value = "10 alt4.aspmx.l.google.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_test_cname" {
  zone = hcloud_zone.ws_osborn.name
  name = "test"
  type = "CNAME"

  records = [
    {
      value = "ghs.googlehosted.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_test_dmarc_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "_dmarc.test"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_test_domainkey_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "*._domainkey.test"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DKIM1; p=")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_txt" {
  zone = hcloud_zone.ws_osborn.name
  name = "@"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("keybase-site-verification=Ja5bgvX88XlN7aKAcL28I5VAXfNNdy90VAyEvamgkQE")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:_spf.google.com -all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ws_osborn_ww1_cname" {
  zone = hcloud_zone.ws_osborn.name
  name = "ww1"
  type = "CNAME"

  records = [
    {
      value = "ghs.googlehosted.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}
