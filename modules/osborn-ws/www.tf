module "www" {
  source = "../www"

  domain_name          = "osborn.ws"
  scaleway_dns_zone    = data.scaleway_domain_zone.this.id
  statichost_site_name = "www-osborn-ws"

  depends_on = [
    scaleway_domain_record.caa_iodef,
    scaleway_domain_record.caa_issue,
  ]
}
