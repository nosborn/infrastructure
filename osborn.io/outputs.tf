output "hyperbackup_application_key" {
  value     = b2_application_key.hyperbackup.application_key
  sensitive = true
}

output "hyperbackup_application_key_id" {
  value = b2_application_key.hyperbackup.application_key_id
}

output "hyperbackup_bucket_name" {
  value       = b2_bucket.hyperbackup.bucket_name
  description = "The name of the bucket."
}

output "tombstone_cloudflare_api_token" {
  value     = cloudflare_api_token.tombstone.value
  sensitive = true
}
