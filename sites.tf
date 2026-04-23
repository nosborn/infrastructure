module "osborn_io" {
  source = "./modules/osborn-io"

  caa_iodef_url                     = var.caa_iodef_url
  dmarc_aggregate_reporting_address = var.dmarc_aggregate_reporting_address
  statichost_site_name              = "www-osborn-io"
  tombstone_ipv4_address            = var.tombstone_ipv4_address
  tombstone_ipv6_address            = var.tombstone_ipv6_address
}

module "osborn_ws" {
  source = "./modules/osborn-ws"

  caa_iodef_url                     = var.caa_iodef_url
  dmarc_aggregate_reporting_address = var.dmarc_aggregate_reporting_address
  # statichost_site_name              = "www-osborn-ws"
}

module "redzebraconsulting_com" {
  source = "./modules/redzebraconsulting-com"

  caa_iodef_url = var.caa_iodef_url
}
