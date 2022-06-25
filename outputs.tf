output "go_teddit_net_name_servers" {
  value       = module.go_teddit_net.name_servers
  description = "Cloudflare-assigned name servers."
}

output "osborn_io_name_servers" {
  value       = module.osborn_io.name_servers
  description = "Cloudflare-assigned name servers."
}

output "osborn_ws_name_servers" {
  value       = module.osborn_ws.name_servers
  description = "Cloudflare-assigned name servers."
}
