module "go_teddit_net" {
  source = "./modules/go-teddit-net"
}

module "osborn_io" {
  source = "./modules/osborn-io"

  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  tombstone_ipv4_address            = "132.147.105.245"
  tombstone_ipv6_address            = ""
  tls_json_reporting_address        = "em4yo1kb@tls.ap.dmarcian.com"
}

module "osborn_ws" {
  source = "./modules/osborn-ws"
}