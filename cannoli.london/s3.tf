resource "aws_s3_bucket" "content" {
  bucket = "osborn-io-cannoli" # TODO: "${data.aws_iam_account_alias.current.account_alias}-cannoli"
  acl    = "private"
  region = "eu-west-2"

  tags {
    Project = "${var.project_tag}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

data "aws_iam_policy_document" "content_policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.content.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
    }
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = ["${aws_s3_bucket.content.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "content" {
  bucket = "${aws_s3_bucket.content.id}"
  policy = "${data.aws_iam_policy_document.content_policy.json}"
}