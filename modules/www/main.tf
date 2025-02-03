resource "scaleway_container" "this" {
  cpu_limit      = 100
  deploy         = true
  http_option    = "redirected"
  max_scale      = 1
  memory_limit   = 128
  min_scale      = 1
  name           = "www"
  namespace_id   = var.container_namespace_id
  registry_image = "${var.container_registry_endpoint}/www:latest"
}

resource "scaleway_domain_record" "this" {
  for_each = toset([
    "",
    "www",
  ])

  data     = "${scaleway_container.this.domain_name}."
  dns_zone = var.domain_name
  name     = each.key
  ttl      = 60
  type     = "ALIAS"

  depends_on = [
    scaleway_container_domain.this,
  ]
}

resource "scaleway_container_domain" "this" {
  for_each = toset([
    "www.${var.domain_name}",
    var.domain_name,
  ])

  container_id = scaleway_container.this.id
  hostname     = each.key
}
