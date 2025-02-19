output "dns_updater_scaleway_access_key" {
  description = "The access Key of the IAM API key."
  value       = scaleway_iam_api_key.dns_updater.access_key
  sensitive   = true
}

output "dns_updater_scaleway_secret_key" {
  description = "The secret Key of the IAM API key."
  value       = scaleway_iam_api_key.dns_updater.secret_key
  sensitive   = true
}
