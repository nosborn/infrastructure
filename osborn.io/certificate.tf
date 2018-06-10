resource "aws_acm_certificate" "main" {
  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    Project = "${var.project_tag}"
  }

  depends_on = ["aws_route53_record.CAA"]
  provider   = "aws.us-east-1"
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = "${aws_acm_certificate.main.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.*.fqdn}"]

  provider = "aws.us-east-1"
}

resource "aws_route53_record" "validation" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_type")}"
  ttl     = 60
  records = ["${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_value")}"]

  count = 2 # "${length(aws_acm_certificate.main.domain_validation_options)}"
}
