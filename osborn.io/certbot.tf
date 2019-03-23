resource "aws_iam_user" "certbot" {
  name = "io-osborn-certbot"
}

resource "aws_iam_user_policy" "certbot" {
  policy = "${data.aws_iam_policy_document.certbot.json}"
  user   = "${aws_iam_user.certbot.name}"
}

resource "aws_iam_access_key" "certbot" {
  user = "${aws_iam_user.certbot.name}"
}

data "aws_iam_policy_document" "certbot" {
  statement {
    actions = [
      "route53:GetChange",
      "route53:ListHostedZones"
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/${aws_route53_zone.main.zone_id}"]
  }
}
