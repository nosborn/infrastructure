resource "aws_s3_bucket" "cloudtrail" {
  bucket_prefix = "cloudtrail-"
  acl           = "private"
  region        = "ap-southeast-1"

  tags = {
    Project = "${var.project_tag}"
  }

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

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"
  policy = "${data.aws_iam_policy_document.cloudtrail.json}"
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "Global"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail.id}"
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true

  tags = {
    Project = "${var.project_tag}"
  }

  depends_on = ["aws_s3_bucket_policy.cloudtrail"]
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid       = "AWSCloudTrailAclCheck"
    actions   = ["s3:GetBucketAcl"]
    resources = ["${aws_s3_bucket.cloudtrail.arn}"]

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
