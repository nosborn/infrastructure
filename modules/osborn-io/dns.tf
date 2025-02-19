resource "scaleway_domain_record" "bing_cname" {
  data     = "verify.bing.com."
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "7f33c9bdcbfc881a50d3f5db24af19e9"
  type     = "CNAME"

  lifecycle {
    prevent_destroy = true
  }
}

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
  data     = "0 issue \"letsencrypt.org\""
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "CAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "caa_issuewild" {
  data     = "0 issuewild \";\""
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "CAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "dmarc_txt" {
  data     = "v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_dmarc"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "github_pages_txt" {
  data     = "87a77c9df408562ad10e043fcab8d5"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_github-pages-challenge-nosborn"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "keybase_txt" {
  data     = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_keybase"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "mx" {
  for_each = toset([
    "mx01.mail.icloud.com.",
    "mx02.mail.icloud.com.",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  priority = 10
  type     = "MX"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "nick_mx" {
  for_each = toset([
    "mx01.mail.icloud.com.",
    "mx02.mail.icloud.com.",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "nick"
  priority = 10
  type     = "MX"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "nick_sig1_domainkey_cname" {
  data     = "sig1.dkim.nick.osborn.io.at.icloudmailadmin.com."
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "sig1._domainkey.nick"
  type     = "CNAME"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "nick_txt" {
  for_each = toset([
    "apple-domain=864XkC8mHsdlUA7Q",
    "v=spf1 include:icloud.com ~all",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "nick"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "scaleway_challenge_txt" {
  data     = "7b7f1412-4d04-43f4-8adf-0af970dd42f7"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_scaleway-challenge"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "sig1_domainkey_cname" {
  data     = "sig1.dkim.osborn.io.at.icloudmailadmin.com."
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "sig1._domainkey"
  type     = "CNAME"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "txt" {
  for_each = toset([
    "apple-domain=LhyS4pqHWL1l8vPv",
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "hosted-email-verify=8dqgaz7q",
    "v=spf1 include:icloud.com -all",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = ""
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

data "scaleway_domain_zone" "this" {
  domain    = "osborn.io"
  subdomain = ""
}
