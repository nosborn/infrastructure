# tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "this" {
  bucket = var.redirect_domain_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

# resource "aws_s3_bucket_policy" "this" {
#   bucket = aws_s3_bucket.this.id
#   policy = data.aws_iam_policy_document.this.json
# }

resource "aws_s3_bucket_public_access_block" "this" {
  bucket              = aws_s3_bucket.this.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

# tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  redirect_all_requests_to {
    host_name = var.domain_name
    protocol  = "https"
  }
}

# data "aws_iam_policy_document" "this" {
#   statement {
#     sid       = "CloudflareGetObject"
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.this.arn}/*"]
#
#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#
#     condition {
#       test     = "IpAddress"
#       variable = "aws:SourceIp"
#       values   = data.cloudflare_ip_ranges.this.cidr_blocks
#     }
#   }
# }
