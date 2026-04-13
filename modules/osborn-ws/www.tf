module "www" {
  source = "../www"

  domain_name          = "osborn.ws"
  statichost_site_name = "www-osborn-ws"

  depends_on = [
    hcloud_zone_rrset.caa,
  ]
}
