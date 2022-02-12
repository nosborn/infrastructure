output "hyperbackup_application_key" {
  value       = b2_application_key.hyperbackup.application_key
  description = "The key."
  sensitive   = true
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

output "tombstone_cloudflare_api_token" {
  value       = cloudflare_api_token.tombstone.value
  description = "The value of the API Token."
  sensitive   = true
}
