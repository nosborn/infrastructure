resource "aws_s3_bucket" "logs" {
  bucket_prefix = "logs-"
  force_destroy = true
}

# resource "aws_s3_bucket_lifecycle_configuration" "logs" {
#   bucket = aws_s3_bucket.logs.id
#
#   rule {
#     id = "rule-1"
#
#     # ... other transition/expiration actions ...
#
#     status = "Enabled"
#   }
# }

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.logs.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}
