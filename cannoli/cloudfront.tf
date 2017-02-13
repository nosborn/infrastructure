resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}

resource "aws_cloudfront_distribution" "distribution" {
  aliases             = ["${var.domain_name}"]
  comment             = "London Cannoli Map"
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    default_ttl            = 300
    max_ttl                = 600
    min_ttl                = 0
    target_origin_id       = "S3-cannoli"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = "${aws_s3_bucket.content.bucket_domain_name}"
    origin_id   = "S3-cannoli"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Project = "${var.project_tag}"
  }

  viewer_certificate {
    acm_certificate_arn      = "${aws_cloudformation_stack.certificate.outputs.CertificateId}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }
}
