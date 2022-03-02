output "name_servers" {
  value       = cloudflare_zone.this.name_servers
  description = "Cloudflare-assigned name servers."
}
