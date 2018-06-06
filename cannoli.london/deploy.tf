resource "aws_iam_user" "deploy" {
  name = "cannoli-deploy"
}

data "aws_iam_policy_document" "deploy" {
  statement {
    actions   = ["cloudfront:GetDistribution", "cloudfront:UpdateDistribution"]
    resources = ["*"]
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.content.arn}"]
  }

  statement {
    actions   = ["s3:DeleteObject", "s3:PutObject"]
    resources = ["${aws_s3_bucket.content.arn}/*"]
  }
}

resource "aws_iam_user_policy" "deploy" {
  name   = "cannoli-deploy"
  user   = "${aws_iam_user.deploy.name}"
  policy = "${data.aws_iam_policy_document.deploy.json}"
}

resource "aws_iam_access_key" "deploy" {
  user = "${aws_iam_user.deploy.name}"
}
