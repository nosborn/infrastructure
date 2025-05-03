resource "scaleway_domain_record" "a" {
  data     = "95.217.26.94"
  dns_zone = var.domain_name
  name     = "mta-sts"
  type     = "A"
}

resource "scaleway_domain_record" "aaaa" {
  data     = "2a01:4f9:c01f:8002::"
  dns_zone = var.domain_name
  name     = "mta-sts"
  type     = "AAAA"
}

resource "scaleway_domain_record" "txt" {
  data     = "v=STSv1; id=${var.id}"
  dns_zone = var.domain_name
  name     = "_mta-sts"
  type     = "TXT"
}
