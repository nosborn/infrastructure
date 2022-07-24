locals {
  function_code = templatefile("${path.module}/viewer-request.js.tpl", {
    host           = var.domain_name,
    redirect_hosts = join(",", formatlist("\"%s\"", var.redirect_domain_names))
  })
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.domain_name

  lifecycle {
    create_before_destroy = true
  }
}

# tfsec:ignore:aws-cloudfront-enable-waf
resource "aws_cloudfront_distribution" "this" {
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

    dynamic "function_association" {
      for_each = length(var.redirect_domain_names) > 0 ? [true] : []

      content {
        event_type   = "viewer-request"
        function_arn = aws_cloudfront_function.this[0].arn
      }
    }
  }

  origin {
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
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
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_cloudfront_response_headers_policy" "this" {
  name = "${join("-", reverse(split(".", var.domain_name)))}-custom-security-headers"

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

resource "aws_cloudfront_function" "this" {
  count = length(var.redirect_domain_names) > 0 ? 1 : 0

  name    = random_id.function_name[0].hex
  code    = templatefile("${path.module}/viewer-request.js.tpl", { host = var.domain_name, redirect_hosts = join(",", formatlist("\"%s\"", var.redirect_domain_names)) })
  runtime = "cloudfront-js-1.0"

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_id" "function_name" {
  count = length(var.redirect_domain_names) > 0 ? 1 : 0

  byte_length = 4
  prefix      = "viewer-request-"

  keepers = {
    function_code_hash = sha1(local.function_code)
  }
}
