resource "aws_route53_delegation_set" "this" {
  reference_name = "osborn.ws"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_zone" "this" {
  name              = "osborn.ws"
  delegation_set_id = aws_route53_delegation_set.this.id
  force_destroy     = true
  tags              = var.tags

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
    "0 issue \"comodoca.com\"",
    "0 issue \"digicert.com\"",
    "0 issue \"letsencrypt.org\"",
    "0 issuewild \"comodoca.com\"",
    "0 issuewild \"digicert.com\"",
    "0 issuewild \"letsencrypt.org\"",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "domainkey_google_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = 3600

  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUP/vIbWUwcSdl9NHS878BrrvqFMmXkg5+wjq2BRak5vEy8a0OCdWuOwbXJ9n4qLr1WCKoejzISEMUtRtBcb/RFpMgTXFyvtlYXC4fWiV89ATeQWR3vhPLIVfZMXJmurlzvUYg+aLhWW56P5aU+qrc8dkC0uh91xdk8d7ZBNJkhXw2UqAUTPk\" \"PJtLOGCvfDxfaovvwKl8QAwYtoRA8PNRI88MamrZapYQR5jCIkizZbcSxhFAG0PUFmC+36Bj3kkgKns6r2eaqG3oofP9xgq1dPYSZxf0pcbC5GQzNTVTMiVG8ZA9DHEX3CtQfNz9R3Ct1741wARgvUGbXYFxznXKQIDAQAB",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "family_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "family"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "ghs.googlehosted.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "github_pages_txt" {
  zone_id = aws_route53_zone.this.id
  name    = "_github-pages-challenge-nosborn"
  type    = "TXT"
  ttl     = 3600

  records = [
    "c0ac31227dfd5dc8b09116e614aeab",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "lordbill47_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "lordbill47"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "ghs.googlehosted.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "MX"
  ttl     = 3600

  records = [
    "1 aspmx.l.google.com",
    "5 alt1.aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "test_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "test"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "ghs.googlehosted.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

# TODO:
# resource "aws_route53_record" "test_dkim_txt" {
#   zone_id = aws_route53_zone.this.id
#   name    = "*._domainkey.test"
#   type    = "TXT"
#   ttl     = 3600
#   records = ["v=DKIM1; p="]
#
#   lifecycle {
#     prevent_destroy = true
#   }
# }

# TODO:
# resource "aws_route53_record" "test_dmarc_txt" {
#   zone_id = aws_route53_zone.this.id
#   name    = "_dmarc.test"
#   type    = "TXT"
#   ttl     = 3600
#   records = ["v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"]
#
#   lifecycle {
#     prevent_destroy = true
#   }
# }

# TODO:
# resource "aws_route53_record" "test_mx" {
#   zone_id = aws_route53_zone.this.id
#   name    = "test"
#   type    = "MX"
#   ttl     = 3600
#   records = ["0 ."]
#
#   lifecycle {
#     prevent_destroy = true
#   }
# }

# TODO:
# resource "aws_route53_record" "test_txt" {
#   zone_id = aws_route53_zone.this.id
#   name    = "test"
#   type    = "TXT"
#   ttl     = 3600
#   records = ["v=spf1 -all"]
#
#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "TXT"
  ttl     = 3600

  records = [
    "keybase-site-verification=Ja5bgvX88XlN7aKAcL28I5VAXfNNdy90VAyEvamgkQE",
    "v=spf1 include:_spf.google.com ~all",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "ww1_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "ww1"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "ghs.googlehosted.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "www_cname" {
  zone_id = aws_route53_zone.this.id
  name    = "www"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "ghs.googlehosted.com",
  ]

  lifecycle {
    prevent_destroy = true
  }
}
