resource "aws_iam_user" "dyndns" {
  name = "io-osborn-dyndns"
}

resource "aws_iam_user_policy" "dyndns" {
  policy = "${data.aws_iam_policy_document.dyndns.json}"
  user   = "${aws_iam_user.dyndns.name}"
}

resource "aws_iam_access_key" "dyndns" {
  user = "${aws_iam_user.dyndns.name}"
}

data "aws_iam_policy_document" "dyndns" {
  statement {
    actions = [
      "route53:GetChange",
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
    ]

    resources = ["arn:aws:route53:::hostedzone/${aws_route53_zone.main.zone_id}"]
  }
}
