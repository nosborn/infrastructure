output "name_servers" {
  value       = cloudflare_zone.main.name_servers
  description = "Cloudflare-assigned name servers."
}
