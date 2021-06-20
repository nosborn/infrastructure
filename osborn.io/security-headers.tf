resource "cloudflare_worker_script" "security_headers" {
  name    = "security-headers"
  content = file("security-headers.js")
}
