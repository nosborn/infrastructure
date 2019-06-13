output "cloudtrail_bucket_id" {
  value = aws_s3_bucket.cloudtrail.id
}

output "terraform_bucket_id" {
  value = aws_s3_bucket.terraform.id
}
