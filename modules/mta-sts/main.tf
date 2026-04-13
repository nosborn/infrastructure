resource "hcloud_zone_rrset" "a" {
  name = "mta-sts"
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
  name = "mta-sts"
  type = "AAAA"
  zone = var.domain_name

  records = [
    {
      value = "2a01:4f9:c01f:8002::"
    },
  ]
}

resource "hcloud_zone_rrset" "txt" {
  name = "_mta-sts"
  type = "TXT"
  zone = var.domain_name

  records = [
    {
      value = provider::hcloud::txt_record("v=STSv1; id=${var.id}")
    },
  ]
}
