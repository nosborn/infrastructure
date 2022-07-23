output "osborn_ws_name_servers" {
  value       = module.osborn_ws.name_servers
  description = "A list of name servers in associated (or default) delegation set."
}
