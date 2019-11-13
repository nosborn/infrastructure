resource "cloudflare_worker_route" "main" {
  zone_id = cloudflare_zone.main.id
  pattern = "*${var.domain_name}/"
  enabled = true

  depends_on = ["cloudflare_worker_script.main"]
}

resource "cloudflare_worker_script" "main" {
  zone_id = cloudflare_zone.main.id
  content = "${file("worker.js")}"
}
