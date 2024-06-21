output "logs_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.logs.id
}

output "osborn_io_dns_updater_access_key_id" {
  description = "Access key ID."
  value       = module.osborn_io.dns_updater_access_key_id
}

output "osborn_io_dns_updater_access_key_secret" {
  description = "Secret access key."
  value       = module.osborn_io.dns_updater_access_key_secret
  sensitive   = true
}

output "osborn_ws_name_servers" {
  description = "A list of name servers in associated (or default) delegation set."
  value       = module.osborn_ws.name_servers
}
