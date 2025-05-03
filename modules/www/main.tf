resource "scaleway_domain_record" "a" {
  for_each = toset([
    "",
    "www",
  ])

  data     = "95.217.26.94"
  dns_zone = var.domain_name
  name     = each.key
  ttl      = 60
  type     = "A"
}

resource "scaleway_domain_record" "aaaa" {
  for_each = toset([
    "",
    "www",
  ])

  data     = "2a01:4f9:c01f:8002::"
  dns_zone = var.domain_name
  name     = each.key
  ttl      = 60
  type     = "AAAA"
}
