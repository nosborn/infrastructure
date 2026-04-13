resource "hcloud_zone" "this" {
  name              = "redzebraconsulting.com"
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
      value = "0 issue \";\""
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "domainkey_txt" {
  zone = hcloud_zone.this.name
  name = "*._domainkey"
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

resource "hcloud_zone_rrset" "dmarc_txt" {
  zone = hcloud_zone.this.name
  name = "_dmarc"
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

resource "hcloud_zone_rrset" "github_pages_txt" {
  zone = hcloud_zone.this.name
  name = "_github-pages-challenge-nosborn"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("e8257f895251dd0482c291a3bbfe51")
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
      value = "0 ."
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
      value = provider::hcloud::txt_record("v=spf1 -all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}
