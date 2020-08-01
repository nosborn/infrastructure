resource "cloudflare_worker_route" "main" {
  zone_id     = cloudflare_zone.main.id
  pattern     = "*${var.domain_name}/"
  script_name = cloudflare_worker_script.main.name
}

resource "cloudflare_worker_script" "main" {
  name    = "luctam-com"
  content = file("worker.js")
}
