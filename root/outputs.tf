output "cloudtrail_bucket_id" {
  value       = aws_s3_bucket.cloudtrail.id
  description = "The name of the bucket."
}

output "terraform_bucket_id" {
  value       = aws_s3_bucket.terraform.id
  description = "The name of the bucket."
}
