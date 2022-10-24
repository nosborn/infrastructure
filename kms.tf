resource "aws_kms_key" "dnssec" {
  provider = aws.us-east-1

  description              = "DNSSEC"
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256"
  policy                   = data.aws_iam_policy_document.kms_key_dnssec.json
  deletion_window_in_days  = 7

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_alias" "dnssec" {
  provider = aws.us-east-1

  name          = "alias/dnssec"
  target_key_id = aws_kms_key.dnssec.key_id
}

resource "aws_kms_key" "main" {
  deletion_window_in_days = 7

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/main"
  target_key_id = aws_kms_key.main.key_id
}

data "aws_iam_policy_document" "kms_key_dnssec" {
  statement {
    actions   = ["kms:DescribeKey", "kms:GetPublicKey", "kms:Sign"]
    resources = ["*"]
    sid       = "Allow Route 53 DNSSEC Service"

    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "aws:SourceAccount"
    }

    # condition {
    #   test     = "ArnLike"
    #   values   = ["arn:aws:route53:::hostedzone/*"]
    #   variable = "aws:SourceArn"
    # }

    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }

  statement {
    actions   = ["kms:CreateGrant"]
    resources = ["*"]
    sid       = "Allow Route 53 DNSSEC Service to CreateGrant"

    condition {
      test     = "Bool"
      values   = ["true"]
      variable = "kms:GrantIsForAWSResource"
    }

    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }

  statement {
    actions   = ["kms:*"]
    resources = ["*"]
    sid       = "Enable IAM User Permissions"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
