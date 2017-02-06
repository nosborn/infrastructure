resource "aws_s3_bucket" "cloudtrail" {
  bucket = "${data.aws_iam_account_alias.current.account_alias}-cloudtrail"
  acl    = "private"
  region = "eu-west-1"

  tags {
    Project = "${var.project_tag}"
  }

  versioning {
    enabled    = true
  # mfa_delete = true
  }
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

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"
  policy = "${data.aws_iam_policy_document.cloudtrail.json}"
}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "Global"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail.id}"
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true

  tags {
    Project = "${var.project_tag}"
  }
}
