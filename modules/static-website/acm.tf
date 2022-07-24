module "acm_certificate" {
  source = "../acm-certificate"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  domain_name               = var.domain_name
  tags                      = var.tags
  subject_alternative_names = sort(var.redirect_domain_names)
  zone_id                   = var.zone_id
}
