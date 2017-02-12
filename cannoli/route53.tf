resource "aws_route53_zone" "cannoli" {
  name              = "${var.domain_name}"
  delegation_set_id = "${data.terraform_remote_state.core.delegation_set_id}"

  tags {
    Project = "${var.project_tag}"
  }
}

resource "aws_route53_record" "A" {
  zone_id = "${aws_route53_zone.cannoli.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA" {
  zone_id = "${aws_route53_zone.cannoli.zone_id}"
  name    = "${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "CNAME" {
  zone_id = "${aws_route53_zone.cannoli.zone_id}"
  name    = "0f1893c5e1360b28dd07a5c0f317c7c3.${var.domain_name}"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "verify.bing.com."
  ]
}

resource "aws_route53_record" "MX" {
  zone_id = "${aws_route53_zone.cannoli.zone_id}"
  name    = "${var.domain_name}"
  type    = "MX"
  ttl     = 3600

  records = [
    "10 in1-smtp.messagingengine.com.",
    "20 in2-smtp.messagingengine.com.",
  ]
}

resource "aws_route53_record" "TXT" {
  zone_id = "${aws_route53_zone.cannoli.zone_id}"
  name    = "${var.domain_name}"
  type    = "TXT"
  ttl     = 3600

  records = [
    "google-site-verification=8otHDcgVRYHCq_1KfVQQxfnZeTwN_ZLTpzWbPgq9YZQ",
    "keybase-site-verification=bgOD0nccVlahCce8OE-YA5B1Hmmf_1VaEd3aIX-lCSI"
  ]
}
