module "mta_sts_content_bucket" {
  source = "../modules/content-bucket"

  domain_name = "mta-sts.${cloudflare_zone.main.zone}"
}

resource "aws_s3_bucket_object" "mta_sts_policy" {
  bucket       = module.mta_sts_content_bucket.id
  key          = ".well-known/mta-sts.txt"
  source       = "mta-sts.txt"
  content_type = "text/plain"
  etag         = md5(file("mta-sts.txt"))
}

resource "cloudflare_worker_route" "mta_sts_security_headers" {
  zone_id     = cloudflare_zone.main.id
  pattern     = "${module.mta_sts_content_bucket.id}/*"
  script_name = cloudflare_worker_script.security_headers.name
}

resource "cloudflare_record" "mta_sts_CNAME" {
  depends_on = [
    cloudflare_worker_route.mta_sts_security_headers,
  ]

  zone_id = cloudflare_zone.main.id
  name    = module.mta_sts_content_bucket.id
  type    = "CNAME"
  value   = module.mta_sts_content_bucket.website_endpoint
  proxied = true
}

resource "cloudflare_record" "mta_sts_TXT" {
  for_each = {
    "_mta-sts"   = "v=STSv1; id=${aws_s3_bucket_object.mta_sts_policy.etag};",
    "_smtp._tls" = "v=TLSRPTv1; rua=mailto:${var.tls_json_reporting_address}",
  }

  zone_id = cloudflare_zone.main.id
  name    = "${each.key}.${cloudflare_zone.main.zone}"
  type    = "TXT"
  value   = each.value
}
