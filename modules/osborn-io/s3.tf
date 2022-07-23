# resource "aws_s3_bucket" "website" {
#   bucket = "osborn.io"
#   policy = data.aws_iam_policy_document.website.json
#   tags   = var.tags
# }
#
# resource "aws_s3_bucket_acl" "website" {
#   bucket = aws_s3_bucket.website.bucket
#   acl    = "private"
# }
#
# resource "aws_s3_bucket_website_configuration" "website" {
#   bucket = aws_s3_bucket.website.bucket
#
#   index_document {
#     suffix = "index.html"
#   }
# }
#
# resource "aws_s3_bucket" "redirect" {
#   bucket = "www.osborn.io"
#   tags   = var.tags
# }
#
# resource "aws_s3_bucket_acl" "redirect" {
#   bucket = aws_s3_bucket.redirect.bucket
#   acl    = "private"
# }
#
# resource "aws_s3_bucket_website_configuration" "redirect" {
#   bucket = aws_s3_bucket.redirect.bucket
#
#   redirect_all_requests_to {
#     host_name = aws_s3_bucket.website.bucket
#     protocol  = "https"
#   }
# }
#
# data "aws_iam_policy_document" "website" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["arn:aws:s3:::osborn.io/*"]
#
#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.website.iam_arn]
#     }
#   }
# }
#
# data "aws_iam_policy_document" "redirect" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["arn:aws:s3:::www.osborn.io/*"]
#
#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.website.iam_arn]
#     }
#   }
# }
