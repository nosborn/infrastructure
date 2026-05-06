moved {
  from = module.redzebraconsulting_com.hcloud_zone.this
  to   = hcloud_zone.com_redzebraconsulting
}

resource "hcloud_zone" "com_redzebraconsulting" {
  name              = "redzebraconsulting.com"
  mode              = "primary"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.caa
  to   = hcloud_zone_rrset.com_redzebraconsulting_caa
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_caa" {
  zone = hcloud_zone.com_redzebraconsulting.name
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

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.domainkey_txt
  to   = hcloud_zone_rrset.com_redzebraconsulting_domainkey_txt
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_domainkey_txt" {
  zone = hcloud_zone.com_redzebraconsulting.name
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

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.dmarc_txt
  to   = hcloud_zone_rrset.com_redzebraconsulting_dmarc_txt
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_dmarc_txt" {
  zone = hcloud_zone.com_redzebraconsulting.name
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

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.github_pages_txt
  to   = hcloud_zone_rrset.com_redzebraconsulting_github_pages_txt
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_github_pages_txt" {
  zone = hcloud_zone.com_redzebraconsulting.name
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

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.mx
  to   = hcloud_zone_rrset.com_redzebraconsulting_mx
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_mx" {
  zone = hcloud_zone.com_redzebraconsulting.name
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

moved {
  from = module.redzebraconsulting_com.hcloud_zone_rrset.txt
  to   = hcloud_zone_rrset.com_redzebraconsulting_txt
}

resource "hcloud_zone_rrset" "com_redzebraconsulting_txt" {
  zone = hcloud_zone.com_redzebraconsulting.name
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
