module "osborn_io" {
  source = "./modules/osborn-io"

  caa_iodef_url                     = var.caa_iodef_url
  dependabot_scaleway_api_key       = scaleway_iam_api_key.dependabot.secret_key
  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  github_actions_scaleway_api_key   = scaleway_iam_api_key.github_actions.secret_key
}

module "osborn_ws" {
  source = "./modules/osborn-ws"

  caa_iodef_url                     = var.caa_iodef_url
  dependabot_scaleway_api_key       = scaleway_iam_api_key.dependabot.secret_key
  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  github_actions_scaleway_api_key   = scaleway_iam_api_key.github_actions.secret_key
}

module "redzebraconsulting_com" {
  source = "./modules/redzebraconsulting-com"

  caa_iodef_url = var.caa_iodef_url
}
