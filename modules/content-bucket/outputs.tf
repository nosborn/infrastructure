output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the bucket."
}

output "id" {
  value       = aws_s3_bucket.this.id
  description = "The name of the bucket."
}

output "regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "The bucket region-specific domain name."
}
