# resource "aws_cloudfront_response_headers_policy" "security" {
#   name = "security-headers-policy"
#
#   custom_headers_config {
#     items {
#       header   = "Expect-CT"
#       override = true
#       value    = "enforce, max-age=30, report-uri=\"https://osborn.report-uri.com/r/d/ct/enforce\""
#     }
#
#     items {
#       header   = "Permissions-Policy"
#       override = true
#       value    = "interest-cohort=()"
#     }
#   }
#
#   security_headers_config {
#     content_security_policy {
#       content_security_policy = "default-src 'none'; style-src 'self'; report-uri https://osborn.report-uri.com/r/d/csp/enforce"
#       override                = true
#     }
#
#     content_type_options {
#       override = true
#     }
#
#     frame_options {
#       frame_option = "SAMEORIGIN"
#       override     = true
#     }
#
#     referrer_policy {
#       referrer_policy = "strict-origin-when-cross-origin"
#       override        = true
#     }
#
#     strict_transport_security {
#       access_control_max_age_sec = 31536000
#       include_subdomains         = true
#       override                   = true
#       preload                    = true
#     }
#
#     xss_protection {
#       mode_block = true
#       override   = true
#       protection = true
#     }
#   }
# }

# resource "aws_cloudfront_distribution" "website" {
#   enabled             = true
#   is_ipv6_enabled     = true
#   default_root_object = "index.html"
#   aliases             = local.domain_name
#   tags                = var.tags
#
#   origin {
#     domain_name = "osborn.io.s3.amazonaws.com"
#     origin_id   = "s3-cloudfront"
#
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
#     }
#   }
#
#   default_cache_behavior {
#     allowed_methods = [
#       "GET",
#       "HEAD",
#     ]
#
#     cached_methods = [
#       "GET",
#       "HEAD",
#     ]
#
#     target_origin_id = "s3-cloudfront"
#
#     forwarded_values {
#       query_string = false
#
#       cookies {
#         forward = "none"
#       }
#     }
#
#     viewer_protocol_policy = "redirect-to-https"
#
#     # https://stackoverflow.com/questions/67845341/cloudfront-s3-etag-possible-for-cloudfront-to-send-updated-s3-object-before-t
#     min_ttl     = var.cloudfront_min_ttl
#     default_ttl = var.cloudfront_default_ttl
#     max_ttl     = var.cloudfront_max_ttl
#   }
#
#   price_class = var.price_class
#
#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
#
#   dynamic "viewer_certificate" {
#     for_each = local.default_certs
#
#     content {
#       cloudfront_default_certificate = true
#     }
#   }
#
#   dynamic "viewer_certificate" {
#     for_each = local.acm_certs
#
#     content {
#       acm_certificate_arn      = data.aws_acm_certificate.acm_cert[0].arn
#       ssl_support_method       = "sni-only"
#       minimum_protocol_version = "TLSv1"
#     }
#   }
#
#   custom_error_response {
#     error_code            = 403
#     response_code         = 200
#     error_caching_min_ttl = 0
#     response_page_path    = "/index.html"
#   }
#
#   wait_for_deployment = false
#
#   depends_on = [
#     aws_s3_bucket.this,
#   ]
# }
