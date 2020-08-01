output "deploy_access_key_id" {
  value = aws_iam_access_key.deploy.id
}

output "deploy_secret_access_key" {
  value = aws_iam_access_key.deploy.secret
}

output "name_servers" {
  value       = cloudflare_zone.main.name_servers
  description = "Cloudflare-assigned name servers."
}
