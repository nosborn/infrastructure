resource "aws_s3_bucket" "content" {
  bucket_prefix = "io-osborn-content-"
  acl           = "private"
  region        = "ap-southeast-1"

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

resource "aws_s3_bucket_policy" "content" {
  bucket = "${aws_s3_bucket.content.id}"
  policy = "${data.aws_iam_policy_document.content.json}"
}

data "aws_iam_policy_document" "content" {
  statement {
    sid       = ""
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.content.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
    }
  }
}
