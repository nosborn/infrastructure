module "go_teddit_net" {
  source = "./modules/go-teddit-net"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  dmarc_aggregate_reporting_address = "em4yo1kb@ag.ap.dmarcian.com"
  key_management_service_arn        = aws_kms_key.dnssec.arn
  tls_json_reporting_address        = "em4yo1kb@tls.ap.dmarcian.com"

  tags = {
    Site = "go-teddit.net"
  }
}

module "osborn_io" {
  source = "./modules/osborn-io"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  dmarc_aggregate_reporting_address  = "em4yo1kb@ag.ap.dmarcian.com"
  github_openid_connect_provider_arn = aws_iam_openid_connect_provider.github.arn
  key_management_service_arn         = aws_kms_key.dnssec.arn
  tls_json_reporting_address         = "em4yo1kb@tls.ap.dmarcian.com"
  tombstone_ipv4_address             = var.tombstone_ipv4_address

  tags = {
    Site = "osborn.io"
  }
}

module "osborn_ws" {
  source = "./modules/osborn-ws"

  tags = {
    Site = "osborn.ws"
  }
}

module "redzebraconsulting_com" {
  source = "./modules/redzebraconsulting-com"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  key_management_service_arn = aws_kms_key.dnssec.arn

  tags = {
    Site = "redzebraconsulting.com"
  }
}
