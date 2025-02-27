output "scaleway_domain_zone_id" {
  description = "The unique identifier of the zone."
  value       = data.scaleway_domain_zone.this.domain
}
