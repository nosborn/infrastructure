module "mta_sts" {
  source = "../mta-sts"

  depends_on = [
    aws_route53_record.caa,
  ]

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  domain_name                = "osborn.io"
  id                         = "20210925114437Z"
  tags                       = merge(var.tags, { "Site" = "mta-sts.osborn.io" })
  tls_json_reporting_address = var.tls_json_reporting_address
  zone_id                    = aws_route53_zone.this.id
}