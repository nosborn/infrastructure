resource "aws_cloudtrail" "main" {
  depends_on = [
    aws_iam_role_policy.cloudtrail_logs,
    aws_s3_bucket_policy.cloudtrail,
  ]

  name                          = "Global"
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_logs.arn
  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "aws-cloudtrail-logs-${data.aws_caller_identity.current.account_id}"
  retention_in_days = 30
}

resource "aws_iam_role" "cloudtrail_logs" {
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_logs_assume_role.json
  name               = "CloudTrailRoleForCloudWatchLogs-Global"
}

resource "aws_iam_role_policy" "cloudtrail_logs" {
  name_prefix = "CloudTrailPolicyForCloudWatchLogs-"
  role        = aws_iam_role.cloudtrail_logs.name
  policy      = data.aws_iam_policy_document.cloudtrail_logs.json
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

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = data.aws_iam_policy_document.cloudtrail.json
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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

data "aws_iam_policy_document" "cloudtrail_logs" {
  # tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    sid       = "AWSCloudTrailCreateLogStream2014110"
    actions   = ["logs:CreateLogStream"]
    resources = ["${aws_cloudwatch_log_group.cloudtrail.arn}:log-stream:*"]
  }

  # tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    sid       = "AWSCloudTrailPutLogEvents20141101"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.cloudtrail.arn}:log-stream:*"]
  }
}

data "aws_iam_policy_document" "cloudtrail_logs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}
