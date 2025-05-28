output "cloudsync_b2_application_key" {
  description = "The key."
  value       = b2_application_key.cloudsync.application_key
  sensitive   = true
}

output "cloudsync_b2_application_key_id" {
  description = "The ID of the key."
  value       = b2_application_key.cloudsync.application_key_id
  sensitive   = true
}

output "dns_updater_scaleway_api_token" {
  description = "The secret Key of the IAM API key."
  value       = scaleway_iam_api_key.dns_updater.secret_key
  sensitive   = true
}

output "hyperbackup_b2_application_key" {
  description = "The key."
  value       = b2_application_key.hyperbackup.application_key
  sensitive   = true
}

output "hyperbackup_b2_application_key_id" {
  description = "The ID of the key."
  value       = b2_application_key.hyperbackup.application_key_id
  sensitive   = true
}

output "lego_scaleway_api_token" {
  description = "The secret Key of the IAM API key."
  value       = scaleway_iam_api_key.lego.secret_key
  sensitive   = true
}
