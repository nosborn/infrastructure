module "website" {
  source = "../static-website"

  depends_on = [
    aws_route53_record.caa,
  ]

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  content_security_policy = "default-src 'none'; report-uri https://osborn.report-uri.com/r/d/csp/enforce"
  domain_name             = "www.osborn.io"
  redirect_domain_names   = ["osborn.io"]
  tags                    = var.tags
  zone_id                 = aws_route53_zone.this.id
}
