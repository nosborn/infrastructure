module "content_bucket" {
  source = "../modules/content-bucket"

  domain_name = cloudflare_zone.main.zone
}

resource "cloudflare_worker_route" "content_security_headers" {
  zone_id     = cloudflare_zone.main.id
  pattern     = "${module.content_bucket.id}/*"
  script_name = cloudflare_worker_script.security_headers.name
}

resource "cloudflare_record" "content_CNAME" {
  depends_on = [
    cloudflare_worker_route.content_security_headers,
  ]

  zone_id = cloudflare_zone.main.id
  name    = module.content_bucket.id
  type    = "CNAME"
  value   = module.content_bucket.website_endpoint
  proxied = true
}

module "redirect_bucket" {
  source = "../modules/redirect-bucket"

  domain_name = cloudflare_zone.main.zone
}

resource "cloudflare_worker_route" "redirect_security_headers" {
  zone_id     = cloudflare_zone.main.id
  pattern     = "${module.redirect_bucket.id}/*"
  script_name = cloudflare_worker_script.security_headers.name
}

resource "cloudflare_record" "redirect_CNAME" {
  depends_on = [
    cloudflare_worker_route.redirect_security_headers,
  ]

  zone_id = cloudflare_zone.main.id
  name    = "www.${cloudflare_zone.main.zone}"
  type    = "CNAME"
  value   = module.redirect_bucket.website_endpoint
  proxied = true
}
