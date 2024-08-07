resource "aws_route53domains_registered_domain" "this" {
  domain_name = "osborn.io"
  tags        = var.tags

  dynamic "name_server" {
    for_each = aws_route53_zone.this.name_servers

    content {
      name = name_server.value
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_zone" "this" {
  name          = "osborn.io"
  force_destroy = true
  tags          = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "bing_cname" {
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9"
  ttl     = 3600
  type    = "CNAME"
  zone_id = aws_route53_zone.this.id

  records = [
    "verify.bing.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "caa" {
  name    = ""
  ttl     = 3600
  type    = "CAA"
  zone_id = aws_route53_zone.this.id

  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"amazonaws.com\"",
    "0 issue \"amazontrust.com\"",
    "0 issue \"awstrust.com\"",
    "0 issuewild \"amazon.com\"",
    "0 issuewild \"amazonaws.com\"",
    "0 issuewild \"amazontrust.com\"",
    "0 issuewild \"awstrust.com\"",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "dmarc_txt" {
  name    = "_dmarc"
  ttl     = 3600
  type    = "TXT"
  zone_id = aws_route53_zone.this.id

  records = [
    "v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "github_pages_txt" {
  name    = "_github-pages-challenge-nosborn"
  ttl     = 3600
  type    = "TXT"
  zone_id = aws_route53_zone.this.id

  records = [
    "87a77c9df408562ad10e043fcab8d5",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "keybase_txt" {
  name    = "_keybase"
  ttl     = 3600
  type    = "TXT"
  zone_id = aws_route53_zone.this.id

  records = [
    "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "mx" {
  name    = ""
  ttl     = 3600
  type    = "MX"
  zone_id = aws_route53_zone.this.id

  records = [
    "10 mx01.mail.icloud.com.",
    "10 mx02.mail.icloud.com.",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "nick_mx" {
  name    = "nick"
  ttl     = 3600
  type    = "MX"
  zone_id = aws_route53_zone.this.id

  records = [
    "10 mx01.mail.icloud.com.",
    "10 mx02.mail.icloud.com.",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "nick_sig1_domainkey_cname" {
  name    = "sig1._domainkey.nick"
  ttl     = 3600
  type    = "CNAME"
  zone_id = aws_route53_zone.this.id

  records = [
    "sig1.dkim.nick.osborn.io.at.icloudmailadmin.com.",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "nick_txt" {
  name    = "nick"
  ttl     = 3600
  type    = "TXT"
  zone_id = aws_route53_zone.this.id

  records = [
    "apple-domain=864XkC8mHsdlUA7Q",
    "v=spf1 include:icloud.com ~all",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "sig1_domainkey_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "sig1._domainkey"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "sig1.dkim.osborn.io.at.icloudmailadmin.com.",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "tombstone_caa" {
  name    = "tombstone"
  ttl     = 60
  type    = "CAA"
  zone_id = aws_route53_zone.this.id

  records = [
    "0 issue \"letsencrypt.org;validationmethods=http-01\"",
    "0 issuewild \";\"",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "txt" {
  name    = ""
  ttl     = 3600
  type    = "TXT"
  zone_id = aws_route53_zone.this.id

  records = [
    "apple-domain=LhyS4pqHWL1l8vPv",
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "hosted-email-verify=8dqgaz7q",
    "v=spf1 include:icloud.com -all",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  hosted_zone_id = aws_route53_zone.this.id

  depends_on = [
    aws_route53_key_signing_key.this
  ]
}

resource "aws_route53_key_signing_key" "this" {
  hosted_zone_id             = aws_route53_zone.this.id
  key_management_service_arn = var.key_management_service_arn
  name                       = random_string.ksk.result

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_string" "ksk" {
  keepers = {
    hosted_zone_id             = aws_route53_zone.this.id
    key_management_service_arn = var.key_management_service_arn
  }

  length  = 32
  special = false

  lifecycle {
    create_before_destroy = true
  }
}
