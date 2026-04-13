module "mta_sts" {
  source = "../mta-sts"

  domain_name          = hcloud_zone.this.name
  id                   = "20220916115504Z"
  mx_fqdns             = [for v in hcloud_zone_rrset.mx.records : trimsuffix(split(" ", v.value)[1], ".")]
  statichost_site_name = "mta-sts-osborn-io"

  depends_on = [
    hcloud_zone_rrset.caa,
  ]
}
