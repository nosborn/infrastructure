resource "hcloud_zone" "this" {
  name              = "osborn.ws"
  mode              = "primary"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "caa" {
  zone = hcloud_zone.this.name
  name = "@"
  type = "CAA"

  records = [
    {
      value = "0 iodef \"${var.caa_iodef_url}\""
    },
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

resource "hcloud_zone_rrset" "dmarc_txt" {
  zone = hcloud_zone.this.name
  name = "_dmarc"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DMARC1; p=none; rua=mailto:${var.dmarc_aggregate_reporting_address};")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "domainkey_google_txt" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "family_cname" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "github_pages_txt" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "lordbill47_cname" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "mx" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "test_cname" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "test_dkim_txt" {
  zone = hcloud_zone.this.name
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

resource "hcloud_zone_rrset" "test_dmarc_txt" {
  zone = hcloud_zone.this.name
  name = "_dmarc.test"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "txt" {
  zone = hcloud_zone.this.name
  name = "@"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("keybase-site-verification=Ja5bgvX88XlN7aKAcL28I5VAXfNNdy90VAyEvamgkQE")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:_spf.google.com ~all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "ww1_cname" {
  zone = hcloud_zone.this.name
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
