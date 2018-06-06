resource "aws_route53_zone" "main" {
  name = "${var.domain_name}"

  tags {
    Project = "${var.project_tag}"
  }
}

resource "aws_route53_record" "A" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "CAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "CAA"
  ttl     = 3600

  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"amazontrust.com\"",
    "0 issue \"amazonaws.com\"",
    "0 issue \"awstrust.com\"",
  ]
}

resource "aws_route53_record" "MX" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "MX"
  ttl     = 3600

  records = [
    "10 in1-smtp.messagingengine.com.",
    "20 in2-smtp.messagingengine.com.",
  ]
}

resource "aws_route53_record" "TXT" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "TXT"
  ttl     = 3600

  records = [
    "google-site-verification=8otHDcgVRYHCq_1KfVQQxfnZeTwN_ZLTpzWbPgq9YZQ",
    "keybase-site-verification=bgOD0nccVlahCce8OE-YA5B1Hmmf_1VaEd3aIX-lCSI",
    "v=spf1 include:spf.messagingengine.com ?all",
  ]
}
