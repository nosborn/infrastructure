module "mta_sts" {
  source = "../mta-sts"

  depends_on = [
    aws_route53_record.caa,
  ]

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  domain_name                       = "go-teddit.net"
  id                                = "20220722233525Z"
  strict_transport_security_preload = false
  tags                              = merge(var.tags, { "Site" = "mta-sts.go-teddit.net" })
  tls_json_reporting_address        = var.tls_json_reporting_address
  zone_id                           = aws_route53_zone.this.id
}
