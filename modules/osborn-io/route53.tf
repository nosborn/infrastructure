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
  zone_id = aws_route53_zone.this.id
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9"
  type    = "CNAME"
  ttl     = 3600
  records = ["verify.bing.com"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "CAA"
  ttl     = 3600
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
  zone_id = aws_route53_zone.this.id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; rua=mailto:${var.dmarc_aggregate_reporting_address}; adkim=s; aspf=s;"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "fastmail_dkim_cname" {
  count = 3

  zone_id = aws_route53_zone.this.id
  name    = format("fm%d._domainkey", count.index + 1)
  type    = "CNAME"
  ttl     = 3600
  records = [format("fm%d.osborn.io.dkim.fmhosted.com", count.index + 1)]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "github_pages_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "_github-pages-challenge-nosborn"
  type    = "TXT"
  ttl     = 3600
  records = ["87a77c9df408562ad10e043fcab8d5"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "keybase_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "_keybase"
  type    = "TXT"
  ttl     = 3600
  records = ["keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "nick_mx" {
  zone_id = aws_route53_zone.this.id
  name    = "nick"
  type    = "MX"
  ttl     = 3600
  records = ["10 in1-smtp.messagingengine.com.", "20 in2-smtp.messagingengine.com."]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "tombstone_a" {
  zone_id = aws_route53_zone.this.id
  name    = "tombstone"
  type    = "A"
  ttl     = 3600
  records = [var.tombstone_ipv4_address]

  lifecycle {
    prevent_destroy = true
  }
}

# resource "aws_route53_record" "tombstone_aaaa" {
#   zone_id = aws_route53_zone.this.id
#   name    = "tombstone"
#   type    = "AAAA"
#   records = [var.tombstone_ipv6_address]
# }

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "hosted-email-verify=8dqgaz7q",
    "v=spf1 include:spf.messagingengine.com -all",
  ]

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_route53_hosted_zone_dnssec" "this" {
  depends_on = [
    aws_route53_key_signing_key.this
  ]

  hosted_zone_id = aws_route53_zone.this.id
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
