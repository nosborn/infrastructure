resource "cloudflare_worker_route" "main" {
  zone    = var.domain_name
  pattern = "*${var.domain_name}/"
  enabled = true

  depends_on = ["cloudflare_worker_script.main"]
}

resource "cloudflare_worker_script" "main" {
  zone    = var.domain_name
  content = "${file("worker.js")}"
}
