module "mta_sts" {
  source = "../mta-sts"

  domain_name          = data.scaleway_domain_zone.this.domain
  id                   = "20220916115504Z"
  mx_fqdns             = [for v in scaleway_domain_record.mx : trimsuffix(v.data, ".")]
  statichost_site_name = "mta-sts-osborn-io"

  depends_on = [
    scaleway_domain_record.caa_iodef,
    scaleway_domain_record.caa_issue,
  ]
}
