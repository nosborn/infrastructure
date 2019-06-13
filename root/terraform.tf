resource "aws_s3_bucket" "terraform" {
  bucket_prefix = "terraform-"
  acl           = "private"
  region        = "ap-southeast-1"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      days = 90
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket              = aws_s3_bucket.terraform.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

terraform {
  required_version = "~> 0.12"
}
