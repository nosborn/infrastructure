resource "aws_s3_bucket" "this" {
  bucket = var.domain_name
  tags   = var.tags

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_expiration {
      days = 10
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

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = false # TODO: true
  block_public_policy     = false # TODO: true
  ignore_public_acls      = false # TODO: true
  restrict_public_buckets = false # TODO: true
}

data "aws_iam_policy_document" "this" {
  # statement {
  #   sid       = "AllowSSLRequestsOnly"
  #   actions   = ["s3:*"]
  #   effect    = "Deny"
  #   resources = [aws_s3_bucket.this.arn, "${aws_s3_bucket.this.arn}/*"]
  #
  #   principals {
  #     type        = "*"
  #     identifiers = ["*"]
  #   }
  #
  #   condition {
  #     test     = "Bool"
  #     variable = "aws:SecureTransport"
  #     values   = [false]
  #   }
  # }

  statement {
    sid       = "CloudflareGetObject"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = data.cloudflare_ip_ranges.this.cidr_blocks
    }
  }
}

data "cloudflare_ip_ranges" "this" {}
