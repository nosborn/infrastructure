output "atlantis_access_key_id" {
  value       = aws_iam_access_key.atlantis.id
  description = "Access key ID."
  sensitive   = true
}

output "atlantis_access_key_secret" {
  value       = aws_iam_access_key.atlantis.encrypted_secret
  description = "Secret access key."
  sensitive   = true
}

output "terraform_bucket_id" {
  value       = aws_s3_bucket.terraform.id
  description = "The name of the bucket."
}
