resource "aws_route53_zone" "main" {
  name = "${var.domain_name}"

  tags {
    Project = "${var.project_tag}"
  }
}

# resource "aws_route53_record" "CAA" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name    = "${var.domain_name}."
#   type    = "CAA"
#   ttl     = 3600
#   records = ["0 issue \"letsencrypt.org\""]
# }

resource "aws_route53_record" "MX" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "MX"
  ttl     = 3600

  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com.",
  ]
}

resource "aws_route53_record" "TXT" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "TXT"
  ttl     = 3600

  records = [
    "keybase-site-verification=Ja5bgvX88XlN7aKAcL28I5VAXfNNdy90VAyEvamgkQE",
    "v=spf1 include:_spf.google.com ~all",
  ]
}

resource "aws_route53_record" "domainkey_google_TXT" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "google._domainkey.${var.domain_name}."
  type    = "TXT"
  ttl     = 3600
  records = ["v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUP/vIbWUwcSdl9NHS878BrrvqFMmXkg5+wjq2BRak5vEy8a0OCdWuOwbXJ9n4qLr1WCKoejzISEMUtRtBcb/RFpMgTXFyvtlYXC4fWiV89ATeQWR3vhPLIVfZMXJmurlzvUYg+aLhWW56P5aU+qrc8dkC0uh91xdk8d7ZBNJkhXw2UqAUTPk\" \"PJtLOGCvfDxfaovvwKl8QAwYtoRA8PNRI88MamrZapYQR5jCIkizZbcSxhFAG0PUFmC+36Bj3kkgKns6r2eaqG3oofP9xgq1dPYSZxf0pcbC5GQzNTVTMiVG8ZA9DHEX3CtQfNz9R3Ct1741wARgvUGbXYFxznXKQIDAQAB"]
}

resource "aws_route53_record" "family_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "family.${var.domain_name}."
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "lordbill47_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "lordbill47.${var.domain_name}."
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "test_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "test.${var.domain_name}."
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "ww1_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "ww1.${var.domain_name}."
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "www_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "www.${var.domain_name}."
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com."]
}
