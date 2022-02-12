resource "aws_s3_bucket" "terraform" {
  bucket_prefix = "terraform-"
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform" {
  bucket                = aws_s3_bucket.terraform.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  rule {
    id     = "config"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform" {
  bucket                = aws_s3_bucket.terraform.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform" {
  bucket                = aws_s3_bucket.terraform.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket              = aws_s3_bucket.terraform.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}
