resource "hcloud_zone" "this" {
  name              = "osborn.io"
  mode              = "primary"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "atproto_txt" { # BlueSky verification
  zone = hcloud_zone.this.name
  name = "_atproto"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("did=did:plc:q43v3sapoehpy52prsp6sbvr")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "bing_cname" {
  zone = hcloud_zone.this.name
  name = "7f33c9bdcbfc881a50d3f5db24af19e9"
  type = "CNAME"

  records = [
    {
      value = "verify.bing.com."
    },
  ]

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
      value = provider::hcloud::txt_record("v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;")
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
      value = provider::hcloud::txt_record("87a77c9df408562ad10e043fcab8d5")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "keybase_txt" {
  zone = hcloud_zone.this.name
  name = "_keybase"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4")
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

resource "hcloud_zone_rrset" "nick_mx" {
  zone = hcloud_zone.this.name
  name = "nick"
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

resource "hcloud_zone_rrset" "nick_sig1_domainkey_cname" {
  zone = hcloud_zone.this.name
  name = "sig1._domainkey.nick"
  type = "CNAME"

  records = [
    {
      value = "sig1.dkim.nick.osborn.io.at.icloudmailadmin.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "nick_txt" {
  zone = hcloud_zone.this.name
  name = "nick"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("apple-domain=864XkC8mHsdlUA7Q")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:icloud.com ~all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_a" {
  zone = hcloud_zone.this.name
  name = "pds"
  type = "A"

  records = [
    {
      value = var.tombstone_ipv4_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_aaaa" {
  zone = hcloud_zone.this.name
  name = "pds"
  type = "AAAA"

  records = [
    {
      value = var.tombstone_ipv6_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_https" {
  zone = hcloud_zone.this.name
  name = "pds"
  type = "HTTPS"

  records = [
    {
      value = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_wildcard_a" {
  zone = hcloud_zone.this.name
  name = "*.pds"
  type = "A"

  records = [
    {
      value = var.tombstone_ipv4_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_wildcard_aaaa" {
  zone = hcloud_zone.this.name
  name = "*.pds"
  type = "AAAA"

  records = [
    {
      value = var.tombstone_ipv6_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "pds_wildcard_https" {
  zone = hcloud_zone.this.name
  name = "*.pds"
  type = "HTTPS"

  records = [
    {
      value = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "scaleway_challenge_txt" {
  zone = hcloud_zone.this.name
  name = "_scaleway-challenge"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("7b7f1412-4d04-43f4-8adf-0af970dd42f7")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "sig1_domainkey_cname" {
  zone = hcloud_zone.this.name
  name = "sig1._domainkey"
  type = "CNAME"

  records = [
    {
      value = "sig1.dkim.osborn.io.at.icloudmailadmin.com."
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
      value = provider::hcloud::txt_record("apple-domain=LhyS4pqHWL1l8vPv")
    },
    {
      value = provider::hcloud::txt_record("google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI")
    },
    {
      value = provider::hcloud::txt_record("hosted-email-verify=8dqgaz7q")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:icloud.com -all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "tombstone_a" {
  zone = hcloud_zone.this.name
  name = "tombstone"
  type = "A"

  records = [
    {
      value = var.tombstone_ipv4_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "tombstone_aaaa" {
  zone = hcloud_zone.this.name
  name = "tombstone"
  type = "AAAA"

  records = [
    {
      value = var.tombstone_ipv6_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "tombstone_https" {
  zone = hcloud_zone.this.name
  name = "tombstone"
  type = "HTTPS"

  records = [
    {
      value = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "tombstone_mx" {
  zone = hcloud_zone.this.name
  name = "tombstone"
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

resource "hcloud_zone_rrset" "tombstone_sig1_domainkey_cname" {
  zone = hcloud_zone.this.name
  name = "sig1._domainkey.tombstone"
  type = "CNAME"

  records = [
    {
      value = "sig1.dkim.tombstone.osborn.io.at.icloudmailadmin.com."
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "tombstone_txt" {
  zone = hcloud_zone.this.name
  name = "tombstone"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("apple-domain=ymQqXtRROTfMmcEx")
    },
    {
      value = provider::hcloud::txt_record("v=spf1 include:icloud.com ~all")
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "atproto_txt" { # BlueSky verification
  data     = "did=did:plc:q43v3sapoehpy52prsp6sbvr"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "_atproto"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

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

resource "scaleway_domain_record" "pds_a" {
  data     = var.tombstone_ipv4_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "pds"
  type     = "A"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "pds_aaaa" {
  data     = var.tombstone_ipv6_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "pds"
  type     = "AAAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "pds_https" {
  data     = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "pds"
  type     = "HTTPS"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "pds_wildcard_a" {
  data     = var.tombstone_ipv4_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "*.pds"
  type     = "A"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "pds_wildcard_aaaa" {
  data     = var.tombstone_ipv6_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "*.pds"
  type     = "AAAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "pds_wildcard_https" {
  data     = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "*.pds"
  type     = "HTTPS"

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

resource "scaleway_domain_record" "tombstone_a" {
  data     = var.tombstone_ipv4_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "tombstone"
  type     = "A"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "tombstone_aaaa" {
  data     = var.tombstone_ipv6_address
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "tombstone"
  type     = "AAAA"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "tombstone_https" {
  data     = "1 . alpn=h2 ipv4hint=${var.tombstone_ipv4_address} ipv6hint=${var.tombstone_ipv6_address}"
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "tombstone"
  type     = "HTTPS"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "tombstone_mx" {
  for_each = toset([
    "mx01.mail.icloud.com.",
    "mx02.mail.icloud.com.",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "tombstone"
  priority = 10
  type     = "MX"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "tombstone_sig1_domainkey_cname" {
  data     = "sig1.dkim.tombstone.osborn.io.at.icloudmailadmin.com."
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "sig1._domainkey.tombstone"
  type     = "CNAME"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_domain_record" "tombstone_txt" {
  for_each = toset([
    "apple-domain=ymQqXtRROTfMmcEx",
    "v=spf1 include:icloud.com ~all",
  ])

  data     = each.key
  dns_zone = data.scaleway_domain_zone.this.domain
  name     = "tombstone"
  type     = "TXT"

  lifecycle {
    prevent_destroy = true
  }
}

data "scaleway_domain_zone" "this" {
  domain    = "osborn.io"
  subdomain = ""
}
