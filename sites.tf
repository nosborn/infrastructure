module "osborn_io" {
  source = "./modules/osborn-io"

  caa_iodef_url                     = var.caa_iodef_url
  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  statichost_site_name              = "www-osborn-io"
  tombstone_ipv4_address            = "185.250.11.186"
  tombstone_ipv6_address            = "2a0b:9401:8b:1:3e07:54ff:fe5c:dd07"
}

module "osborn_ws" {
  source = "./modules/osborn-ws"

  caa_iodef_url                     = var.caa_iodef_url
  dependabot_scaleway_api_key       = scaleway_iam_api_key.dependabot.secret_key
  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  github_actions_scaleway_api_key   = scaleway_iam_api_key.github_actions.secret_key
  # statichost_site_name              = "www-osborn-io"
}

module "redzebraconsulting_com" {
  source = "./modules/redzebraconsulting-com"

  caa_iodef_url = var.caa_iodef_url
}
