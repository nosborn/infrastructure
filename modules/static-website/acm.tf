module "acm_certificate" {
  source = "../acm-certificate"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  domain_name               = var.domain_name
  tags                      = var.tags
  subject_alternative_names = sort(var.redirect_domain_names)
  zone_id                   = var.zone_id
}
