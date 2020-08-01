resource "aws_s3_bucket" "terraform" {
  bucket_prefix = "terraform-"

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

resource "aws_s3_bucket_policy" "terraform" {
  count = length(var.trusted_ip_addresses) > 0 ? 1 : 0

  bucket = aws_s3_bucket.terraform.id
  policy = data.aws_iam_policy_document.terraform[0].json
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket              = aws_s3_bucket.terraform.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

data "aws_iam_policy_document" "terraform" {
  count = length(var.trusted_ip_addresses) > 0 ? 1 : 0

  statement {
    sid = "1"

    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.terraform.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:sourceIp"
      values   = var.trusted_ip_addresses
    }
  }
}

terraform {
  required_version = "~> 0.12"
}
