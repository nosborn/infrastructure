module "website" {
  source = "../static-website"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  content_security_policy = "default-src 'none'; report-uri https://osborn.report-uri.com/r/d/csp/enforce"
  domain_name             = "mta-sts.${var.domain_name}"
  tags                    = var.tags
  zone_id                 = var.zone_id
}

resource "aws_route53_record" "mta_sts" {
  zone_id = var.zone_id
  name    = "_mta-sts"
  type    = "TXT"
  ttl     = 3600
  records = ["v=STSv1; id=${var.id}"]
}

resource "aws_route53_record" "tls" {
  zone_id = var.zone_id
  name    = "_smtp._tls"
  type    = "TXT"
  ttl     = 3600
  records = ["v=TLSRPTv1; rua=mailto:${var.tls_json_reporting_address}"]
}

resource "aws_s3_object" "this" {
  for_each = toset([
    ".well-known/mta-sts.txt",
    "ping.txt",
    "robots.txt",
  ])

  bucket                 = module.website.content_bucket_id
  content_type           = "plain/text"
  key                    = each.value
  server_side_encryption = "AES256"
  source                 = "${path.module}/content/${each.value}"
  source_hash            = filemd5("${path.module}/content/${each.value}")
  tags                   = var.tags
}
