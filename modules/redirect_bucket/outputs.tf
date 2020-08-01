output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the bucket."
}

output "website_endpoint" {
  value       = aws_s3_bucket.this.website_endpoint
  description = "The domain of the website endpoint. This is used to create Route 53 alias records."
}
