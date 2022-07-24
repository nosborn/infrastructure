resource "aws_kms_key" "terraform_state" {
  description         = "Terraform State"
  enable_key_rotation = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "terraform" {
  bucket_prefix = "terraform-"
}

resource "aws_s3_bucket_acl" "terraform" {
  bucket = aws_s3_bucket.terraform.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform" {
  bucket                = aws_s3_bucket.terraform.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  rule {
    id     = "Expiration"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform" {
  bucket = aws_s3_bucket.terraform.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "terraform" {
  bucket = aws_s3_bucket.terraform.id
  policy = data.aws_iam_policy_document.terraform.json
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket                  = aws_s3_bucket.terraform.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform" {
  bucket                = aws_s3_bucket.terraform.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.main.arn
      sse_algorithm     = "aws:kms"
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

data "aws_iam_policy_document" "terraform" {
  statement {
    actions   = ["s3:*"]
    effect    = "Deny"
    resources = [aws_s3_bucket.terraform.arn, "${aws_s3_bucket.terraform.arn}/*"]
    sid       = "AllowSSLRequestsOnly"

    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
