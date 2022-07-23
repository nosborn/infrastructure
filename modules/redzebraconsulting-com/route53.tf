resource "aws_route53domains_registered_domain" "this" {
  domain_name = "redzebraconsulting.com"
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
  name          = "redzebraconsulting.com"
  force_destroy = true
  tags          = var.tags

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
    "0 issue \";\"",
    "0 issuewild \";\"",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "dkim_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "*._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DKIM1; p="]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "dmarc_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 ."]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 -all"]

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
