resource "scaleway_domain_record" "caa_iodef" {
  data     = "0 iodef \"${var.caa_iodef_url}\""
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "CAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "caa_issue" {
  data     = "0 issue \";\""
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "CAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "domainkey_txt" {
  data     = "v=DKIM1; p="
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "*._domainkey"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "dmarc_txt" {
  data     = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_dmarc"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "github_pages_txt" {
  data     = "e8257f895251dd0482c291a3bbfe51"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_github-pages-challenge-nosborn"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "mx" {
  data     = "."
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  priority = 0
  type     = "MX"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "txt" {
  data     = "v=spf1 -all"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

data "scaleway_domain_zone" "this" {
  domain    = "redzebraconsulting.com"
  subdomain = ""
}
