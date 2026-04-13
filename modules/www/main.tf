resource "hcloud_zone_rrset" "a" {
  for_each = toset([
    "@",
    "www",
  ])

  name = each.key
  type = "A"
  zone = var.domain_name

  records = [
    {
      value = "95.217.26.94"
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "aaaa" {
  for_each = toset([
    "@",
    "www",
  ])

  name = each.key
  type = "AAAA"
  zone = var.domain_name

  records = [
    {
      value = "2a01:4f9:c01f:8002::"
    },
  ]
}
