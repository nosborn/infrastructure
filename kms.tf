resource "aws_kms_key" "dnssec" {
  provider = aws.us-east-1

  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = 7
  key_usage                = "SIGN_VERIFY"
  policy                   = data.aws_iam_policy_document.kms_key_dnssec.json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_key" "main" {
  deletion_window_in_days = 7

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "kms_key_dnssec" {
  statement {
    sid       = "Allow Route 53 DNSSEC Service"
    actions   = ["kms:DescribeKey", "kms:GetPublicKey", "kms:Sign"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "aws:SourceAccount"
    }

    condition {
      test     = "ArnLike"
      values   = ["arn:aws:route53:::hostedzone/*"]
      variable = "aws:SourceArn"
    }

    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }

  statement {
    sid       = "Allow Route 53 DNSSEC Service to CreateGrant"
    actions   = ["kms:CreateGrant"]
    resources = ["*"]

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
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
