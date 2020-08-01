resource "aws_iam_access_key" "deploy" {
  user = aws_iam_user.deploy.name
}

resource "aws_iam_user" "deploy" {
  name = "london-cannoli-deploy"

  tags = {
    Project = var.domain_name
  }
}

resource "aws_iam_user_policy" "deploy" {
  policy      = data.aws_iam_policy_document.deploy.json
  name_prefix = "${aws_iam_user.deploy.name}-"
  user        = aws_iam_user.deploy.name
}

data "aws_iam_policy_document" "deploy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.content_bucket.arn]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = ["${module.content_bucket.arn}/*"]
  }
}
