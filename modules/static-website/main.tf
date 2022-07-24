resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.domain_name
}

module "acm_certificate" {
  source = "../acm-certificate"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  domain_name               = var.domain_name
  tags                      = var.tags
  subject_alternative_names = var.redirect_domain_names
  zone_id                   = var.zone_id
}

# tfsec:ignore:aws-cloudfront-enable-waf
resource "aws_cloudfront_distribution" "this" {
  depends_on = [
    module.acm_certificate,
    module.content_bucket,
  ]

  aliases             = compact(concat([var.domain_name], var.redirect_domain_names))
  comment             = var.domain_name
  default_root_object = var.default_root_object
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  tags                = var.tags

  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    response_headers_policy_id = aws_cloudfront_response_headers_policy.this.id
    target_origin_id           = "s3"
    viewer_protocol_policy     = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = module.content_bucket.regional_domain_name
    origin_id   = "s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = module.acm_certificate.arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_cloudfront_response_headers_policy" "this" {
  name = join("-", reverse(split(".", var.domain_name)))

  custom_headers_config {
    items {
      header   = "Expect-CT"
      override = true
      value    = "enforce, max-age=30, report-uri=\"https://osborn.report-uri.com/r/d/ct/enforce\""
    }

    items {
      header   = "Permissions-Policy"
      override = true
      value    = "interest-cohort=()"
    }
  }

  security_headers_config {
    content_security_policy {
      content_security_policy = var.content_security_policy
      override                = true
    }

    content_type_options {
      override = true
    }

    frame_options {
      override     = true
      frame_option = "SAMEORIGIN"
    }

    referrer_policy {
      override        = true
      referrer_policy = "strict-origin-when-cross-origin"
    }

    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = true
      override                   = true
      preload                    = var.strict_transport_security_preload
    }

    xss_protection {
      mode_block = true
      override   = true
      protection = true
    }
  }
}

module "content_bucket" {
  source = "../content-bucket"

  domain_name                = var.domain_name
  origin_access_identity_arn = aws_cloudfront_origin_access_identity.this.iam_arn
  tags                       = var.tags
}

module "redirect_bucket" {
  for_each = toset(var.redirect_domain_names)
  source   = "../redirect-bucket"

  domain_name          = var.domain_name
  redirect_domain_name = each.value
  tags                 = var.tags
}

resource "aws_route53_record" "a" {
  for_each = toset(compact(concat([var.domain_name], var.redirect_domain_names)))

  zone_id = var.zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aaaa" {
  for_each = toset(compact(concat([var.domain_name], var.redirect_domain_names)))

  zone_id = var.zone_id
  name    = each.value
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}
