output "certbot_access_key_id" {
  value = "${aws_iam_access_key.certbot.id}"
}

output "certbot_secret_access_key" {
  value = "${aws_iam_access_key.certbot.secret}"
}

output "cloudfront_distribution_id" {
  value = "${aws_cloudfront_distribution.main.id}"
}

output "content_bucket_id" {
  value = "${aws_s3_bucket.content.id}"
}

output "deploy_access_key_id" {
  value = "${aws_iam_access_key.deploy.id}"
}

output "deploy_secret_access_key" {
  value = "${aws_iam_access_key.deploy.secret}"
}

output "dyndns_access_key_id" {
  value = "${aws_iam_access_key.dyndns.id}"
}

output "dyndns_secret_access_key" {
  value = "${aws_iam_access_key.dyndns.secret}"
}

output "name_servers" {
  value = "${aws_route53_zone.main.name_servers}"
}
