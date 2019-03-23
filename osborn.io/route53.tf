locals {
  fastmail_MX = [
    "10 in1-smtp.messagingengine.com.",
    "20 in2-smtp.messagingengine.com.",
  ]
}

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

resource "aws_route53_zone" "main" {
  name = "${var.domain_name}"

  tags {
    Project = "${var.project_tag}"
  }
}

resource "aws_route53_record" "A" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "CAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "CAA"
  ttl     = 86400

  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"amazontrust.com\"",
    "0 issue \"amazonaws.com\"",
    "0 issue \"awstrust.com\"",
  ]
}

resource "aws_route53_record" "MX" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "MX"
  ttl     = 86400
  records = "${local.fastmail_MX}"
}

resource "aws_route53_record" "TXT" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain_name}."
  type    = "TXT"
  ttl     = 86400

  records = [
    "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI",
    "have-i-been-pwned-verification=95d358d9d787ea1f5137f5dd4c207a8a",
    "keybase-site-verification=DUsdjmmiojklIHJHtov-XCzpmRm_iEfM8OxQIb-CINw",
    "protonmail-verification=64d919e28849f07ef74e8c24881ad547805bab3e",
    "v=spf1 include:spf.messagingengine.com ?all",
  ]
}

resource "aws_route53_record" "bing_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "7f33c9bdcbfc881a50d3f5db24af19e9.${var.domain_name}."
  type    = "CNAME"
  ttl     = 86400
  records = ["verify.bing.com."]
}

# https://en.wikipedia.org/wiki/Author_Domain_Signing_Practices
resource "aws_route53_record" "domainkey_adsp_TXT" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_adsp._domainkey.${var.domain_name}."
  type    = "CNAME"
  ttl     = 86400
  records = ["dkim=all"]
}

resource "aws_route53_record" "domainkey_fm_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "fm${count.index + 1}._domainkey.${var.domain_name}."
  type    = "CNAME"
  ttl     = 86400
  records = ["fm${count.index + 1}.${var.domain_name}.dkim.fmhosted.com."]

  count = 3
}

resource "aws_route53_record" "domainkey_mesmtp_CNAME" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "mesmtp._domainkey.${var.domain_name}."
  type    = "CNAME"
  ttl     = 86400
  records = ["mesmtp.${var.domain_name}.dkim.fmhosted.com."]
}

resource "aws_route53_record" "nick_MX" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "nick.${var.domain_name}."
  type    = "MX"
  ttl     = 86400
  records = "${local.fastmail_MX}"
}

resource "aws_route53_record" "tcp_caldav_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._caldav.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "tcp_caldavs_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._caldavs.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 1 443 caldav.fastmail.com."]
}

resource "aws_route53_record" "tcp_carddav_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._carddav.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "tcp_carddavs_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._carddavs.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 1 443 carddav.fastmail.com."]
}

resource "aws_route53_record" "tcp_imap_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._imap.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "tcp_imaps_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._imaps.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 1 993 imap.fastmail.com."]
}

resource "aws_route53_record" "tcp_pop3_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._pop3.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "tcp_pop3s_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._pop3s.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 1 995 pop.fastmail.com."]
}

resource "aws_route53_record" "tcp_submission_SRV" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "_tcp._submission.${var.domain_name}."
  type    = "SRV"
  ttl     = 86400
  records = ["0 1 587 smtp.fastmail.com."]
}

# resource "aws_route53_record" "tombstone_A" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name    = "tombstone.${var.domain_name}."
#   type    = "A"
#   ttl     = 86400
#   records = ["82.69.5.150"]
# }

# resource "aws_route53_record" "tombstone_AAAA" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name    = "tombstone.${var.domain_name}."
#   type    = "AAAA"
#   ttl     = 86400
#   records = [""]
# }

resource "aws_route53_record" "tombstone_CAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "tombstone.${var.domain_name}."
  type    = "CAA"
  ttl     = 86400
  records = ["0 issue \"letsencrypt.org\""]
}

resource "aws_route53_record" "tombstone_MX" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "tombstone.${var.domain_name}."
  type    = "MX"
  ttl     = 86400
  records = "${local.fastmail_MX}"
}

resource "aws_route53_record" "www_A" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_AAAA" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "www.${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = false
  }
}

data "aws_iam_policy_document" "dyndns" {
  statement {
    actions = [
      "route53:GetChange",
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]

    resources = ["arn:aws:route53:::hostedzone/${aws_route53_zone.main.zone_id}"]
  }
}
