output "dns_updater_scaleway_api_token" {
  description = "The secret Key of the IAM API key."
  value       = scaleway_iam_api_key.dns_updater.secret_key
  sensitive   = true
}

output "lego_scaleway_api_token" {
  description = "The secret Key of the IAM API key."
  value       = scaleway_iam_api_key.lego.secret_key
  sensitive   = true
}
