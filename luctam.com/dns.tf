resource "cloudflare_zone" "main" {
  zone = var.domain_name
  plan = "free"
  type = "full"
}
