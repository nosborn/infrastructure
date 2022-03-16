output "go_teddit_net_name_servers" {
  value       = module.go_teddit_net.name_servers
  description = "Cloudflare-assigned name servers."
}

output "hyperbackup_application_key_id" {
  value       = b2_application_key.hyperbackup.application_key_id
  description = "The ID of the newly created key."
  sensitive   = true
}

output "hyperbackup_bucket_name" {
  value       = b2_bucket.hyperbackup.bucket_name
  description = "The name of the bucket."
  sensitive   = true
}

output "osborn_io_name_servers" {
  value       = module.osborn_io.name_servers
  description = "Cloudflare-assigned name servers."
}

output "osborn_ws_name_servers" {
  value       = module.osborn_ws.name_servers
  description = "Cloudflare-assigned name servers."
}

output "tombstone_cloudflare_api_token" {
  value       = cloudflare_api_token.tombstone.value
  description = "The value of the API Token."
  sensitive   = true
}
