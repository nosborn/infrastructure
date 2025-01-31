module "website" {
  source = "../static-website"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  content_security_policy = "default-src 'none'; style-src 'self'; img-src 'self'; manifest-src 'self'; report-uri https://osborn.report-uri.com/r/d/csp/enforce"
  default_root_object     = "index.html"
  domain_name             = "osborn.io"
  tags                    = var.tags
  zone_id                 = aws_route53_zone.this.id

  redirect_domain_names = [
    "www.osborn.io",
  ]

  depends_on = [
    aws_route53_record.caa,
  ]
}
