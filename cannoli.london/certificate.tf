resource "aws_acm_certificate" "main" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Project = "${var.project_tag}"
  }

  provider = "aws.us-east-1"
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = "${aws_acm_certificate.main.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]

  provider = "aws.us-east-1"
}

resource "aws_route53_record" "validation" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_type}"
  ttl     = 60
  records = ["${aws_acm_certificate.main.domain_validation_options.0.resource_record_value}"]
}
