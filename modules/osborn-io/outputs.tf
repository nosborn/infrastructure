output "dns_updater_access_key_id" {
  description = "Access key ID."
  value       = aws_iam_access_key.dns_updater.id
}

output "dns_updater_access_key_secret" {
  description = "Secret access key."
  value       = aws_iam_access_key.dns_updater.secret
  sensitive   = true
}

output "route53_zone_id" {
  value = aws_route53_zone.this.id
}
