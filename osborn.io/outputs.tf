output "dns_servers" {
  value = "${split(",", ns1_zone.main.dns_servers)}"
}
