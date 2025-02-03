resource "scaleway_domain_record" "mta_sts" {
  data     = "v=STSv1; id=${var.id}"
  dns_zone = var.domain_name
  name     = "_mta-sts"
  type     = "TXT"
}

resource "scaleway_container" "this" {
  cpu_limit      = 100
  deploy         = true
  http_option    = "redirected"
  max_scale      = 1
  memory_limit   = 128
  min_scale      = 1
  name           = "mta-sts"
  namespace_id   = var.container_namespace_id
  registry_image = "${var.container_registry_endpoint}/mta-sts:latest"
}

resource "scaleway_domain_record" "alias" {
  data     = "${scaleway_container.this.domain_name}."
  dns_zone = var.domain_name
  name     = "mta-sts"
  ttl      = 300
  type     = "ALIAS"
}

resource "scaleway_container_domain" "this" {
  container_id = scaleway_container.this.id
  hostname     = "mta-sts.${var.domain_name}"

  depends_on = [
    scaleway_domain_record.alias,
  ]
}
