resource "aws_acm_certificate" "this" {
  provider = aws.us-east-1

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags                      = var.tags

  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "aws_route53_record" "this" {
  for_each = {
    for v in aws_acm_certificate.this.domain_validation_options : v.domain_name => {
      name   = v.resource_record_name
      record = v.resource_record_value
      type   = v.resource_record_type
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "this" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for v in aws_route53_record.this : v.fqdn]

  # lifecycle {
  #   create_before_destroy = true
  # }
}
