resource "aws_cloudtrail" "cloudtrail" {
  depends_on = [aws_s3_bucket_policy.cloudtrail]

  name                          = "Global"
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket_prefix = "cloudtrail-"
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail" {
  bucket                = aws_s3_bucket.cloudtrail.id
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

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail" {
  bucket                = aws_s3_bucket.cloudtrail.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "cloudtrail" {
  bucket                = aws_s3_bucket.cloudtrail.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = data.aws_iam_policy_document.cloudtrail.json
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket              = aws_s3_bucket.cloudtrail.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid       = "AWSCloudTrailAclCheck"
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail.arn]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
