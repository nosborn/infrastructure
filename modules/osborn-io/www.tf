module "www" {
  source = "../www"

  domain_name          = "osborn.io"
  statichost_site_name = var.statichost_site_name

  depends_on = [
    hcloud_zone_rrset.caa,
  ]
}
