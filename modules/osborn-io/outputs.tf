output "cloudflare_zone_id" {
  value       = cloudflare_zone.this.id
  description = "The zone ID."
}

output "name_servers" {
  value       = cloudflare_zone.this.name_servers
  description = "Cloudflare-assigned name servers."
}
